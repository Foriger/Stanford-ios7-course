//
//  GameCardBaseViewController.h
//  Matchismo
//
//  Created by Radoslav Penev on 2/9/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardMatchingGame;

@interface GameCardBaseViewController : UIViewController
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (strong,nonatomic) NSMutableArray *historyArray;
-(void) updateUI;
@end
