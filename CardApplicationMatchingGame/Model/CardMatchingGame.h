//
//  CardMatchingGame.h
//  CardApplicationMatchingGame
//
//  Created by Joshua M. Sacks on 9/23/14.
//  Copyright (c) 2014 JMEventSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"


@interface CardMatchingGame : NSObject

//default initalizer
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void) chooseCardAtIndex:(NSUInteger) index;
-(Card *)cardatIndex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSString *message;

@property (nonatomic) NSInteger matchingMode;

@end
