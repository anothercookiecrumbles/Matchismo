//
//  MatchismoSetCardViewController.m
//  Matchismo
//
//  Created by Priyanjana Bengani on 18/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "MatchismoSetCardViewController.h"
#import "MatchismoSetCardDeck.h"
#import "MatchismoSetCard.h"

@interface MatchismoSetCardViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation MatchismoSetCardViewController

- (void) awakeFromNib {
    [super awakeFromNib];
    self.gameMode = 1; // Set mandates a three-card match. Hence, defaulting the gameMode to be three-card match.
}

- (MatchismoDeck*)createDeck {
    return [[MatchismoSetCardDeck alloc] init];
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

/*
 * @Overridde : Yes, I know this isn't java, but it still seems important to highlight the intent. 
 * No compile-time checking though. Would be nice if Objective-C had something similar to 
 * annotations in Java, or attributes in C#.
 */
- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        long index = [self.cardButtons indexOfObject:cardButton];
        MatchismoCard* card = [self.game cardAtIndex:index];
        if (![card isKindOfClass:[MatchismoSetCard class]]) {
            NSLog(@"The card is not of type MatchismoSetCard, and hence is not valid for the Set game.");
            return;
        }
        NSAttributedString* displayString = [self constructDisplayString:(MatchismoSetCard*)card];
        [cardButton setAttributedTitle:displayString forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    [self updateScore];
}

- (NSAttributedString*) constructDisplayString:(MatchismoSetCard*) card {
    NSAttributedString* stringToDisplay = [NSMutableAttributedString new];
    // dictionary to collect the attributes, which need to be applied to the card.
    NSMutableDictionary *attributeDictionary = [NSMutableDictionary new];
    NSString* shape = @"";
    
    if (card.pattern && card.shape && card.colour && card.number) {
        SEL colourSelector = NSSelectorFromString(card.colour);
        UIColor* colour = [UIColor clearColor];
        if ([UIColor respondsToSelector:colourSelector]) {
            colour = [UIColor performSelector:colourSelector];
        }
        else {
            NSLog(@"Unrecognised colour %@", card.colour);
        }
        [attributeDictionary setObject:colour forKey:NSForegroundColorAttributeName];

        if ([card.pattern isEqualToString:@"stripes"]) {
            // I don't know how to create stripes/gradients on text, without using a UIImage.
            // However, I don't really want to create multiple UIImages simply to create a pattern.
            // There has to be a more elegant solution, but for now, just do an outline with a different colour.
            // How slack!
            [attributeDictionary setObject:[UIColor blueColor] forKey:NSStrokeColorAttributeName];
            [attributeDictionary setObject:@-4 forKey:NSStrokeWidthAttributeName];
        }
        else if ([card.pattern isEqualToString:@"outline"]) {
            [attributeDictionary setObject:[UIColor blackColor] forKey:NSStrokeColorAttributeName];
            [attributeDictionary setObject:@-4 forKey:NSStrokeWidthAttributeName];
            [attributeDictionary setObject:[attributeDictionary[NSForegroundColorAttributeName] colorWithAlphaComponent:0.7] forKey:NSForegroundColorAttributeName];
        }
        else if ([card.pattern isEqualToString:@"filled"]) {
            // Do nothing? The "NSForegroundColorAttributeName" set with the colours should take care of it.
        }
        else {
            NSLog(@"Unrecognised pattern %@", card.pattern);
        }
        
        if ([card.shape isEqualToString:@"oval"]) {
            shape = @"●";
        }
        else if ([card.shape isEqualToString:@"squiggle"]) {
            shape = @"✭";
        }
        else if ([card.shape isEqualToString:@"diamond"]) {
            shape = @"▲";
        }
        else {
            NSLog(@"Unrecognised shape %@", card.shape);
        }
        
        shape = [shape stringByPaddingToLength:card.number withString:shape startingAtIndex:0];
        
        stringToDisplay = [[NSAttributedString alloc] initWithString:shape attributes:attributeDictionary];
    }
    else {
        // NSLog does the stringWithFormat, so that I don't have to.
        NSLog(@"All the card attributes are not set. Pattern:%@, Shape:%@, Colour:%@, Number:%d",
              card.pattern, card.shape, card.colour, card.number);
    }
    
    return stringToDisplay;
}

@end