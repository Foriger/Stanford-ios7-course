//
//  GameCardViewController.m
//  Matchismo
//
//  Created by Radoslav Penev on 1/20/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "GameCardViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface GameCardViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (strong,nonatomic) NSMutableArray *historyArray;
@end

@implementation GameCardViewController


-(Deck *) cardDeck
{
    return [[PlayingCardDeck alloc] init];
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
        _game.mode =2;
    }
    return _game;
}
- (IBAction)newGame:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self cardDeck]];
    self.scoreLabel.text = @"Score:0";
    self.game.mode = 2;
    self.historyArray = nil;
    [self updateUI];
}


- (IBAction)touchCardButton:(UIButton *)sender {
    int choosedButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosedButtonIndex];
    [self updateUI];
    
}

-(void) updateUI
{
    for(UIButton *button in self.cardButtons){
        int index = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:index];
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d",self.game.score];
    }
    
    if (self.game.matchedCards == nil || [self.game.matchedCards count] == 0) {
        self.explanationLabel.text = @"";
    }
    else {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
        for(PlayingCard *card in [self.game matchedCards]){
            [attr appendAttributedString: [[NSAttributedString alloc] initWithString:card.contents] ];
            [attr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %dp.! ",self.game.score]];
        [attr appendAttributedString:str];
        self.explanationLabel.attributedText = attr;
        [self.historyArray addObject:attr];
        
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"historySegue"]){
        HistoryViewController *historyViewController = segue.destinationViewController;
        historyViewController.historyArray = self.historyArray;
    }
}



-(NSString *) titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) imageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end
