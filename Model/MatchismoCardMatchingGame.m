//
//  MatchismoCardMatchingGame.m
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 09/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoCardMatchingGame.h"

@interface MatchismoCardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards; // an array of Matchismo cards.
@end

@implementation MatchismoCardMatchingGame

- (NSMutableArray*) cards {
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(MatchismoDeck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            MatchismoCard *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card]; // alternatively, self.cards[i] = card;
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (MatchismoCard*) cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define MISMATCH_PENALTY 2 // alternatively, static const int MISMATCH_PENALTY = 2;
#define MATCH_BONUS 4
#define COST_TO_CHOOSE 1

- (void) chooseCardAtIndex:(NSUInteger)index {
    MatchismoCard* card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }
        else {
            for (MatchismoCard* otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore > 0) {
                        self.score += matchScore + MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
