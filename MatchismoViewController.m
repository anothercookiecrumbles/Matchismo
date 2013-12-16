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
@property (weak, nonatomic) IBOutlet UITextView *moveDetails;
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
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    [self updateLastMove];
}

- (void) updateLastMove {
    if (self.game.lastMove) {   // only update if there is a last move. 
        NSString* defineMove = [[NSString alloc] init];
        NSMutableArray* pickedCards = [[NSMutableArray alloc] init];
        for (MatchismoCard* pickedCard in self.game.lastMove) {
            [pickedCards addObject:pickedCard.description];
        }
        if (self.game.lastMoveScore > 0) { // this would indicate a match
            defineMove = [NSString stringWithFormat:@"Matched %@ for %d points",[pickedCards componentsJoinedByString:@", "],self.game.lastMoveScore];
        }
        else {
            int absoluteScore = abs(self.game.lastMoveScore);
            defineMove = [NSString stringWithFormat:@"%@ don't match! %d points penalty!",[pickedCards componentsJoinedByString:@","],absoluteScore];
        }
        self.moveDetails.text = defineMove;
    }
    else {
        self.moveDetails.text = @""; // reset the text, so you don't have nasty "(null)" text.
    }
}

- (NSString*) titleForCard:(MatchismoCard*) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage*) backgroundImageForCard:(MatchismoCard*) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
