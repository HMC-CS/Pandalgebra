//
//  HighScoreMenu.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 4/7/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//

// Background image used for noncommericial use as allowed by Mike Lowe. Original image found at following link
// http://www.flickr.com/photos/mikelowe/17520932/sizes/l/


#import "HighScoreMenu.h"
#import "MainMenu.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

int NUM_SCORES = 5;

@implementation HighScoreScene
@synthesize score = _score;

-(id) init
{
    if (self = [super init]) {
        
        // Ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create menu nackground
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( size.width/2, size.height/2);
        [self addChild:background];
        
        // Create menu title
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"High Scores" fontName:@"Marker Felt" fontSize:64];
        title.position = ccp(512, 512);
        [self addChild:title];
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
        
        // Menu item for returning to the main menu
        CCMenuItem *quit = [CCMenuItemFont itemWithString:@"Quit" target:self selector:@selector(GoToMainMenu:)];
        
        CCMenu *menu = [CCMenu menuWithItems:quit, nil];
        
        [menu alignItemsVerticallyWithPadding:700];
        [menu setPosition:ccp(512, 200)];
        
        // Add the menu to the layer
        [self addChild:menu];
        
        // Prompt the user for their name. Their score will then be added to the list
        // if appropriate.
        if (_score > 0) {
            [self promptForName];

        } else {
            [self displayScore];
        }
    }
    
    return self;
}

-(void) GoToMainMenu: (id) sender
{
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu node]]];
}

-(void) displayScore {
    
    // Get the document directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    
    // Read in the scores
    NSString* scoresPath = [NSString stringWithFormat:@"%@/savedscores.txt", directory];
    
    NSString* fileContents = [NSString stringWithContentsOfFile:scoresPath encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray* scores = (NSMutableArray*)[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // Read in the names
    NSString* namesPath = [NSString stringWithFormat:@"%@/savednames.txt", directory];
    fileContents = [NSString stringWithContentsOfFile:namesPath encoding:NSUTF8StringEncoding
                                                error:nil];
    NSMutableArray* names = (NSMutableArray*)[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // Initialize the arrays to default values if they're empty.
    if ([names count] == 0) {
        names = [NSMutableArray arrayWithCapacity:NUM_SCORES];
        scores = [NSMutableArray arrayWithCapacity:NUM_SCORES];
        for (int i = 0; i < NUM_SCORES; i++) {
            [names insertObject:@"No one yet!" atIndex:i];
            [scores insertObject:@"0" atIndex:i];
        }
    }
    
    //write to screen
    [self writeNames: names andScores: scores];

}

-(void) addScore: (NSString*) userName
{
    // Get the user's information
    NSMutableString* userScore = [NSMutableString stringWithFormat:@"%d", _score];
    
    // Get the document directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    
    // Read in the scores
    NSString* scoresPath = [NSString stringWithFormat:@"%@/savedscores.txt", directory];
    
    NSString* fileContents = [NSString stringWithContentsOfFile:scoresPath encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray* scores = (NSMutableArray*)[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // Read in the names
    NSString* namesPath = [NSString stringWithFormat:@"%@/savednames.txt", directory];
    fileContents = [NSString stringWithContentsOfFile:namesPath encoding:NSUTF8StringEncoding
                                                error:nil];
    NSMutableArray* names = (NSMutableArray*)[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // Initialize the arrays to default values if they're empty.
    if ([names count] == 0) {
        names = [NSMutableArray arrayWithCapacity:NUM_SCORES];
        scores = [NSMutableArray arrayWithCapacity:NUM_SCORES];
        for (int i = 0; i < NUM_SCORES; i++) {
            [names insertObject:@"No one yet!" atIndex:i];
            [scores insertObject:@"0" atIndex:i];
        }
    }
    
    // Put the user in the list
    int newHighScore = -1;
    for (int i = 0; i < NUM_SCORES; i++) {
        // Is this a score in the list that the user's score surpasses?
        if ([[scores objectAtIndex: i] intValue] <= _score) {
            // Store their place
            if (newHighScore == -1) {
                newHighScore = i;
                [scores insertObject:userScore atIndex:i];
                [scores removeLastObject];
                [names insertObject:userName atIndex:i];
                [names removeLastObject];
            }
        }
    }
    
    // Write out to the files
    NSString* scoresOut = [scores componentsJoinedByString:@"\n"];
    [scoresOut writeToFile:scoresPath atomically:YES
                  encoding:NSUTF8StringEncoding error:noErr];
    NSString* namesOut = [names componentsJoinedByString:@"\n"];
    [namesOut writeToFile:namesPath atomically:YES
                  encoding:NSUTF8StringEncoding error:noErr];    
    
    // Write to the screen
    [self writeNames: names andScores: scores];
}

-(NSString*) promptForName
{
    message = [[UIAlertView alloc] initWithTitle:@"What is your name?"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"Anonymous"
                                                otherButtonTitles:@"Save name", nil];
        
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
    return [message textFieldAtIndex:0].text;
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self addScore: [message textFieldAtIndex:0].text];
    }
    else {
        [self addScore: @"Anonymous"];
    }
}

-(void) writeNames: (NSMutableArray*) names andScores: (NSMutableArray*) scores
{
    for (int i = 0; i < [names count]; i++) {
        // Create the label
        CCLabelTTF *label = [CCLabelTTF labelWithString:[names objectAtIndex:i]
                                           dimensions:CGSizeMake(220, 30)
                                           hAlignment:UITextAlignmentLeft
                                           fontName:@"Marker Felt" fontSize:30];
        [label setColor:ccWHITE];
        [label setFontSize:30];
    
        // Position it on the screen
        label.position = ccp(400,450-30*i);
    
        // Add it to the scene so it can be displayed
        [self addChild:label];
    }
    
    for (int i = 0; i < [scores count]; i++) {
        // Create the label
        CCLabelTTF *label = [CCLabelTTF labelWithString:[scores objectAtIndex:i]
                                             dimensions:CGSizeMake(220, 30)
                                             hAlignment:UITextAlignmentRight
                                             fontName:@"Marker Felt" fontSize:30];
        [label setColor:ccWHITE];
        [label setFontSize:30];
        
        // Position it on the screen
        label.position = ccp(620,450-30*i);
        
        // Add it to the scene so it can be displayed
        [self addChild:label];
    }
}

-(void) dealloc
{
    [super dealloc];
}

+(id) scene
{
    CCScene *highScoreScene = [CCScene node];
    HighScoreScene *layer = [HighScoreScene node];
    [highScoreScene addChild:layer];
    return highScoreScene;
}

@end