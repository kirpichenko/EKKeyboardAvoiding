//
//  UIScrollViewDisplayManger.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import "EKKeyboardAvoidingScrollViewManger.h"
#import "CGRectTransform.h"

#import <objc/objc-runtime.h>

@interface RegisteredScrollPack : NSObject
@property (nonatomic, assign) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets scrollDefaultInsets;
@end

@implementation RegisteredScrollPack
@end


//NSString *const kFrameKeyPath = @"frame";

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
           
//           [scrollView addObserver:self
//                        forKeyPath:kFrameKeyPath
//                           options:NSKeyValueObservingOptionNew
//                           context:nil];
       }
    }
}

- (void) unregisterScrollViewFromKeyboardAvoiding:(UIScrollView *) scrollView
{
    @synchronized(self) {
        if (scrollView != nil) {
            RegisteredScrollPack *scrollPack = [self registeredScrollForView:scrollView];
            if (scrollPack != nil) {
                [scrollView window];
                [scrollView setContentInset:[scrollPack scrollDefaultInsets]];
//                [scrollView removeObserver:self forKeyPath:kFrameKeyPath context:nil];
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
    
    NSLog(@"keyboardframe = %@",NSStringFromCGRect([self keyboardFrame]));
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
    
    CGRect scrollViewFrame = [[scrollView superview] convertRect:[scrollView frame] toView:nil];
    NSLog(@"wind scrollviewframe = %@",NSStringFromCGRect(scrollViewFrame));
                           //                                                                  fromView:nil];
    
    CGRect transformedScrollFrame = [self transformCGRectToDefaultCoordinates:scrollViewFrame];
    CGRect transformedKeyboardFrame = [self transformCGRectToDefaultCoordinates:[self keyboardFrame]];

    
    
    
    UIEdgeInsets inset = [self contentInsetWithDefaultInset:[scrollPack scrollDefaultInsets]
                                                  viewFrame:transformedScrollFrame
                                              keyboardFrame:transformedKeyboardFrame];
    NSLog(@"inset = %@",NSStringFromUIEdgeInsets(inset));
    NSLog(@"transf keyb = %@",NSStringFromCGRect(transformedKeyboardFrame));
    NSLog(@"transformedScrollFrame = %@",NSStringFromCGRect(transformedScrollFrame));
    
    return [self contentInsetWithDefaultInset:[scrollPack scrollDefaultInsets]
                                    viewFrame:transformedScrollFrame
                                keyboardFrame:transformedKeyboardFrame];
    
//    return insets;
}

#pragma mark -
#pragma mark geometry

- (UIEdgeInsets) contentInsetWithDefaultInset:(UIEdgeInsets) inset
                                    viewFrame:(CGRect) scrollViewFrame
                                keyboardFrame:(CGRect) keyboardFrame
{
    UIEdgeInsets contentInset = inset;
    if (CGRectIntersectsRect(keyboardFrame, scrollViewFrame) &&
        !CGRectEqualToRect(keyboardFrame, CGRectZero) &&
        !CGRectContainsRect(keyboardFrame, scrollViewFrame))
    {
        if (keyboardFrame.origin.y <= scrollViewFrame.origin.y) {
            contentInset.top += CGRectGetMaxY(keyboardFrame) - CGRectGetMinY(scrollViewFrame);
        }
        else if (keyboardFrame.origin.y <= CGRectGetMaxY(scrollViewFrame) &&
                 CGRectGetMaxY(keyboardFrame) >= CGRectGetMaxY(scrollViewFrame)) {
            contentInset.bottom += CGRectGetMaxY(scrollViewFrame) - CGRectGetMinY(keyboardFrame);
        }
    }
    return contentInset;
}

- (CGRect) transformCGRectToDefaultCoordinates:(CGRect) rect
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGSize windowSize = [[[[UIApplication sharedApplication] windows] objectAtIndex:0] frame].size;
    return [self transformCGRect:rect inViewWithSize:windowSize withOrientation:orientation];
}

- (CGRect) transformCGRect:(CGRect) rect
            inViewWithSize:(CGSize) size
           withOrientation:(UIInterfaceOrientation) orientation
{
    switch (orientation) {
        case UIInterfaceOrientationLandscapeRight:
            return CGRectTransformed(rect, size, CGRectTransformRotateLeft);
        case UIInterfaceOrientationLandscapeLeft:
            return CGRectTransformed(rect, size, CGRectTransformRotateRight);
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGRectTransformed(rect, size, CGRectTransformExpand);
        default:
            return rect;
    }
}

#pragma mark -
#pragma mark scroll frame changes observing

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
    NSLog(@"data = %@",change);
    NSLog(@"scroll frame = %@",NSStringFromCGRect([object frame]));
    RegisteredScrollPack *scrollPack = [self registeredScrollForView:object];
    [self updateRegisteredScroll:scrollPack];
}


#pragma mark -
#pragma mark window observing

- (void) registerForWindowObserving:(void (^)(id _self, UIView* subview)) listener
{
    if (listener == NULL ) {
        NSLog(@"listener cannot be NULL.");
        return;
    }
    
    Method setWindowMethod = class_getInstanceMethod([UIView class], @selector(setWindow:));
    IMP originalImplementation = method_getImplementation(setWindowMethod);
    
    void (^block)(id, UIWindow*) = ^(id _self, UIWindow* window) {
        originalImplementation(_self, @selector(setWindow:), window);
        listener(_self, window);
    };
    
    IMP newImplementation = imp_implementationWithBlock((void*)block);
    method_setImplementation(setWindowMethod, newImplementation);
}

- (void) unregisterForWindowObserving {
    
}

@end
