//
//  MatchismoPlayingCardDeck.m
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 09/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoPlayingCardDeck.h"
#import "MatchismoPlayingCard.h"

@implementation MatchismoPlayingCardDeck

- (instancetype) init {
    self = [super init];
    
    if (self) {
        for (NSString *suit in [MatchismoPlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [MatchismoPlayingCard maxRank]; rank++) {
                MatchismoPlayingCard *playingCard = [[MatchismoPlayingCard alloc] init];
                playingCard.rank = rank;
                playingCard.suit = suit;
                [self addCard:playingCard atTop:false];
            }
        }
    }
    
    return self;
}

@end