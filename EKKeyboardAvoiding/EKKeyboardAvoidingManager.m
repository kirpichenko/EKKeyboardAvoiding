//
//  UIScrollViewDisplayManager.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import "EKKeyboardAvoidingManager.h"
#import <objc/runtime.h>

@interface RegisteredScrollPack : NSObject
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,assign) UIEdgeInsets scrollDefaultInsets;
@end

@implementation RegisteredScrollPack

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
}

@end

static NSString *const kMoveToWindowNotification = @"MoveToWindowNotification";
static EKKeyboardAvoidingManager *kUIScrollViewDisplayManager;

@interface EKKeyboardAvoidingManager ()
@property (atomic,readwrite) CGRect keyboardFrame;
@end

@implementation EKKeyboardAvoidingManager

+ (id)sharedInstance
{
    @synchronized (self)
    {
        if (kUIScrollViewDisplayManager == nil)
        {
            kUIScrollViewDisplayManager = [[self alloc] init];
            [kUIScrollViewDisplayManager installDidMoveToWindowNotifications];
        }
    }
    return kUIScrollViewDisplayManager;
}

- (id)init
{
    if (self = [super init])
    {
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark public methods

- (void)registerScrollView:(UIScrollView *)scrollView
{
   @synchronized(self)
    {
       RegisteredScrollPack *scrollPack = [self registeredScrollForView:scrollView];
       if (scrollPack == nil)
       {
           scrollPack = [self prepareScrollPackWithScrollView:scrollView];
           [registeredScrolls addObject:scrollPack];
           [self updateRegisteredScroll:scrollPack];
       }
    }
}

- (void)unregisterScrollView:(UIScrollView *)scrollView
{
    @synchronized(self)
    {
        if (scrollView != nil)
        {
            RegisteredScrollPack *scrollPack = [self registeredScrollForView:scrollView];
            if (scrollPack != nil)
            {
                [scrollView window];
                [scrollView setContentInset:[scrollPack scrollDefaultInsets]];
                [registeredScrolls removeObject:scrollPack];
            }
        }
    }
}

- (void) updateRegisteredScrollViews
{
    @synchronized (self) {
        for (RegisteredScrollPack *scrollPack in registeredScrolls)
        {
            [self updateRegisteredScroll:scrollPack];
        }
    }
}

#pragma mark -
#pragma mark notifications

- (void)keyboardFrameDidChange:(NSNotification *)notification
{
    [self removeInvalidScrollPacks];

    NSValue *keyboardFrameValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    [self setKeyboardFrame:[keyboardFrameValue CGRectValue]];
    [self updateRegisteredScrollViews];
}

#pragma mark -
#pragma mark helpers

- (RegisteredScrollPack *)prepareScrollPackWithScrollView:(UIScrollView *)scrollView
{
    RegisteredScrollPack *scrollPack = [[RegisteredScrollPack alloc] init];

    [scrollPack setScrollView:scrollView];
    [scrollPack setScrollDefaultInsets:[scrollView contentInset]];
    
    return scrollPack;
}

- (RegisteredScrollPack *)registeredScrollForView:(UIScrollView *)scrollView
{
    if (scrollView == nil)
    {
        return nil;
    }
    
    @synchronized (self)
    {
        for (RegisteredScrollPack *scrollPack in registeredScrolls)
        {
            if ([scrollPack scrollView] == scrollView)
            {
                return scrollPack;
            }
        }
        return nil;
    }
}

- (void)removeInvalidScrollPacks
{
    @synchronized (self)
    {
        for (int i = 0; i < [registeredScrolls count]; ++i)
        {
            if ([registeredScrolls[i] scrollView] == nil)
            {
                [registeredScrolls removeObjectAtIndex:i];
                i -= 1;
            }
        }
    }
}

- (void)updateRegisteredScroll:(RegisteredScrollPack *)scrollPack
{
    UIScrollView *scrollView = [scrollPack scrollView];
    if ([scrollView window] == nil)
    {
        return;
    }
    
    __weak id weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^{
                         UIEdgeInsets insets = [self scrollViewContentInsets:scrollPack];
                         [[scrollPack scrollView] setContentInset:insets];
                         [[scrollPack scrollView] setScrollIndicatorInsets:insets];
                     }
                     completion:^(BOOL finished) {
                         [weakSelf scrollToFirstResponder:scrollView];
                     }];
}

- (void)scrollToFirstResponder:(UIScrollView *)scrollView
{
    UIView *firstResponder = [self findFirstResponderInView:scrollView];
    if (firstResponder != nil)
    {
        CGRect firstResponderFrame = [firstResponder convertRect:[firstResponder bounds]
                                                          toView:scrollView];
        [scrollView scrollRectToVisible:firstResponderFrame animated:YES];
    }
}

- (UIView *)findFirstResponderInView:(UIView *)view
{
    for (UIView *subview in [view subviews])
    {
        if ([subview isFirstResponder])
        {
            return subview;
        }
        
        UIView *firstResponderInSubview = [self findFirstResponderInView:subview];
        if ([firstResponderInSubview isFirstResponder])
        {
            return firstResponderInSubview;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark count insets

- (UIEdgeInsets)scrollViewContentInsets:(RegisteredScrollPack *)scrollPack
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

- (UIEdgeInsets)contentInsetWithDefaultInset:(UIEdgeInsets) inset
                                   viewFrame:(CGRect) scrollViewFrame
                               keyboardFrame:(CGRect) keyboardFrame
{
    UIEdgeInsets contentInset = inset;
    if (CGRectIntersectsRect(keyboardFrame, scrollViewFrame) &&
        !CGRectEqualToRect(keyboardFrame, CGRectZero) &&
        !CGRectContainsRect(keyboardFrame, scrollViewFrame))
    {
        if (keyboardFrame.origin.y <= scrollViewFrame.origin.y)
        {
            contentInset.top += CGRectGetMaxY(keyboardFrame) - CGRectGetMinY(scrollViewFrame);
        }
        else if (keyboardFrame.origin.y <= CGRectGetMaxY(scrollViewFrame) &&
                 CGRectGetMaxY(keyboardFrame) >= CGRectGetMaxY(scrollViewFrame))
        {
            contentInset.bottom += CGRectGetMaxY(scrollViewFrame) - CGRectGetMinY(keyboardFrame);
        }
    }
    return contentInset;
}

#pragma mark -
#pragma mark scroll adding to window observing

- (void)subviewAdded:(NSNotification *)notification
{
    if ([[notification object] isKindOfClass:[UIScrollView class]])
    {
        RegisteredScrollPack *scroll = [self registeredScrollForView:[notification object]];
        if (scroll)
        {
            [self updateRegisteredScroll:scroll];
        }
    }
}

#pragma mark -
#pragma mark install move ot window observing

- (void)installDidMoveToWindowNotifications
{
    Method didMoveMethod = class_getInstanceMethod([UIScrollView class], @selector(didMoveToWindow));
    IMP originalImplementation = method_getImplementation(didMoveMethod);
    
    void (^block)(id) = ^(id _self) {
        originalImplementation(_self, @selector(didMoveToWindow));
        [[NSNotificationCenter defaultCenter] postNotificationName:kMoveToWindowNotification
                                                            object:_self];
    };
    
    IMP newImplementation = imp_implementationWithBlock((__bridge id)((__bridge void*)block));
    method_setImplementation(didMoveMethod, newImplementation);
}

@end
