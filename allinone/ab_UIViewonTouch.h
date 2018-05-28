//
//  UIView+onTouch.h
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ab_onTouch)(void);
@interface UIView (onTouch)<UIGestureRecognizerDelegate>

- (void)onSingleTapped:(ab_onTouch)call;
- (void)onDoubleTapped:(ab_onTouch)call;
- (void)onDoubleFingerTapped:(ab_onTouch)call;
- (void)onLongPress:(ab_onTouch)call;
- (void)onTouchDown:(ab_onTouch)call;
- (void)onTouchUp:(ab_onTouch)call;

@end
