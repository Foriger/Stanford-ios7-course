//
//  GameCardBaseViewController.m
//  Matchismo
//
//  Created by Radoslav Penev on 2/9/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "GameCardBaseViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface GameCardBaseViewController ()


@end

@implementation GameCardBaseViewController


-(Deck *) cardDeck
{
    return nil;
}


-(NSMutableArray *)historyArray{
    if(!_historyArray){
        _historyArray = [[NSMutableArray alloc] init];
    }
    return _historyArray;
}

-(CardMatchingGame *)game
{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self cardDeck]];
    }
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int choosedButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosedButtonIndex];
    [self updateUI];
}


-(void) updateUI
{
    return;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"historySegue"]){
        HistoryViewController *historyViewController = segue.destinationViewController;
        historyViewController.historyArray = self.historyArray;
    }
}


@end
