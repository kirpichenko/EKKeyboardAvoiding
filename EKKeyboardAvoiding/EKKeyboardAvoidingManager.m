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

- (id)initWithScrollView:(UIScrollView *)sscrollView;

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,assign) UIEdgeInsets scrollDefaultInsets;
@end

@implementation RegisteredScrollPack

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if(self = [super init])
    {
        [self setScrollView:scrollView];
        [self setScrollDefaultInsets:[scrollView contentInset]];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]])
    {
        return [self scrollView] == [object scrollView];
    }
    return NO;
}

@end

static NSString *const kMoveToWindowNotification = @"MoveToWindowNotification";

@interface EKKeyboardAvoidingManager ()
@property (atomic,readwrite) CGRect keyboardFrame;
@end

@implementation EKKeyboardAvoidingManager

+ (id)sharedInstance
{
    static EKKeyboardAvoidingManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)init
{
    if (self = [super init])
    {
        registeredScrolls = [[NSMutableSet alloc] init];

        [self installDidMoveToWindowNotifications];
        
        [self registerForNotificationNamed:UIKeyboardDidChangeFrameNotification
                                    action:@selector(keyboardFrameDidChange:)];
        [self registerForNotificationNamed:kMoveToWindowNotification
                                    action:@selector(subviewAdded:)];
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
           scrollPack = [[RegisteredScrollPack alloc] initWithScrollView:scrollView];
           [registeredScrolls addObject:scrollPack];
           [self updateRegisteredScroll:scrollPack];
       }
    }
}

- (void)unregisterScrollView:(UIScrollView *)scrollView
{
    @synchronized(self)
    {
        RegisteredScrollPack *scrollPack = [self registeredScrollForView:scrollView];
        if (scrollPack != nil)
        {
            [scrollView setContentInset:[scrollPack scrollDefaultInsets]];
            [registeredScrolls removeObject:scrollPack];
        }
    }
}

- (void) updateRegisteredScrollViews
{
    @synchronized (self)
    {
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

- (RegisteredScrollPack *)registeredScrollForView:(UIScrollView *)scrollView
{
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
    NSArray *scrolls = [registeredScrolls allObjects];
    for (RegisteredScrollPack *scrollPack in scrolls)
    {
        if ([scrollPack scrollView] == nil)
        {
            [registeredScrolls removeObject:scrollPack];
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
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         UIEdgeInsets insets = [self scrollViewContentInsets:scrollPack];
                         [[scrollPack scrollView] setContentInset:insets];
                         [[scrollPack scrollView] setScrollIndicatorInsets:insets];
                     }
                     completion:^(BOOL finished) {
                         [self scrollToFirstResponder:scrollView];
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

#pragma mark - notifications

- (void)registerForNotificationNamed:(NSString *)name action:(SEL)action
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:action name:name object:nil];
}

@end
