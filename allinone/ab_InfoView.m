//
//  ab_InfoView.m
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ab_InfoView.h"

@interface ab_InfoView ()
@property (weak, nonatomic) IBOutlet UIView *content;
@end

@implementation ab_InfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    self.content = [[[NSBundle mainBundle]loadNibNamed:@"ab_InfoView" owner:self options:nil] lastObject];
    self.content.frame = self.bounds;
    [self addSubview: self.content];
}

- (IBAction)dismiss:(id)sender {
    [self removeFromSuperview];
}
//支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

//是否可以旋转
-(BOOL)shouldAutorotate
{
    return YES;
    
}

@end
