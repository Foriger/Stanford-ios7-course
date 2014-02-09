//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Radoslav Penev on 2/9/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController
@property (strong,nonatomic) NSMutableArray *historyArray;
@property (weak, nonatomic) IBOutlet UITextView *textViewStrange;
@end
