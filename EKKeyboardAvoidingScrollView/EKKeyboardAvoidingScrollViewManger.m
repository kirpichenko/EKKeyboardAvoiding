//
//  UIScrollViewDisplayManger.m
//  MyQuiz
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import "EKKeyboardAvoidingScrollViewManger.h"

@interface RegisteredScrollPack : NSObject
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets scrollDefaultInsets;
@end

@implementation RegisteredScrollPack

- (void) dealloc
{
    [self setScrollView:nil];
    [super dealloc];
}

@end

static EKKeyboardAvoidingScrollViewManger *kUIScrollViewDisplayManager;

@interface EKKeyboardAvoidingScrollViewManger ()
@property (atomic, assign) CGRect keyboardFrame;
@end

@implementation EKKeyboardAvoidingScrollViewManger

+ (id) sharedInstance
{
    @synchronized (self) {
        if (kUIScrollViewDisplayManager == nil) {
            kUIScrollViewDisplayManager = [[self alloc] init];
        }
    }
    return kUIScrollViewDisplayManager;
}

- (id) init
{
    if (self = [super init]) {
        registeredScrolls = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(keyboardFrameWillChange:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
    }
    return self;
}

- (void) dealloc
{
    [registeredScrolls release];
    [super dealloc];
}

#pragma mark -
#pragma mark public methods

- (void) registerScrollViewForKeyboardAvoiding:(UIScrollView *) scrollView
{
   @synchronized(self) {
       RegisteredScrollPack *scrollPack = [self registeredScrollForView:scrollView];
       if (scrollPack == nil) {
           scrollPack = [self prepareScrollPackWithScrollView:scrollView];
           [registeredScrolls addObject:scrollPack];
           [self updateRegisteredScroll:scrollPack];
       }
    }
}

- (void) unregisterScrollViewFromKeyboardAvoiding:(UIScrollView *) scrollView
{
    @synchronized(self) {
        if (scrollView != nil) {
            RegisteredScrollPack *scrollPack = [self registeredScrollForView:scrollView];
            if (scrollPack != nil) {
                [scrollView setContentInset:[scrollPack scrollDefaultInsets]];
                [registeredScrolls removeObject:scrollPack];
            }
        }
    }
}

- (void) updateRegisteredScrolls
{
    @synchronized (self) {
        for (RegisteredScrollPack *scrollPack in registeredScrolls) {
            [self updateRegisteredScroll:scrollPack];
        }
    }
}

#pragma mark -
#pragma mark notifications

- (void) keyboardFrameWillChange:(NSNotification *) notification
{
    NSValue *keyboardFrameValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    [self setKeyboardFrame:[keyboardFrameValue CGRectValue]];
    [self updateRegisteredScrolls];
}

#pragma mark -
#pragma mark helpers

- (RegisteredScrollPack *) prepareScrollPackWithScrollView:(UIScrollView *) scrollView
{
    RegisteredScrollPack *scrollPack = [[RegisteredScrollPack alloc] init];
    [scrollPack setScrollView:scrollView];
    [scrollPack setScrollDefaultInsets:[scrollView contentInset]];
    return [scrollPack autorelease];
}

- (RegisteredScrollPack *) registeredScrollForView:(UIScrollView *) scrollView
{
    @synchronized (self) {
        for (RegisteredScrollPack *scrollPack in registeredScrolls) {
            if ([scrollPack scrollView] == scrollView) {
                return scrollPack;
            }
        }
        return nil;
    }
}

- (void) updateRegisteredScroll:(RegisteredScrollPack *) scrollPack
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         UIEdgeInsets insets = [self scrollViewContentInsets:scrollPack];
                         [[scrollPack scrollView] setContentInset:insets];
                         [[scrollPack scrollView] setScrollIndicatorInsets:insets];
                     }];
}

#pragma mark -
#pragma mark count insets

- (UIEdgeInsets) scrollViewContentInsets:(RegisteredScrollPack *) scrollPack
{
    UIScrollView *scrollView = [scrollPack scrollView];    
    CGRect frameInWindow = [[scrollView superview] convertRect:[scrollView frame] toView:nil];
    if (!CGRectIntersectsRect(frameInWindow, [self keyboardFrame])) {
        return [scrollPack scrollDefaultInsets];
    }
    
    UIEdgeInsets insets = [scrollPack scrollDefaultInsets];
    CGRect keyboardFrame = [self keyboardFrame];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationPortrait) {
        NSLog(@"maxy = %f, miny = %f",CGRectGetMaxY(frameInWindow),CGRectGetMinY(keyboardFrame));
        insets.bottom += MAX(CGRectGetMaxY(frameInWindow) - CGRectGetMinY(keyboardFrame), 0);
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        insets.bottom += MAX(CGRectGetMaxX(frameInWindow) - CGRectGetMinX(keyboardFrame),0);
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight) {
        insets.bottom += MAX(CGRectGetMaxX(keyboardFrame) - CGRectGetMinX(frameInWindow),0);
    }
    
    NSLog(@"insets = %@",NSStringFromUIEdgeInsets(insets));
    
    return insets;
}

@end
