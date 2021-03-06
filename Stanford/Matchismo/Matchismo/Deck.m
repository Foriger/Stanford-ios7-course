//
//  Deck.m
//  Matchismo
//
//  Created by Radoslav Penev on 1/20/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "Deck.h"


@interface Deck()
@property (strong,nonatomic)NSMutableArray *cards;
@end

@implementation Deck

-(NSMutableArray *)cards{
    if(!_cards)_cards = [[NSMutableArray alloc] init];
    return _cards;
}


-(Card *)drawRandomCard{
    Card *randomCard = nil;
    
    if([self.cards count]){
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
}

-(void)addCard:(Card *)card{
    [self addCard:card atTop:NO];
}
@end
