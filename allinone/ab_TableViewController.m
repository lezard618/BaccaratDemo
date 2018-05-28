//
//  ab_TableViewController.m
//  allinone
//
//  Created by ZHAO LIU on 2018/5/16.
//  Copyright © 2018年 ZHAO LIU. All rights reserved.
//

#import "ab_TableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "ab_UIViewonTouch.h"
#import "ab_ResultItem.h"
#import "ab_InfoView.h"
#import "ab_ResultView.h"

@interface ab_TableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic)NSMutableDictionary* betList;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (nonatomic, assign) BOOL isPlaymusic;
@property (strong, nonatomic) UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *startGameBtn;

@property (weak, nonatomic) IBOutlet UIButton *bankerBtn;
@property (weak, nonatomic) IBOutlet UIButton *playerBtn;
@property (weak, nonatomic) IBOutlet UIButton *tileBtn;
@property (weak, nonatomic) IBOutlet UIButton *playerDoubleBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankerDoubleBtn;
@property (weak, nonatomic) IBOutlet UIButton *playerKingBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankerKingBtn;
@property (weak, nonatomic) IBOutlet UIButton *sameTileBtn;
@property (weak, nonatomic) IBOutlet UILabel *bankerTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *tileTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankerDoubleTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerDoubleTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankerKingTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerKingTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *sameTileTotalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCard3;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCard2;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCard1;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard3;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard2;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard1;
@property (weak, nonatomic) IBOutlet UIImageView *coinImg1;
@property (weak, nonatomic) IBOutlet UIImageView *coinImg2;
@property (weak, nonatomic) IBOutlet UIImageView *coinImg3;
@property (weak, nonatomic) IBOutlet UIImageView *coinImg4;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (strong, nonatomic)NSDictionary *pokerDic;
@property (strong, nonatomic)NSArray *pokersArr;

@property (assign, nonatomic) NSInteger money;
@property (assign, nonatomic) NSInteger coinX;
@property (assign, nonatomic) NSInteger coinY;
@property (strong, nonatomic) NSMutableArray *ansArr;
@property (strong, nonatomic) NSMutableArray *allCoinArr;
@property (strong, nonatomic) NSMutableArray *cardArr;
@property (assign, nonatomic) NSInteger chooseCoin;
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

static NSInteger coinW = 21;
static NSInteger coinH = 11;
static NSInteger cardT = 1.5;
static NSString *cellID = @"ab_ResultItem";

static NSInteger COIN_VALUE_1 = 100;
static NSInteger COIN_VALUE_2 = 300;
static NSInteger COIN_VALUE_3 = 500;
static NSInteger COIN_VALUE_4 = 800;

static NSString* COIN_NAME_1 = @"game_chip100";
static NSString* COIN_NAME_2 = @"game_chip300";
static NSString* COIN_NAME_3 = @"game_chip500";
static NSString* COIN_NAME_4 = @"game_chip800";


@implementation ab_TableViewController

-(NSMutableArray *)resultArray
{
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ab_setUpData];
    [self ab_uiSetUp];
    [self ab_choiceBetNum];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)ab_setUpData{
    self.money = 10000;
    self.isPlaymusic = YES;
    self.allCoinArr = [NSMutableArray array];
    self.cardArr = [NSMutableArray array];
    self.betList = [[NSMutableDictionary alloc] init];
    self.pokerDic = @{
        @"0x01":@"1",@"0x02":@"2",@"0x03":@"3",@"0x04":@"4",@"0x05":@"5",@"0x06":@"6",@"0x07":@"7",@"0x08":@"8",@"0x09":@"9",
        @"0x0A":@"10",@"0x0B":@"11",@"0x0C":@"12",@"0x0D":@"13",
        
        @"0x11":@"1",@"0x12":@"2",@"0x13":@"3",@"0x14":@"4",@"0x15":@"5",@"0x16":@"6",@"0x17":@"7",@"0x18":@"8",@"0x19":@"9",
        @"0x1A":@"10",@"0x1B":@"11",@"0x1C":@"12",@"0x1D":@"13",
        
        @"0x21":@"1",@"0x22":@"2",@"0x23":@"3",@"0x24":@"4",@"0x25":@"5",@"0x26":@"6",@"0x27":@"7",@"0x28":@"8",@"0x29":@"9",
        @"0x2A":@"10",@"0x2B":@"11",@"0x2C":@"12",@"0x2D":@"13",
        
        @"0x31":@"1",@"0x32":@"2",@"0x33":@"3",@"0x34":@"4",@"0x35":@"5",@"0x36":@"6",@"0x37":@"7",@"0x38":@"8",@"0x39":@"9",
        @"0x3A":@"10",@"0x3B":@"11",@"0x3C":@"12",@"0x3D":@"13"};
    self.pokersArr = [self.pokerDic allKeys];
}

- (void)ab_uiSetUp{
    [self.collectionView registerNib:[UINib nibWithNibName:@"ab_ResultItem" bundle:nil] forCellWithReuseIdentifier:cellID];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.chooseCoin = COIN_VALUE_1;
    self.coinImg1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.coinImg1.layer.borderWidth = 2;
    self.coinImg2.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg2.layer.borderWidth = 2;
    self.coinImg3.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg3.layer.borderWidth = 2;
    self.coinImg4.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg4.layer.borderWidth = 2;
}

- (void)ab_choiceBetNum{
    [self.coinImg1 onSingleTapped:^{
        self.chooseCoin = COIN_VALUE_1;
        self.coinImg1.layer.borderColor = [UIColor whiteColor].CGColor;
        self.coinImg2.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg3.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg4.layer.borderColor = [UIColor clearColor].CGColor;
    }];
    
    [self.coinImg2 onSingleTapped:^{
        self.chooseCoin = COIN_VALUE_2;
        self.coinImg2.layer.borderColor = [UIColor whiteColor].CGColor;
        self.coinImg1.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg3.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg4.layer.borderColor = [UIColor clearColor].CGColor;
    }];
   
    [self.coinImg3 onSingleTapped:^{
        self.chooseCoin = COIN_VALUE_3;
        self.coinImg3.layer.borderColor = [UIColor whiteColor].CGColor;
        self.coinImg1.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg2.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg4.layer.borderColor = [UIColor clearColor].CGColor;
    }];
    
    [self.coinImg4 onSingleTapped:^{
        self.chooseCoin = COIN_VALUE_4;
        self.coinImg4.layer.borderColor = [UIColor whiteColor].CGColor;
        self.coinImg1.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg2.layer.borderColor = [UIColor clearColor].CGColor;
        self.coinImg3.layer.borderColor = [UIColor clearColor].CGColor;
    }];
}

- (NSInteger)ab_selectedBet:(GameResult)index rect:(CGRect)rect {
    CGFloat x = rect.origin.x + arc4random()%(int)rect.size.width - 5;
    CGFloat y = rect.origin.y + arc4random()%(int)rect.size.height - 5;
    self.coinX = x;
    self.coinY = y;
    
    NSInteger total = 0;
    for (NSString* value in self.betList.allValues) {
        total += [value integerValue];
    }
    
    NSInteger cur = 0;
    NSString* key = [NSString stringWithFormat:@"%ld", index];
    if ([[self.betList allKeys] containsObject:key]) {
        cur = [[self.betList objectForKey:key] integerValue];
    }
    
    cur += self.chooseCoin;
    total += self.chooseCoin;
    [self.betList setValue:[NSString stringWithFormat:@"%ld", cur] forKey:key];
    if (self.money - total < 0) {
        [self ab_showTips:@"余额不足" inView:self.view];
        return 0;
    }else{
        if (self.chooseCoin == COIN_VALUE_1) {
            UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:self.coinImg1.frame];
            NewGoldImg.image = [UIImage imageNamed:COIN_NAME_1];
            [self.view addSubview:NewGoldImg];
            [self.allCoinArr addObject:NewGoldImg];
            
            [UIView animateWithDuration:0.5 animations:^{
                NewGoldImg.frame = CGRectMake(self.coinX, self.coinY, coinW, coinH);
            }];
        }else if (self.chooseCoin == COIN_VALUE_2) {
            UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:self.coinImg2.frame];
            NewGoldImg.image = [UIImage imageNamed:COIN_NAME_2];
            [self.view addSubview:NewGoldImg];
            [self.allCoinArr addObject:NewGoldImg];
            
            [UIView animateWithDuration:0.5 animations:^{
                NewGoldImg.frame = CGRectMake(self.coinX, self.coinY, coinW, coinH);
            }];
        }else if (self.chooseCoin == COIN_VALUE_3){
            UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:self.coinImg3.frame];
            NewGoldImg.image = [UIImage imageNamed:COIN_NAME_3];
            [self.view addSubview:NewGoldImg];
            [self.allCoinArr addObject:NewGoldImg];
            [UIView animateWithDuration:0.5 animations:^{
                NewGoldImg.frame = CGRectMake(self.coinX, self.coinY, coinW, coinH);
            }];
        }else if (self.chooseCoin == COIN_VALUE_4){
            UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:self.coinImg4.frame];
            NewGoldImg.image = [UIImage imageNamed:COIN_NAME_4];
            [self.view addSubview:NewGoldImg];
            [self.allCoinArr addObject:NewGoldImg];
            [UIView animateWithDuration:0.5 animations:^{
                NewGoldImg.frame = CGRectMake(self.coinX, self.coinY, coinW, coinH);
            }];
        }
    }
    
    return self.chooseCoin;
}

- (IBAction)openRule:(id)sender {
    ab_InfoView *rule = [[ab_InfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    rule.center = CGPointMake(self.view.center.x, 0);
    [self.view addSubview:rule];
    
    [UIView animateWithDuration:0.5 animations:^{
        rule.center = CGPointMake(self.view.center.x, self.view.center.y);
    } completion:^(BOOL finished) {
    }];
}

- (IBAction)reset:(id)sender {
    self.money = 10000;
    self.totalLabel.text = @"10000";
}

- (IBAction)selectedPlayer:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_PlayerWin rect:btn.frame];
    if (bet > 0) {
        self.playerTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.playerTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

- (IBAction)selectedBanker:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_BankWin rect:btn.frame];
    if (bet > 0) {
        self.bankerTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.bankerTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

- (IBAction)selectedTile:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_Tie rect:btn.frame];
    if (bet > 0) {
        self.tileTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.tileTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

- (IBAction)selectedPlayerDouble:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_PlayerDouble rect:btn.frame];
    if (bet > 0) {
        self.playerDoubleTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.playerDoubleTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

- (IBAction)selectedBankerDouble:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_BankDouble rect:btn.frame];
    if (bet > 0) {
        self.bankerDoubleTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.bankerDoubleTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

- (IBAction)selectedPlayerKing:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_PlayerKing rect:btn.frame];
    if (bet > 0) {
        self.playerKingTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.playerKingTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

- (IBAction)selectedBankerKing:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_BankKing rect:btn.frame];
    if (bet > 0) {
        self.bankerKingTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.bankerKingTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

- (IBAction)selectedSameTie:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger bet = [self ab_selectedBet:E_SameTie rect:btn.frame];
    if (bet > 0) {
        self.sameTileTotalLabel.text = [NSString stringWithFormat:@"%ld",[self.sameTileTotalLabel.text integerValue] + bet];
        self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.totalLabel.text integerValue] - bet];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch view].superview?[touch view].superview:[touch view]];
    self.coinX = point.x;
    self.coinY = point.y;
}

- (void)FilpAnimations:(UIImageView *)img{
    NSArray *arr = [self randomArray];
    NSInteger iii = arc4random()%3;
    [self.ansArr addObject:_pokerDic[arr[iii]]];
    [UIView beginAnimations:@"View Filp" context:nil];
    [UIView setAnimationDelay:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:img cache:NO];
    [UIView commitAnimations];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        img.image = [UIImage imageNamed:arr[iii]];
    });
}

-(NSArray *)randomArray
{
    //随机数从这里边产生
    NSMutableArray *startArray=[[NSMutableArray alloc] initWithArray:self.pokersArr];
    //随机数产生结果
    NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    NSInteger m=4;
    for (int i=0; i<m; i++) {
        int t=arc4random()%startArray.count;
        resultArray[i]=startArray[t];
        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (IBAction)backHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelBet:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.startGameBtn.selected = NO;
    self.coinImg1.image = [UIImage imageNamed:COIN_NAME_1];
    self.coinImg2.image = [UIImage imageNamed:COIN_NAME_2];
    self.coinImg3.image = [UIImage imageNamed:COIN_NAME_3];
    self.coinImg4.image = [UIImage imageNamed:COIN_NAME_4];
    self.chooseCoin = COIN_VALUE_1;
    self.coinImg1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.coinImg2.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg3.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg4.layer.borderColor = [[UIColor clearColor] CGColor];
    
    self.totalLabel.text = [NSString stringWithFormat:@"%ld", self.money];
    self.playerTotalLabel.text = @"";
    self.tileTotalLabel.text = @"";
    self.bankerTotalLabel.text = @"";
    for (UIImageView *img in self.allCoinArr) {
        [img removeFromSuperview];
    }
}

-(void)ab_checkResult:(int)addPlayer addBanker:(int)banker {
    NSInteger total = 0;
    NSInteger playAns = 0;
    if ([self.ansArr[0] integerValue] < 10) {
        playAns += [self.ansArr[0] integerValue];
    }
    
    if ([self.ansArr[2] integerValue] < 10) {
        playAns += [self.ansArr[2] integerValue];
    }
    
    if (addPlayer < 10) {
        playAns += addPlayer;
    }
    
    NSInteger bankAns = 0;
    if ([self.ansArr[1] integerValue] < 10) {
        bankAns += [self.ansArr[1] integerValue];
    }
    
    if ([self.ansArr[3] integerValue] < 10) {
        bankAns += [self.ansArr[3] integerValue];
    }
    
    if (banker < 10) {
        bankAns += banker;
    }
    
    BOOL isPlayerDouble = false;
    BOOL isBankDouble = false;
    if ([self.ansArr[0] integerValue] == [self.ansArr[2] integerValue] || [self.ansArr[0] integerValue] == addPlayer || addPlayer == [self.ansArr[2] integerValue]) {
        isPlayerDouble = true;
    }
    
    if ([self.ansArr[1] integerValue] == [self.ansArr[3] integerValue] || [self.ansArr[1] integerValue] == banker || banker == [self.ansArr[3] integerValue]) {
        isBankDouble = true;
    }
    
    while (playAns>=10) {
        playAns = playAns - 10;
    }
    while (bankAns>=10) {
        bankAns = bankAns - 10;
    }
    
    NSString* playerDouble = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_PlayerDouble]]) {
        playerDouble = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_PlayerDouble]];
    }
    
    NSString* bankDouble = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_BankDouble]]) {
        bankDouble = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_BankDouble]];
    }
    
    NSString* playerwin = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_PlayerWin]]) {
        playerwin = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_PlayerWin]];
    }
    
    NSString* bankwin = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_BankWin]]) {
        bankwin = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_BankWin]];
    }
    
    NSString* tie = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_Tie]]) {
        tie = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_Tie]];
    }
    
    NSString* playerking = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_PlayerKing]]) {
        playerking = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_PlayerKing]];
    }
    
    NSString* bankking = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_BankKing]]) {
        bankking = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_BankKing]];
    }
    
    NSString* sametie = NULL;
    if ([[self.betList allKeys] containsObject:[NSString stringWithFormat:@"%ld", E_SameTie]]) {
        sametie = [self.betList objectForKey:[NSString stringWithFormat:@"%ld", E_SameTie]];
    }
    
    if (playerDouble != NULL) {
        if (isPlayerDouble) {
            total += [playerDouble integerValue] * 11;
        } else {
            total += [playerDouble integerValue];
        }
    }
    
    if (bankDouble != NULL) {
        if (isBankDouble) {
            total += [bankDouble integerValue] * 11;
        } else {
            total += [bankDouble integerValue];
        }
    }
    
    if (playerking != NULL) {
        if (playAns >= 8) {
            total += [playerking integerValue] * 2;
        } else {
            total += [playerking integerValue];
        }
    }
    
    if (bankking != NULL) {
        if (bankAns >= 8) {
            total += [bankking integerValue] * 2;
        } else {
            total += [bankking integerValue];
        }
    }
    
    ab_ResultView *result = [[ab_ResultView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    result.center = CGPointMake(self.view.center.x, 0);
    [self.view addSubview:result];
    
    if (playAns > bankAns) {
        NSLog(@"闲家赢");
        result.titleLabel.text = @"闲家赢";
        
        if (playerwin != NULL) {
            total += [playerwin integerValue];
        }
        
        if (bankwin != NULL) {
            total -= [bankwin integerValue];
        }
        
        if (tie != NULL) {
            total -= [tie integerValue];
        }
        
        if (sametie != NULL) {
            total -= [sametie integerValue];
        }
    } else if (playAns < bankAns) {
        NSLog(@"庄家赢");
        result.titleLabel.text = @"庄家赢";
        
        if (playerwin != NULL) {
            total -= [playerwin integerValue];
        }
        
        if (bankwin != NULL) {
            total += [bankwin integerValue];
        }
        
        if (tie != NULL) {
            total -= [tie integerValue];
        }
        
        if (sametie != NULL) {
            total -= [sametie integerValue];
        }
    } else if (playAns == bankAns) {
        NSLog(@"和局");
        result.titleLabel.text = @"和局";
        
        if (playerwin != NULL) {
            total -= [playerwin integerValue];
        }
        
        if (bankwin != NULL) {
            total -= [bankwin integerValue];
        }
        
        if (tie != NULL) {
            total += [tie integerValue] * 8;
        }
        
        if (sametie != NULL) {
            NSArray* playerArray = @[self.ansArr[0], self.ansArr[2], [NSString stringWithFormat:@"%ld", addPlayer]];
            [playerArray sortedArrayUsingSelector:@selector(compare:)];
            NSArray* bankerArray = @[self.ansArr[1], self.ansArr[3], [NSString stringWithFormat:@"%ld", banker]];
            [bankerArray sortedArrayUsingSelector:@selector(compare:)];
            if ([playerArray[0] integerValue] == [bankerArray[0] integerValue]
                && [playerArray[1] integerValue] == [bankerArray[1] integerValue]
                && [playerArray[2] integerValue] == [bankerArray[2] integerValue]) {
                total += [sametie integerValue] * 32;
            } else {
                total -= [sametie integerValue];
            }
        }
    }
    
    self.money += total;
    self.totalLabel.text = [NSString stringWithFormat:@"%ld", self.money];
    result.numLabel.text = [NSString stringWithFormat:@"%ld", total];
    
    if (total > 0) {
        result.numLabel.textColor = [UIColor redColor];
    }else{
        result.numLabel.textColor = [UIColor greenColor];
    }
    
    [result.titleLabel sizeToFit];
    [result.numLabel sizeToFit];
    
    [UIView animateWithDuration:0.5 animations:^{
        result.center = CGPointMake(self.view.center.x, self.view.center.y);
    } completion:^(BOOL finished) {
        [self.resultArray addObject:result.titleLabel.text];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.resultArray.count-1 inSection:0];
        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:indexpath]];
        [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    }];
}

#pragma mark -- 游戏结束，移除桌面元素
- (void)cleanAll {
    self.playerTotalLabel.text = @"";
    self.bankerTotalLabel.text = @"";
    self.tileTotalLabel.text = @"";
    self.playerDoubleTotalLabel.text = @"";
    self.bankerDoubleTotalLabel.text = @"";
    self.playerKingTotalLabel.text = @"";
    self.bankerKingTotalLabel.text = @"";
    self.sameTileTotalLabel.text = @"";
    for (UIImageView *img in self.allCoinArr) {
        [img removeFromSuperview];
    }
    self.chooseCoin = COIN_VALUE_1;
    self.coinImg1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.coinImg2.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg3.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg4.layer.borderColor = [[UIColor clearColor] CGColor];
    self.coinImg1.image = [UIImage imageNamed:COIN_NAME_1];
    self.coinImg2.image = [UIImage imageNamed:COIN_NAME_2];
    self.coinImg3.image = [UIImage imageNamed:COIN_NAME_3];
    self.coinImg4.image = [UIImage imageNamed:COIN_NAME_4];
    [self.betList removeAllObjects];
}

- (IBAction)start:(UIButton *)sender {
    
    if(sender.selected) return;
    sender.selected=YES;
    self.cancelBtn.selected = YES;
    if (self.betList.count <= 0) {
        sender.selected=NO;
        self.cancelBtn.selected = NO;
        [self ab_showTips:@"请下注" inView:self.view];
    }else{
    
        self.ansArr = [NSMutableArray array];
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
        img1.image = [UIImage imageNamed:@"0x00"];
        [self.view addSubview:img1];
        [UIView animateWithDuration:cardT animations:^{
            img1.frame = self.playerCard1.frame;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
            img2.image = [UIImage imageNamed:@"0x00"];
            [self.view addSubview:img2];
            [UIView animateWithDuration:cardT animations:^{
                img2.frame = self.bankerCard1.frame;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                    img3.image = [UIImage imageNamed:@"0x00"];
                    [self.view addSubview:img3];
                    [UIView animateWithDuration:cardT animations:^{
                        img3.frame = self.playerCard2.frame;
                    }];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                        img4.image = [UIImage imageNamed:@"0x00"];
                        [self.view addSubview:img4];
                        [UIView animateWithDuration:cardT animations:^{
                            img4.frame = self.bankerCard2.frame;
                        }];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self FilpAnimations:img1];
                            [self FilpAnimations:img2];
                            [self FilpAnimations:img3];
                            [self FilpAnimations:img4];
                            // alert
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                //不为和局的情况
                                if ([self.ansArr[0] integerValue] + [self.ansArr[2] integerValue] != [self.ansArr[1] integerValue] + [self.ansArr[3] integerValue]) {
                                    
                                    NSInteger playAns = 0;
                                    if ([self.ansArr[0] integerValue] < 10) {
                                        playAns += [self.ansArr[0] integerValue];
                                    }
                                    
                                    if ([self.ansArr[2] integerValue] < 10) {
                                        playAns += [self.ansArr[2] integerValue];
                                    }
                                    
                                    NSInteger bankAns = 0;
                                    if ([self.ansArr[1] integerValue] < 10) {
                                        bankAns += [self.ansArr[1] integerValue];
                                    }
                                    
                                    if ([self.ansArr[3] integerValue] < 10) {
                                        bankAns += [self.ansArr[3] integerValue];
                                    }
                                    
                                    while (playAns>=10) {
                                        playAns = playAns - 10;
                                    }
                                    while (bankAns>=10) {
                                        bankAns = bankAns - 10;
                                    }
                                    if (playAns<6&&bankAns>=6) {
                                        NSArray *arr = [self randomArray];
                                        NSInteger iii = arc4random()%3;
                                        UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                                        img5.image = [UIImage imageNamed:arr[iii]];
                                        [self.view addSubview:img5];
                                        [UIView animateWithDuration:cardT animations:^{
                                            img5.frame = self.playerCard3.frame;
                                            img5.transform = CGAffineTransformMakeRotation(M_PI*0.5);
                                        }];
                                        
                                        NSInteger playAns = 0;
                                        if ([self.ansArr[0] integerValue] < 10) {
                                            playAns += [self.ansArr[0] integerValue];
                                        }
                                        
                                        if ([self.ansArr[2] integerValue] < 10) {
                                            playAns += [self.ansArr[2] integerValue];
                                        }
                                        
                                        if ([self.pokerDic[arr[iii]] integerValue] < 10) {
                                            playAns += [self.pokerDic[arr[iii]] integerValue];
                                        }
                                        
                                        NSInteger bankAns = 0;
                                        if ([self.ansArr[1] integerValue] < 10) {
                                            bankAns += [self.ansArr[1] integerValue];
                                        }
                                        
                                        if ([self.ansArr[3] integerValue] < 10) {
                                            bankAns += [self.ansArr[3] integerValue];
                                        }
                                        
                                        while (playAns>=10) {
                                            playAns = playAns - 10;
                                        }
                                        while (bankAns>=10) {
                                            bankAns = bankAns - 10;
                                        }
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [self ab_checkResult:[self.pokerDic[arr[iii]] integerValue] addBanker:0];
                                            sender.selected=NO;
                                            self.cancelBtn.selected = NO;
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                [self cleanAll];
                                                img1.image = [UIImage imageNamed:@""];
                                                img2.image = [UIImage imageNamed:@""];
                                                img3.image = [UIImage imageNamed:@""];
                                                img4.image = [UIImage imageNamed:@""];
                                                img5.image = [UIImage imageNamed:@""];
                                            });
                                        });
                                    } else if (bankAns<6&&playAns>=6) {
                                        
                                        NSArray *arr = [self randomArray];
                                        NSInteger iii = arc4random()%3;
                                        UIImageView *img6 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                                        img6.image = [UIImage imageNamed:arr[iii]];
                                        [self.view addSubview:img6];
                                        [UIView animateWithDuration:cardT animations:^{
                                            img6.frame = self.bankerCard3.frame;
                                            img6.transform = CGAffineTransformMakeRotation(M_PI*0.5);
                                        }];
                                        
                                        NSInteger playAns = 0;
                                        if ([self.ansArr[0] integerValue] < 10) {
                                            playAns += [self.ansArr[0] integerValue];
                                        }
                                        
                                        if ([self.ansArr[2] integerValue] < 10) {
                                            playAns += [self.ansArr[2] integerValue];
                                        }
                                        
                                        NSInteger bankAns = 0;
                                        if ([self.ansArr[1] integerValue] < 10) {
                                            bankAns += [self.ansArr[1] integerValue];
                                        }
                                        
                                        if ([self.ansArr[3] integerValue] < 10) {
                                            bankAns += [self.ansArr[3] integerValue];
                                        }
                                        
                                        if ([self.pokerDic[arr[iii]] integerValue] < 10) {
                                            bankAns += [self.pokerDic[arr[iii]] integerValue];
                                        }
                                        
                                        while (playAns>=10) {
                                            playAns = playAns - 10;
                                        }
                                        while (bankAns>=10) {
                                            bankAns = bankAns - 10;
                                        }
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [self ab_checkResult:0 addBanker:[self.pokerDic[arr[iii]] integerValue]];
                                            sender.selected=NO;
                                            self.cancelBtn.selected = NO;
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                [self cleanAll];
                                                img1.image = [UIImage imageNamed:@""];
                                                img2.image = [UIImage imageNamed:@""];
                                                img3.image = [UIImage imageNamed:@""];
                                                img4.image = [UIImage imageNamed:@""];
                                                img6.image = [UIImage imageNamed:@""];
                                            });
                                        });
                                    } else if (bankAns<6&&playAns<6) {//追加闲方，并且追加庄方
                                        NSArray *arr = [self randomArray];
                                        
                                        NSInteger iii = arc4random()%3;
                                        NSInteger iiii = arc4random()%3;
                                        
                                        UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                                        img5.image = [UIImage imageNamed:arr[iii]];
                                        [self.view addSubview:img5];
                                        UIImageView *img6 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                                        img6.image = [UIImage imageNamed:arr[iiii]];
                                        [self.view addSubview:img6];
                                        [UIView animateWithDuration:cardT animations:^{
                                            img5.frame = self.playerCard3.frame;
                                            img5.transform = CGAffineTransformMakeRotation(M_PI*0.5);
                                            img6.frame = self.bankerCard3.frame;
                                            img6.transform = CGAffineTransformMakeRotation(M_PI*0.5);
                                        }];
                                        
                                        NSInteger playAns = 0;
                                        if ([self.ansArr[0] integerValue] < 10) {
                                            playAns += [self.ansArr[0] integerValue];
                                        }
                                        
                                        if ([self.ansArr[2] integerValue] < 10) {
                                            playAns += [self.ansArr[2] integerValue];
                                        }
                                        
                                        if ([self.pokerDic[arr[iii]] integerValue] < 10) {
                                            playAns += [self.pokerDic[arr[iii]] integerValue];
                                        }
                                        
                                        NSInteger bankAns = 0;
                                        if ([self.ansArr[1] integerValue] < 10) {
                                            bankAns += [self.ansArr[1] integerValue];
                                        }
                                        
                                        if ([self.ansArr[3] integerValue] < 10) {
                                            bankAns += [self.ansArr[3] integerValue];
                                        }
                                        
                                        if ([self.pokerDic[arr[iiii]] integerValue] < 10) {
                                            bankAns += [self.pokerDic[arr[iiii]] integerValue];
                                        }
                                        
                                        while (playAns>=10) {
                                            playAns = playAns - 10;
                                        }
                                        while (bankAns>=10) {
                                            bankAns = bankAns - 10;
                                        }
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [self ab_checkResult:[self.pokerDic[arr[iii]] integerValue] addBanker:[self.pokerDic[arr[iiii]] integerValue]];
                                            sender.selected=NO;
                                            self.cancelBtn.selected = NO;
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                [self cleanAll];
                                                img1.image = [UIImage imageNamed:@""];
                                                img2.image = [UIImage imageNamed:@""];
                                                img3.image = [UIImage imageNamed:@""];
                                                img4.image = [UIImage imageNamed:@""];
                                                img5.image = [UIImage imageNamed:@""];
                                                img6.image = [UIImage imageNamed:@""];
                                            });
                                        });
                                    } else {//双方都不追加
                                        
                                        
                                        NSInteger playAns = 0;
                                        if ([self.ansArr[0] integerValue] < 10) {
                                            playAns += [self.ansArr[0] integerValue];
                                        }
                                        
                                        if ([self.ansArr[2] integerValue] < 10) {
                                            playAns += [self.ansArr[2] integerValue];
                                        }
                                        
                                        NSInteger bankAns = 0;
                                        if ([self.ansArr[1] integerValue] < 10) {
                                            bankAns += [self.ansArr[1] integerValue];
                                        }
                                        
                                        if ([self.ansArr[3] integerValue] < 10) {
                                            bankAns += [self.ansArr[3] integerValue];
                                        }
                                        
                                        while (playAns>=10) {
                                            playAns = playAns - 10;
                                        }
                                        while (bankAns>=10) {
                                            bankAns = bankAns - 10;
                                        }
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [self ab_checkResult:0 addBanker:0];
                                            sender.selected=NO;
                                            self.cancelBtn.selected = NO;
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                [self cleanAll];
                                                img1.image = [UIImage imageNamed:@""];
                                                img2.image = [UIImage imageNamed:@""];
                                                img3.image = [UIImage imageNamed:@""];
                                                img4.image = [UIImage imageNamed:@""];
                                            });
                                        });
                                    }
                                    
                                } else {
                                    [self ab_checkResult:0 addBanker:0];
                                    sender.selected=NO;
                                    self.cancelBtn.selected = NO;
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [self cleanAll];
                                        img1.image = [UIImage imageNamed:@""];
                                        img2.image = [UIImage imageNamed:@""];
                                        img3.image = [UIImage imageNamed:@""];
                                        img4.image = [UIImage imageNamed:@""];
                                    });
                                }
                            });
                        });
                    });
                });
            }];
        });
    }
}

- (void)ab_showTips:(NSString *)text inView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"提示内容 :%@",text);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = text;
        hud.detailsLabel.font = [UIFont systemFontOfSize:14];
        hud.label.text = @"";
        hud.margin = 10.f;
        hud.userInteractionEnabled = NO;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:0.1];
    });
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

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(15, 15);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma - mark collectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.resultArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    ab_ResultItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:0].firstObject;
    }
    cell.imageName = self.resultArray[indexPath.row];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout

@end
