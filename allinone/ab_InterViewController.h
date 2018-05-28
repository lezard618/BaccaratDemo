//
//  ab_InterViewController.h
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#ifndef ab_InterViewController_h
#define ab_InterViewController_h

#import <UIKit/UIKit.h>

@interface ab_InterViewController : UIViewController

@property (nonatomic,strong) NSString *webViewURL;

+(instancetype)ab_initWithURL:(NSString *)urlString;

@end


#endif /* ab_InterViewController_h */
