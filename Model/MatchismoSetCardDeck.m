//
//  MatchismoSetCardDeck.m
//  Matchismo
//
//  Created by Priyanjana Bengani on 18/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "MatchismoSetCardDeck.h"
#import "MatchismoSetCard.h"

@implementation MatchismoSetCardDeck

- (instancetype)init{
    self = [super init];
    
    if (self) {
        for (NSString* colour in [MatchismoSetCard validColours]) {
            for (NSString* shape in [MatchismoSetCard validShapes]) {
                for (NSString* pattern in [MatchismoSetCard validPatterns]) {
                    for (int number = 1; number <= [MatchismoSetCard maxSymbols]; number++) {
                        MatchismoSetCard* setCard = [MatchismoSetCard new];
                        setCard.colour = colour;
                        setCard.shape = shape;
                        setCard.pattern = pattern;
                        setCard.number = number;
                        [self addCard:setCard atTop:NO];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
