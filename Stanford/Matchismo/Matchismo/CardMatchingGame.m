//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Radoslav Penev on 1/22/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *)matchedCards{
    if(!_matchedCards) _matchedCards = [[NSMutableArray alloc] init];
    return _matchedCards;
}

-(instancetype)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self){
        for(int i = 0;i<cardCount;i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }
            else{
                self = nil;
                break;
            }
        }
    }
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count])? self.cards[index] : nil;
}


static const int MISMATCH_POINT =2;
static const int MATCH_BONUS = 4;
static const int CONST_CHOOSE =1;
-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }
        else{
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    [temp addObject:otherCard];
                    if([temp count]==self.mode-1){
                        int matchScore = [card match:temp];
                        if(matchScore){
                            self.score += matchScore * MATCH_BONUS;
                            for(Card *matchedCard in temp){
                                matchedCard.matched = YES;
                            }
                            card.matched = YES;
                            [temp addObject:card];
                            self.matchedCards = temp;
                        }
                        else{
                            self.score -= MISMATCH_POINT;
                            for(Card *matchedCard in temp){
                                matchedCard.chosen = NO;
                            }
                            card.chosen = NO;
                            [temp addObject:card];
                            self.matchedCards = temp;
                        }
                        
                        break;
                      
                    }
                }
            }
            self.score -=CONST_CHOOSE;
            card.chosen = YES;
            
        }
    }
}
@end
