 //
//  CardGameViewController.m
//  CardApplicationMatchingGame
//
//  Created by Joshua M. Sacks on 9/22/14.
//  Copyright (c) 2014 JMEventSolutions. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *gameMessage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchMode;  //matchMode represents the number
                                                                    //of cards you are matching against.
                                                                    //2-card mode would equate to 1 as you
                                                                    //are matching against 1 other card.


@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game)
        _game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
               _game.matchingMode=self.matchMode.selectedSegmentIndex+1;
    return _game;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.matchMode.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];

}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonindex = [self.cardButtons indexOfObject:cardButton];
        Card *card =[self.game cardatIndex:cardButtonindex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text=[NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.gameMessage.text=self.game.message;
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return (card.isChosen) ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen) ? @"cardFront" : @"cardBack"];
}


- (IBAction)newGame:(UIButton *)sender {
    self.game = nil;
    self.matchMode.enabled=YES;
    [self updateUI];
}
- (IBAction)matchMode:(UISegmentedControl *)sender {
    self.game.matchingMode = sender.selectedSegmentIndex + 1;
}


@end
