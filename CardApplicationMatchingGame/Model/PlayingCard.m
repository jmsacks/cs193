//
//  PlayingCard.m
//  CardApplicationMatchingGame
//
//  Created by Joshua M. Sacks on 9/22/14.
//  Copyright (c) 2014 JMEventSolutions. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


- (int)match:(NSArray *)otherCards {
    NSLog(@"Entered Match");
    int score =0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            return score = 1;
        } else if (self.rank == otherCard.rank) {
            return score = 4;
        }
        
    } else {
        for (Card *otherCard in otherCards) score += [self match:@[otherCard]];
        PlayingCard *nextCard = [otherCards firstObject];
        score += [nextCard match:[otherCards subarrayWithRange:NSMakeRange(1, ([otherCards count] - 1))]];
        
    }
    
    return score;
}
- (NSString *) contents{
    
    NSArray *rankStrings=[PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit =_suit;

+ (NSArray *) validStuits
{
    return @[@"♣", @"♠", @"♦", @"♥"];
}
+ (NSArray *) rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (void) setSuit:(NSString *)suit{
    if ([[PlayingCard validStuits] containsObject:suit])
    {
        _suit = suit;
    }
    
}

- (NSString *) suit{
    return _suit ? _suit:@"?";
}

+ (NSUInteger) maxRank {return [[self rankStrings] count]-1;}

- (void) setRank:(NSUInteger)rank {
    if (rank<= [PlayingCard maxRank])
        _rank=rank;
}

@end
