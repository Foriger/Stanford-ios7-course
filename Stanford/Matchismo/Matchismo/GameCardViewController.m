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

@interface GameCardViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@end

@implementation GameCardViewController


-(Deck *) cardDeck
{
    return [[PlayingCardDeck alloc] init];
}

-(CardMatchingGame *)game
{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self cardDeck]];
    }
    return _game;
}
- (IBAction)newGame:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self cardDeck]];
    self.scoreLabel.text = @"Score:0";
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
    self.explanationLabel.text = [self.game explanation];
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
