//
//  MatchismoCardMatchingGame.h
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 09/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoDeck.h"

@interface MatchismoCardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger) count usingDeck:(MatchismoDeck*) deck;
- (void) chooseCardAtIndex:(NSUInteger) index;
- (MatchismoCard*) cardAtIndex:(NSUInteger) index;

@property (nonatomic,readonly) NSInteger score;

@end
