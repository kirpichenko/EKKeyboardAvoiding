//
//  UIScrollViewDisplayManger.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import "EKKeyboardAvoidingScrollViewManager.h"
#import <objc/runtime.h>

@interface RegisteredScrollPack : NSObject
@property (nonatomic, assign) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets scrollDefaultInsets;
@end

@implementation RegisteredScrollPack
@end

static NSString *const kMoveToWindowNotification = @"MoveToWindowNotification";
static EKKeyboardAvoidingScrollViewManager *kUIScrollViewDisplayManager;

@interface EKKeyboardAvoidingScrollViewManager ()
@property (atomic, assign, readwrite) CGRect keyboardFrame;
@end

@implementation EKKeyboardAvoidingScrollViewManager

+ (id) sharedInstance
{
    @synchronized (self) {
        if (kUIScrollViewDisplayManager == nil) {
            kUIScrollViewDisplayManager = [[self alloc] init];
            [kUIScrollViewDisplayManager installDidMoveToWindowNotifications];
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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(subviewAdded:)
                                                     name:kMoveToWindowNotification
                                                   object:nil];
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
                [scrollView window];
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
    UIScrollView *scrollView = [scrollPack scrollView];
    if ([scrollView window] == nil) {
        return;
    }
    
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
    CGRect transformedKeyboardFrame = [[scrollView superview] convertRect:[self keyboardFrame]
                                                                 fromView:nil];
    return [self contentInsetWithDefaultInset:[scrollPack scrollDefaultInsets]
                                    viewFrame:[scrollView frame]
                                keyboardFrame:transformedKeyboardFrame];
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

#pragma mark -
#pragma mark scroll adding to window observing

- (void) subviewAdded:(NSNotification *) notification
{
    if ([[notification object] isKindOfClass:[UIScrollView class]]) {
        RegisteredScrollPack *scroll = [self registeredScrollForView:[notification object]];
        if (scroll) {
            [self updateRegisteredScroll:scroll];
        }
    }
}

#pragma mark -
#pragma mark install move ot window observing

- (void) installDidMoveToWindowNotifications
{
    Method didMoveMethod = class_getInstanceMethod([UIScrollView class], @selector(didMoveToWindow));
    IMP originalImplementation = method_getImplementation(didMoveMethod);
    
    void (^block)(id) = ^(id _self) {
        originalImplementation(_self, @selector(didMoveToWindow));
        [[NSNotificationCenter defaultCenter] postNotificationName:kMoveToWindowNotification
                                                            object:_self];
    };
    
    IMP newImplementation = imp_implementationWithBlock((void*)block);
    method_setImplementation(didMoveMethod, newImplementation);
}

@end
