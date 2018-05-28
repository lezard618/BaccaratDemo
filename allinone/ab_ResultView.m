//
//  ab_ResultView.m
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ab_ResultView.h"
@interface ab_ResultView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@end

@implementation ab_ResultView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle]loadNibNamed:@"ab_ResultView" owner:self options:nil] lastObject];
    self.contentView.frame = self.bounds;
    [self addSubview: self.contentView];
}

//支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (IBAction)enSure:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)closeWin:(id)sender {
    [self removeFromSuperview];
}

//是否可以旋转
-(BOOL)shouldAutorotate
{
    return YES;
    
}

@end
