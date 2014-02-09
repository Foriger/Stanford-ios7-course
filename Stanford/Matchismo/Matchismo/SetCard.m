//
//  SetCard.m
//  Matchismo
//
//  Created by Radoslav Penev on 2/2/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "SetCard.h"
#import "PlayingCard.h"

@implementation SetCard

+(NSArray *) validShapes
{
    return @[@"●",@"◼︎",@"▲"];
}

+(NSArray *) validColors
{
    return @[[UIColor blueColor],
             [UIColor redColor],
             [UIColor greenColor],
             [UIColor whiteColor],
             [[UIColor blueColor]colorWithAlphaComponent:0.1],
             [[UIColor redColor] colorWithAlphaComponent:0.1],
             [[UIColor greenColor] colorWithAlphaComponent:0.1]];
}

+(NSArray *) validStrokeColors
{
    return @[[UIColor blueColor],[UIColor redColor],[UIColor greenColor]];
}


-(NSString *)contents
{
    NSMutableString *str = [[NSMutableString alloc] init];
    int index = 1;
    while (index <= [self.count intValue]) {
        [str appendString:self.shape];
        index++;
    }
    [str appendString:@" "];
    return [str copy];
}

//TODO:Fix score.
-(int)match:(NSArray *)otherCards{
    int score = 0;
    for(SetCard *other in otherCards){
        
        CGFloat  otherAlpha;
        [other.foregroundColor getRed:nil green:nil blue:nil alpha:&otherAlpha];
        CGFloat selfAlpha;
        [self.foregroundColor getRed:nil green:nil blue:nil alpha:&selfAlpha];
        
        BOOL alphaCondition = (otherAlpha == selfAlpha);
        BOOL colorCondtion = (other.foregroundColor == self.foregroundColor);
        BOOL symbolCondtion = (other.shape == self.shape);
        BOOL countCondition = (other.count == other.count);
        
        if(alphaCondition && colorCondtion && symbolCondtion && !countCondition){
            score +=5;
            return  score;
        }
        else if(!alphaCondition && !colorCondtion && !symbolCondtion && !countCondition){
            score +=5;
            return  score;
        }
        else if(alphaCondition && !colorCondtion && symbolCondtion && countCondition){
            score +=5;
            return  score;
        }
        else if(!alphaCondition && colorCondtion && symbolCondtion && countCondition){
            score +=5;
            return  score;
        }
        else if(alphaCondition && colorCondtion && !symbolCondtion && countCondition){
            score +=5;
            return  score;
        }
        else if(alphaCondition && colorCondtion && symbolCondtion && !countCondition){
            score += 5;
            return  score;
        }
        else if(alphaCondition && colorCondtion && symbolCondtion && countCondition){
            score +=20;
            return  score;
        }
    }
    return  score;
}

@end
