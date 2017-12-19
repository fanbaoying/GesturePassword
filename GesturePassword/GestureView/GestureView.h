//
//  GestureView.h
//  GesturePassword
//
//  Created by 范保莹 on 2017/12/19.
//  Copyright © 2017年 GesturePassword. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GestureView;

@protocol GestureDelegate <NSObject>

@optional

- (void)GestureSetResult:(NSString *)result gestureView:(GestureView *)gestureView;
- (void)GesturePasswordRight:(GestureView *)gestureView;
- (void)GesturePasswordWrong:(GestureView *)gestureView;

@end

@interface GestureView : UIView

@property (assign, nonatomic) id<GestureDelegate> delegate;

- (void)setRigthResult:(NSString *)rightResult;

@end
