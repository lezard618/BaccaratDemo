//
//  ab_TableViewController.h
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#ifndef ab_TableViewController_h
#define ab_TableViewController_h

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    E_PlayerWin,
    E_BankWin,
    E_Tie,
    E_PlayerDouble,
    E_BankDouble,
    E_PlayerKing,
    E_BankKing,
    E_SameTie,
} GameResult;

@interface ab_TableViewController : UIViewController
@end

#endif /* ab_TableViewController_h */
