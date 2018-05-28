//
//  UIView+onTouch.m
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#import "ab_UIViewonTouch.h"
#import <objc/runtime.h>

static char ab_SingleTapBlockKey;
static char ab_DoubleTapBlockKey;
static char ab_DoubleFingerTapBlockKey;
static char ab_TouchDownTapBlockKey;
static char ab_TouchUpTapBlcokKey;
static char ab_LongPressBlockKey;

@interface UIView (ab_TouchPrivates)
- (void)requireSingleTapsRecognizer:(UIGestureRecognizer *)recognizer;
- (void)requireDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer;
- (void)requireLongPressTecognizer:(UIGestureRecognizer *)recognizer;
- (UITapGestureRecognizer *)addTapRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches sel:(SEL)sel;
- (UILongPressGestureRecognizer *)addLongPressRecognizerWithTouches:(NSUInteger)touches sel:(SEL)sel;

- (void)returnBlockForkey:(void *)key;
- (void)setBlockForKey:(void *)key call:(ab_onTouch)call;

@end

@implementation UIView (onTouch)
#pragma mark -Taps
- (void)onSingleTapped:(ab_onTouch)call
{
    UITapGestureRecognizer *tap = [self addTapRecognizerWithTaps:1 touches:1 sel:@selector(singleTap)];
    [self requireDoubleTapsRecognizer:tap];
    [self requireLongPressTecognizer:tap];
    [self setBlockForKey:&ab_SingleTapBlockKey call:call];
}

- (void)onDoubleTapped:(ab_onTouch)call
{
    UITapGestureRecognizer *tap = [self addTapRecognizerWithTaps:2 touches:1 sel:@selector(doubleTap)];
    [self requireSingleTapsRecognizer:tap];
    [self setBlockForKey:&ab_DoubleTapBlockKey call:call];
}

- (void)onDoubleFingerTapped:(ab_onTouch)call
{
    [self addTapRecognizerWithTaps:1 touches:2 sel:@selector(doubleFingerTap)];
    [self setBlockForKey:&ab_DoubleFingerTapBlockKey call:call];
}

- (void)onLongPress:(ab_onTouch)call
{
    [self addLongPressRecognizerWithTouches:1 sel:@selector(longPress:)];
    [self setBlockForKey:&ab_LongPressBlockKey call:call];
}

- (void)onTouchDown:(ab_onTouch)call
{
    [self setBlockForKey:&ab_TouchDownTapBlockKey call:call];
}

- (void)onTouchUp:(ab_onTouch)call
{
    [self setBlockForKey:&ab_TouchUpTapBlcokKey call:call];
}

//获取关联对象
- (void)returnBlockForkey:(void *)key
{
    ab_onTouch block = objc_getAssociatedObject(self, key);
    if (block) block();
}

//创建关联
- (void)setBlockForKey:(void *)key call:(ab_onTouch)call
{
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, key, call, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)singleTap
{
    [self returnBlockForkey:&ab_SingleTapBlockKey];
}

- (void)doubleTap
{
    [self returnBlockForkey:&ab_DoubleTapBlockKey];
}

- (void)doubleFingerTap
{
    [self returnBlockForkey:&ab_DoubleFingerTapBlockKey];
}

- (void)longPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)[self returnBlockForkey:&ab_LongPressBlockKey];}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self returnBlockForkey:&ab_TouchDownTapBlockKey];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self returnBlockForkey:&ab_TouchUpTapBlcokKey];
}

- (void)requireSingleTapsRecognizer:(UIGestureRecognizer *)recognizer
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
            if (tap.numberOfTouchesRequired==1&tap.numberOfTapsRequired == 1) {
                [tap requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

- (void)requireDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
            if (tap.numberOfTapsRequired == 2&tap.numberOfTouchesRequired == 1) {
                [tap requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

- (void)requireLongPressTecognizer:(UIGestureRecognizer *)recognizer
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
            UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)gesture;
            [longPress requireGestureRecognizerToFail:recognizer];
        }
    }
}

#pragma mark - 添加手势
- (UITapGestureRecognizer *)addTapRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches sel:(SEL)sel
{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:sel];
    tapGr.delegate = self;
    tapGr.numberOfTapsRequired = taps;
    tapGr.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:tapGr];
    return tapGr;
}

- (UILongPressGestureRecognizer *)addLongPressRecognizerWithTouches:(NSUInteger)touches sel:(SEL)sel
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:sel];
    longPress.numberOfTouchesRequired = touches;
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    return longPress;
}
@end
