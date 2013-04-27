//
//  MainMenu.m
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

-(id)init
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
		
		[menu alignItemsVerticallyWithPadding:20];
		[menu setPosition:ccp(512, 412)];
        
		// Add the menu to the layer
		[self addChild:menu];
        
        // Add score to list if appropriate
        [self addScore];
    }
    
    return self;
}

-(void) GoToMainMenu: (id) sender
{
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu node]]];
}

-(void) addScore
{
    //NSMutableArray* scores = [[NSMutableArray alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"savedscores" ofType:@"txt"];
    
    NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray* scores = (NSMutableArray*)[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    bool newHighScore = false;
    NSMutableString* replaceWith = [NSMutableString stringWithFormat:@"%d", _score];
    NSMutableString* temp;
    for (int i = 0; i < NUM_SCORES; i++) {
        
        // Add a score of 0 in this position if there is none currently.
        if ([scores count] <= i) {
            [scores addObject: [NSMutableString stringWithFormat:@"0"]];
        }
        
        // Is this a score in the list that the user's score surpasses?
        if ((int)[scores objectAtIndex: i] <= _score) {
            newHighScore = true;
            temp = [scores objectAtIndex:i];
            [scores replaceObjectAtIndex:i withObject:replaceWith];
            replaceWith = temp;
        }
    }
    
    // The user achieved a high score, so prompt for their name.
    if (newHighScore) {
        NSMutableString* name = [NSMutableString stringWithFormat:@"No one yet!"];
    }
    
    // 
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