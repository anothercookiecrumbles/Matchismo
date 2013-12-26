//
//  MatchismoViewController.m
//  Stanford_Matchismo
//
//  Created by Priyanjana Bengani on 03/12/2013.
//  Copyright (c) 2013 Priyanjana Bengani. All rights reserved.
//

#import "MatchismoViewController.h"
#import "MatchismoCardMatchingGame.h"
#import "MatchismoHistoryViewController.h"

@interface MatchismoViewController ()
@property (nonatomic, strong) MatchismoDeck *deck;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameplayMode;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextView *moveDetails;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) NSMutableArray *history;
@end

@implementation MatchismoViewController

- (MatchismoDeck*) deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (MatchismoDeck*) createDeck{ // abstract method
    return nil;
}

- (NSMutableArray*) history {
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

- (MatchismoCardMatchingGame*) game {
    if (!_game) _game = [[MatchismoCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                                   usingDeck:[self createDeck]
                                                                    gameMode:self.gameMode];
    return _game;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        // Ugh, this is only to ensure that stuff is aligned properly. Unpretty, but automaticallyAdjustsScrollViewInsets = NO doesn't work.
        self.moveDetails.textContainerInset = UIEdgeInsetsMake(2,2,0,0);
    }
    self.moveDetails.clipsToBounds = YES;
    self.moveDetails.layer.cornerRadius = 10.0f;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.gameplayMode.enabled = NO;
    long cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}

- (IBAction)redealCards {
    self.gameplayMode.enabled = YES;
    self.game = nil;
    self.history = nil;
    [self updateUI];
}

- (IBAction)selectGameplayMode:(UISegmentedControl *)sender {
    self.gameMode = [self.gameplayMode selectedSegmentIndex];
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
    [self updateScore];
    [self updateLastMove];
}

- (void) updateScore {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void) updateLastMove {
    if (self.game.lastMove) {   // only update if there is a last move.
        NSAttributedString* details = [self lastMove];
        if (self.game.lastMoveScore > 0) { // this would indicate a match
            NSMutableAttributedString* move = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [move appendAttributedString:details];
            [move appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points!",self.game.lastMoveScore]]];
            details = (NSAttributedString*) move;
        }
        else {
            int absoluteScore = abs(self.game.lastMoveScore);
            NSMutableAttributedString* move = [[NSMutableAttributedString alloc] initWithAttributedString:details];
            [move appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match. %d points penalty!",absoluteScore]]];
            details = [[NSAttributedString alloc] initWithAttributedString:move];
        }
        self.moveDetails.attributedText = details;
        [self.history addObject:details];
    }
    else {
        self.moveDetails.attributedText = nil; // reset the text, so you don't have nasty "(null)" text.
    }
}

- (NSAttributedString*) lastMove {
    NSMutableArray* pickedCards = [[NSMutableArray alloc] init];
    for (MatchismoCard* pickedCard in self.game.lastMove) {
        [pickedCards addObject:pickedCard.description];
    }
    NSAttributedString* cards = [[NSAttributedString alloc] initWithString:[pickedCards componentsJoinedByString:@", "]];
    return cards;
}

- (void) updateHistorySliderOnLastMove {
    if (self.game.lastMove) {
    }
}

- (NSString*) titleForCard:(MatchismoCard*) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage*) backgroundImageForCard:(MatchismoCard*) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void) prepareForSegue:(UIStoryboardSegue *)identifier sender:(id)sender {
    if ([identifier.identifier isEqualToString:@"View History"]) {
        if ([identifier.destinationViewController isKindOfClass:[MatchismoHistoryViewController class]]) {
            MatchismoHistoryViewController* hvc = (MatchismoHistoryViewController*) identifier.destinationViewController;
            hvc.history = self.history;
        }
    }
}

@end
