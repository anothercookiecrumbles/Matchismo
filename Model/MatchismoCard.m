//
//  MatchismoCard.m
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 03/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoCard.h"

@implementation MatchismoCard

- (int) match:(NSArray *)otherCards {
    int score = 0;
    for (MatchismoCard *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}
@end
