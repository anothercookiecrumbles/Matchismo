//
//  MatchismoViewController.m
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 03/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoViewController.h"
#import "MatchismoPlayingCardDeck.h"
#import "MatchismoCardMatchingGame.h"

@interface MatchismoViewController ()
@property (nonatomic, strong) MatchismoDeck *deck;
@property (nonatomic, strong) MatchismoCardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameplayMode;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;


@end

@implementation MatchismoViewController

- (MatchismoDeck*) deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (MatchismoDeck*) createDeck {
    return [[MatchismoPlayingCardDeck alloc] init];
}

- (MatchismoCardMatchingGame*) game {
    if (!_game) _game = [[MatchismoCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                                   usingDeck:[self createDeck]
                                                                    gameMode:[self.gameplayMode selectedSegmentIndex]];
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    long cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}

- (IBAction)redealCards {
    self.gameplayMode.enabled = YES;
    self.game = nil;
    [self updateUI];
}
- (IBAction)selectGameplayMode:(UISegmentedControl *)sender {
    [self redealCards];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        long index = [self.cardButtons indexOfObject:cardButton];
        MatchismoCard* card = [self.game cardAtIndex:index];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (NSString*) titleForCard:(MatchismoCard*) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage*) backgroundImageForCard:(MatchismoCard*) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
