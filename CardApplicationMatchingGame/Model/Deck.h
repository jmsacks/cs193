//
//  Deck.h
//  CardApplicationMatchingGame
//
//  Created by Joshua M. Sacks on 9/22/14.
//  Copyright (c) 2014 JMEventSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard: (Card *)card atTop:(BOOL)atTop;

-(void) addCard:(Card *)card;


- (Card *) drawRandomCard;


@end
