//
//  MatchismoPlayingCard.h
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 03/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoCard.h"

@interface MatchismoPlayingCard : MatchismoCard

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray*) validSuits;
+ (NSArray*) validRanks;
+ (NSUInteger) maxRank;


@end
