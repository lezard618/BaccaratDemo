//
//  ab_LoginViewController.m
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ab_LoginViewController.h"
#import "ab_TableViewController.h"

@interface ab_LoginViewController ()

@end

@implementation ab_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"loaded");
}

- (IBAction)login:(id)sender {
    ab_TableViewController *game = [[ab_TableViewController alloc] initWithNibName:@"ab_TableViewController" bundle:nil];
    [self presentViewController:game animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate
{
    return YES;
    
}

@end
