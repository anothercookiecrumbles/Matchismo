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
@property (nonatomic,readwrite) NSInteger gameplayMode;
@end

@implementation MatchismoCardMatchingGame

- (NSMutableArray*) cards {
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(MatchismoDeck *)deck gameMode:(NSInteger)mode {
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
        _gameplayMode = mode;
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
            card.chosen = NO; // flip / unselect the card.
        }
        else {
            NSMutableArray* picks = [[NSMutableArray alloc] init];
            for (MatchismoCard* pickedCard in self.cards) {
                if (pickedCard.isChosen && !pickedCard.isMatched) {
                    [picks addObject:pickedCard];
                }
            }
            
            if ([picks count] == self.gameplayMode+1) {
                int score = [card match:picks];
                if (score) {
                    self.score += (score * MATCH_BONUS);
                    card.matched = YES;
                    for (MatchismoCard* pickedCard in picks) {
                        pickedCard.matched = YES;
                    }
                }
                else {
                    self.score -= (MISMATCH_PENALTY * self.gameplayMode);
                    for (MatchismoCard* pickedCard in picks) {
                        pickedCard.chosen = NO;
                        pickedCard.matched = NO;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
