//
//  CardMatchingGame.m
//  CardApplicationMatchingGame
//
//  Created by Joshua M. Sacks on 9/23/14.
//  Copyright (c) 2014 JMEventSolutions. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card


@end

@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if(!_cards) _cards=[[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;{
    self = [super init];  //super's designated initalizer
    
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
                
            }else {
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

-(Card *)cardatIndex: (NSUInteger)index;{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE= 1;

-(void) chooseCardAtIndex:(NSUInteger) index; {
    Card *card = [self cardatIndex:index];
    NSMutableArray * chosenCards=[[NSMutableArray alloc] init];
    NSString *listOfCards=card.contents;
    //int chosenCount=0;
    self.message=nil;
    if (!card.isMatched){
        if (card.chosen) {
            card.chosen = NO;
        }else{
            //Counts how many cards are chosen to match against
            for (Card *currentCard in self.cards){
                if (currentCard.isChosen && !currentCard.isMatched){
                    [chosenCards addObject:currentCard];
                    listOfCards = [listOfCards stringByAppendingFormat:@" %@", currentCard.contents];
                NSLog(@"Added object...I think");
            }
            }
            NSLog(@"The current mode is: %ld",(long)self.matchingMode);
            NSLog(@"Currently have %lu chosen cards to match against", (unsigned long)[chosenCards count]);
            
            if ([chosenCards count] == self.matchingMode)  //checks that proper number of cards are chosen
            {
                NSLog(@"Should call Match");
                    int matchScore = [card match:chosenCards];
                NSLog(@"The MatchScore is %d",matchScore);
                if (matchScore) {
                        self.score +=matchScore*MATCH_BONUS;
                    for (Card *otherCard in chosenCards)
                        otherCard.matched= YES;
                        
                        card.matched = YES;
                        //listOfCards = [listOfCards stringByAppendingFormat:@" %@", card.contents];
                        self.message=[NSString stringWithFormat:@"%@ match! \r You get %d points!", listOfCards, matchScore*MATCH_BONUS];
                    card.chosen=YES;
                    return;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *otherCard in chosenCards){
                            otherCard.chosen = NO;
                          //  listOfCards = [listOfCards stringByAppendingFormat:@" %@", otherCard.contents];
                    }
                        //listOfCards = [listOfCards stringByAppendingFormat:@" %@", card.contents];
                        self.message=[NSString stringWithFormat:@"%@ Don't match! \r You loose %d points!", listOfCards, MISMATCH_PENALTY];
                        //card.chosen=YES;
                        return;
                    }
                }
            self.score -= COST_TO_CHOOSE;
            card.chosen=YES;
            if (!self.message) self.message =[NSString stringWithFormat:@"So far you've chosen %@. \r Choose %ld to match!", listOfCards, self.matchingMode+1];
;
        }
    }
}

@end
