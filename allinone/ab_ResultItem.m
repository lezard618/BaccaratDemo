//
//  ab_ResultItem.m
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ab_ResultItem.h"
@interface ab_ResultItem()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@end

@implementation ab_ResultItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage* img = [UIImage imageNamed:imageName];
    [self.imageView setImage:img];
}
@end
