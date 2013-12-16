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

- (NSString*) description {
    return [self contents];
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

- (int) match:(MatchismoPlayingCard*)firstCard otherCard:(MatchismoPlayingCard*) otherCard {
    int score = 0;
    if ([firstCard isKindOfClass:[MatchismoPlayingCard class]] && [otherCard isKindOfClass:[MatchismoPlayingCard class]]) {
        if (otherCard) {
            if ([firstCard.suit isEqualToString:otherCard.suit]) {
                score = 1;
            }
            if (firstCard.rank == otherCard.rank) {
                score = 4;
            }
        }
    }
    else {
        NSLog(@"The cards to be matched are not of type MatchismoPlayingCard.");
    }
    return score;
}

- (int) match:(NSArray*) otherCards {
    int score = 0;
    NSMutableArray *cards = [otherCards mutableCopy];
    
    for (MatchismoCard* otherCard in otherCards) {
        if ([otherCard isKindOfClass:[MatchismoPlayingCard class]]) {
            MatchismoPlayingCard* matchCard = (MatchismoPlayingCard*) otherCard;
            score += [self match:self otherCard:matchCard];
        
            [cards removeObject:otherCard];
        
            for (MatchismoPlayingCard* card in cards) {
                score += [self match:matchCard otherCard:card];
            }
        }
    }
    
    return score;
}

@end
