//
//  MatchismoDeck.h
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 03/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchismoCard.h"

@interface MatchismoDeck : NSObject

- (void) addCard:(MatchismoCard*) card atTop:(BOOL) atTop;

- (MatchismoCard*) drawRandomCard;

@end
