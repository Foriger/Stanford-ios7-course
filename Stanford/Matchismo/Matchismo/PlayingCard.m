//
//  PlayingCard.m
//  Matchismo
//
//  Created by Radoslav Penev on 1/20/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return  [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;
+(NSArray *)validSuits
{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"
             ,@"10",@"J",@"Q",@"K"];
}
+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

-(int)match:(NSArray *)otherCards{
    int score = 0;
    if([otherCards count]==1){
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank){
            score = 4;
        }
        else if ([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }
    else{
        for(PlayingCard *other in otherCards){
            if(other.rank == self.rank){
                score +=2;
            }
            else if ([other.suit isEqualToString:self.suit]){
                score +=1;
            }

        }
    }
    
    return  score;
}

-(NSString *)description{
    return  [NSString stringWithFormat:@"%lu%@",(unsigned long)self.rank,self.suit];
}
@end

