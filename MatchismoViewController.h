//
//  MatchismoViewController.h
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 03/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//
//  This is an abstract class. A concrete implementation must follow, which
//  implements createDeck. 
//

#import <UIKit/UIKit.h>
#import "MatchismoDeck.h"
#import "MatchismoCardMatchingGame.h"

@interface MatchismoViewController : UIViewController

- (MatchismoDeck*) createDeck;
- (NSString*) titleForCard:(MatchismoCard*) card;
- (void) updateScore;

@property (nonatomic,strong) MatchismoCardMatchingGame* game;
@property (nonatomic) int gameMode;
@end
