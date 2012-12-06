//
//  UIScrollViewDisplayManger.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import "EKKeyboardAvoidingScrollViewManger.h"

@interface RegisteredScrollPack : NSObject
@property (nonatomic, assign) UIScrollView *scrollView;
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
@property (atomic, assign, readwrite) CGRect keyboardFrame;
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
                                               selector:@selector(keyboardFrameDidChange:)
                                                     name:UIKeyboardDidChangeFrameNotification
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

- (void) keyboardFrameDidChange:(NSNotification *) notification
{
    NSValue *keyboardFrameValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    [self setKeyboardFrame:[keyboardFrameValue CGRectValue]];
    [self updateRegisteredScrolls];
    
    NSLog(@"scrolls count = %d",[registeredScrolls count]);
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
    UIEdgeInsets insets = [scrollPack scrollDefaultInsets];

    CGRect scrollViewFrame = [[scrollPack scrollView] frame];
    CGRect keyboardRect = [[[scrollPack scrollView] superview] convertRect:[self keyboardFrame]
                                                                  fromView:nil];
    if (CGRectIntersectsRect(keyboardRect, scrollViewFrame) &&
        !CGRectEqualToRect(keyboardRect, CGRectZero) &&
        !CGRectContainsRect(keyboardRect, scrollViewFrame))
    {
        if (keyboardRect.origin.y <= scrollViewFrame.origin.y) {
            insets.top += CGRectGetMaxY(keyboardRect) - CGRectGetMinY(scrollViewFrame);
        }
        else if (keyboardRect.origin.y <= CGRectGetMaxY(scrollViewFrame) &&
                 CGRectGetMaxY(keyboardRect) >= CGRectGetMaxY(scrollViewFrame)) {
            insets.bottom += CGRectGetMaxY(scrollViewFrame) - CGRectGetMinY(keyboardRect);
        }
    }
    return insets;
}

@end
