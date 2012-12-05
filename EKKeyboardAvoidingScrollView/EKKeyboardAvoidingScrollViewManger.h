//
//  UIScrollViewDisplayManger.h
//  MyQuiz
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import <UIKit/UIKit.h>

@interface EKKeyboardAvoidingScrollViewManger : NSObject
{
    NSMutableArray *registeredScrolls;
}

+ (id) sharedInstance;

- (void) registerScrollViewForKeyboardAvoiding:(UIScrollView *) scrollView;
- (void) unregisterScrollViewFromKeyboardAvoiding:(UIScrollView *) scrollView;

- (void) updateRegisteredScrolls;

@end
