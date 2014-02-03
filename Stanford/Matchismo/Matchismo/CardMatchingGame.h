//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Radoslav Penev on 1/22/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype) initWithCardCount:(NSUInteger)cardCount
                        usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger) index ;
-(Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) NSInteger mode;
@property (nonatomic,readonly) NSString *explanation;

@end
