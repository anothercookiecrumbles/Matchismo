//
//  MatchismoSetCard.m
//  Matchismo
//
//  Created by Priyanjana Bengani on 18/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "MatchismoSetCard.h"

@interface MatchismoSetCard()

@property (nonatomic,strong) NSMutableDictionary* attributeToArrayDictionary;

@end

@implementation MatchismoSetCard

- (instancetype) init {
    self = [super init];
    
    if (self) {
        // Populate dictionary
        _attributeToArrayDictionary = [NSMutableDictionary new];
        [_attributeToArrayDictionary setObject:[MatchismoSetCard validColours] forKey:@"colour"];
        [_attributeToArrayDictionary setObject:[MatchismoSetCard validPatterns] forKey:@"pattern"];
        [_attributeToArrayDictionary setObject:[MatchismoSetCard validShapes] forKey:@"shape"];
        [_attributeToArrayDictionary setObject:[MatchismoSetCard validNumbers] forKey:@"number"];
    }
    
    return self;
}

+ (NSArray*) validColours {
    return @[@"redColor", @"greenColor", @"purpleColor"];
}

+ (NSArray*) validPatterns {
    return @[@"stripes", @"outline", @"filled"];
}

+ (NSArray*) validShapes {
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSArray*) validNumbers {
    return @[@1,@2,@3]; // Unpretty, but well, it adheres to the Set Game, and makes the match solution slightly more elegant.
}

- (NSString*) contents {
    return [[self.colour stringByAppendingString:self.pattern] stringByAppendingString:self.shape];
}

@synthesize colour = _colour;
@synthesize pattern = _pattern;
@synthesize shape = _shape;

- (void) setColour:(NSString *)colour {
    if ([[MatchismoSetCard validColours] containsObject:colour]) {
        _colour = colour;
    }
}

- (NSString*) colour {
    return _colour ? _colour : @"?";
}

- (void) setPattern:(NSString *)pattern {
    if ([[MatchismoSetCard validPatterns] containsObject:pattern]) {
        _pattern = pattern;
    }
}

- (NSString*) pattern {
    return _pattern ? _pattern : @"?";
}

- (void) setShape:(NSString *)shape {
    if ([[MatchismoSetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString*) shape {
    return _shape ? _shape : @"?";
}

#define SYMBOL_PER_CARD_COUNT 3 // best place for this/best way to do this? hmm... 

+ (int) maxSymbols {
    return SYMBOL_PER_CARD_COUNT;
}

- (void) setNumber:(int)number {
    if ((number <= SYMBOL_PER_CARD_COUNT) && (number > 0)) {
        _number = number;
    }
}

- (int) indexPlusOne:(NSArray*) array of:(id) description {
    if ([array containsObject:description]) {
        return ([array indexOfObject:description]+1);
    }
    else {
        NSLog(@"Unable to find %@ in %@", description, array);
    }
    return 0;
}

- (int) match:(NSArray*)otherCards{
    int score = 0;
    
    NSMutableArray* cards = [otherCards mutableCopy];
    [cards addObject:self];

    bool isSet = true;
    // This isn't going to be pretty.
    for (NSString* attribute in self.attributeToArrayDictionary) {
        int check = 0;
        for (MatchismoSetCard* card in cards) {
            id description = [card valueForKey:attribute]; // Hmm, using ids...
            NSArray* array = self.attributeToArrayDictionary[attribute];
            check += [self indexPlusOne:array of:description];
        }
        if (check % 3 != 0) {
            isSet = false;
            break;
        }
    }
    
    if (isSet) score = 4;
    
    return score;
}

@end
