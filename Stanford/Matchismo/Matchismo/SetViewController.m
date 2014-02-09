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


@interface SetViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (strong,nonatomic) NSMutableArray *historyArray;
@end

@implementation SetViewController

//Load Set cards into view
-(void) viewDidLoad
{
    [self updateUI];
}

-(Deck *) cardDeck
{
    return [[SetCardDeck alloc] init];
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
        _game.mode = 3;
    }
    return _game;
}

- (IBAction)newGame:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self cardDeck]];
    self.scoreLabel.text = @"Score:0";
    self.game.mode = 3;
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"historySegue"]){
        HistoryViewController *historyViewController = segue.destinationViewController;
        historyViewController.historyArray = self.historyArray;
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
