//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Radoslav Penev on 2/2/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init
{
    self = [super init];
    
    if(self){
        for(NSString *shape in [SetCard validShapes]){
            for(UIColor *color in [SetCard validColors]){
                for(UIColor *strokeColor in [SetCard validStrokeColors]){
                    for(int i =1 ;i <= 3;i++){
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.foregroundColor = color;
                        card.count = [NSNumber numberWithInt:i];
                        if(color == [UIColor whiteColor]){
                            card.strokeColor = strokeColor;
                        }
                        else{
                            card.strokeColor = color;
                        }
                        [self addCard:card];
                    }
                }
            }
        }
        
    }
    return self;
}

@end
