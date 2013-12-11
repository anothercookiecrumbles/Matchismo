//
//  MatchismoPlayingCard.m
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 03/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoPlayingCard.h"

@implementation MatchismoPlayingCard

- (NSString*) contents {
    return [[MatchismoPlayingCard validRanks][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (void) setSuit:(NSString *)suit {
    if ([[MatchismoPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString*) suit {
    return _suit ? _suit : @"?";
}

+ (NSArray*) validRanks {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSArray*) validSuits {
    return @[@"♣︎",@"♠︎",@"♥︎",@"♦︎"];
}

+ (NSUInteger) maxRank {
    return [[self validRanks] count]-1;
}

- (void) setRank:(NSUInteger) rank {
    if ( rank <= [MatchismoPlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int) match:(NSArray *)otherCards {
    int score = 0;
    if ([otherCards count] == 1) {
        MatchismoPlayingCard* otherCard = [otherCards firstObject]; // if array is empty, firstObject returns nil
        if (otherCard) {
            if ([self.suit isEqualToString:otherCard.suit]) {
                score = 1;
            }
            if (self.rank == otherCard.rank) {
                score = 4;
            }
        }
    }
    return score;
}

@end
