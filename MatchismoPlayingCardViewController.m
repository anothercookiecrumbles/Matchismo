//
//  MatchismoPlayingCardViewController.m
//  Matchismo
//
//  Created by Priyanjana Bengani on 16/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "MatchismoPlayingCardViewController.h"
#import "MatchismoPlayingCardDeck.h"

@interface MatchismoPlayingCardViewController ()

@end

@implementation MatchismoPlayingCardViewController

- (MatchismoDeck*) createDeck {
    return [MatchismoPlayingCardDeck new];
}

@end