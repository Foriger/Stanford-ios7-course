//
//  Deck.h
//  Matchismo
//
//  Created by Radoslav Penev on 1/20/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;
@end
