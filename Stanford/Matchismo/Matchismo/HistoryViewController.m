//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Radoslav Penev on 2/9/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "HistoryViewController.h"



@implementation HistoryViewController

-(void)viewDidLoad {
    [self updateUI];
}


-(void)updateUI
{
    NSMutableAttributedString *fullHistory = [[NSMutableAttributedString alloc] init];
    for(NSAttributedString *object in self.historyArray){
        [fullHistory appendAttributedString:object];
        [fullHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n"]];
    }
    self.textViewStrange.attributedText= fullHistory;
}
@end
