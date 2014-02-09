//
//  SetViewController.m
//  Matchismo
//
//  Created by Radoslav Penev on 2/5/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "SetCard.h"
#import "HistoryViewController.h"


@implementation SetViewController

//Load Set cards into view
-(void) viewDidLoad
{
    self.game.mode = 3;
    [self updateUI];
}

-(Deck *) cardDeck
{
    return [[SetCardDeck alloc] init];
}


- (IBAction)newGame:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self cardDeck]];
    self.scoreLabel.text = @"Score:0";
    self.game.mode = 3;
    self.historyArray = nil;
    [self updateUI];
}

-(void) updateUI
{
    for(UIButton *button in self.cardButtons){
        int index = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:index];
        if([card isKindOfClass:[SetCard class]]){
            SetCard *temp = (SetCard *) card;
            [button setAttributedTitle:[self attributtedStringForCard:temp] forState:UIControlStateNormal];
            [button setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
            button.enabled = !card.isMatched;
        }
        button.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d",self.game.score];
    }
    
    if (self.game.matchedCards == nil || [self.game.matchedCards count] == 0) {
        self.explanationLabel.text = @"";
    } else {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
        for(SetCard *card in [self.game matchedCards]){
            [attr appendAttributedString: [self attributtedStringForCard:card]];
            [attr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %dp.!",self.game.score]];
        [attr appendAttributedString:str];
        self.explanationLabel.attributedText = attr;
        [self.historyArray addObject:attr];
    }
}

-(NSAttributedString *)attributtedStringForCard:(SetCard *)card
{
    return [[NSAttributedString alloc] initWithString : card.contents
                                           attributes : @{NSForegroundColorAttributeName :card.foregroundColor,
                                                          NSStrokeWidthAttributeName: @-5,
                                                          NSStrokeColorAttributeName : card.strokeColor} ];
}

-(UIImage *) imageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"selectedSetCard" : @"cardfront"];
}



@end
