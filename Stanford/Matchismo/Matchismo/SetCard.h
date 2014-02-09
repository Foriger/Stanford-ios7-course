//
//  SetCard.h
//  Matchismo
//
//  Created by Radoslav Penev on 2/2/14.
//  Copyright (c) 2014 Foriger. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong,nonatomic) NSString *shape;
@property (strong,nonatomic) UIColor *foregroundColor;
@property (strong,nonatomic) NSNumber *count;
@property (strong,nonatomic) UIColor *strokeColor;

+(NSArray *) validShapes;
+(NSArray *) validColors;
+(NSArray *) validStrokeColors;

@end
