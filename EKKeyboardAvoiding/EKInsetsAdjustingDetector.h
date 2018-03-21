//
//  EKInsetsAdjustingDetector.h
//  EKKeyboardAvoiding
//
//  Created by Andrew Romanov on 21/03/2018.
//  Copyright © 2018 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreGraphics;

@interface EKInsetsAdjustingDetector : NSObject

@property (nonatomic) CGRect scrollViewFrame;
@property (nonatomic) CGSize contentSize;
@property (nonatomic) UIEdgeInsets safeInsets NS_AVAILABLE_IOS(11.0);
@property (nonatomic) UIScrollViewContentInsetAdjustmentBehavior contentAdjustmentBehavior NS_AVAILABLE_IOS(11.0);
@property (nonatomic) BOOL alwaysBounceVertical;
@property (nonatomic) BOOL alwaysBounceHorizontal;

- (BOOL)adjustLeft;
- (BOOL)adjustTop;
- (BOOL)adjustRight;
- (BOOL)adjustBottom;

@end
