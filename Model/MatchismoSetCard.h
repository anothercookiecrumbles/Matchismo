//
//  MatchismoSetCard.h
//  Matchismo
//
//  Created by Priyanjana Bengani on 18/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "MatchismoCard.h"

@interface MatchismoSetCard : MatchismoCard

@property (strong, nonatomic) NSString* colour;
@property (strong, nonatomic) NSString* shape;
@property (strong, nonatomic) NSString* pattern;
@property (nonatomic) int number;

+ (NSArray*) validColours;
+ (NSArray*) validShapes;
+ (NSArray*) validPatterns;
+ (NSArray*) validNumbers;
+ (int) maxSymbols; // the maximum number of symbols to display per card.

@end
