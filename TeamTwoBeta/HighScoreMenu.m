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

@implementation HighScoreScene
-(id)init
{
    if (self = [super init]) {
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create Menu Background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( size.width/2 + 128, size.height/2 - 128);
        [self addChild:background];
        
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"High Scores" fontName:@"Marker Felt" fontSize:64];
        title.position = ccp(size.width /2  + 125, size.height/2);
        [self addChild:title];
        
        
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		// Menu items returning to the main menu
		CCMenuItem *Quit = [CCMenuItemFont itemFromString:@"Quit" target:self selector:@selector(GoToMainMenu:)];
        
		CCMenu *menu = [CCMenu menuWithItems:Quit, nil];
		
		[menu alignItemsVerticallyWithPadding:20];
		[menu setPosition:ccp( size.width/2 + 125, size.height/2 - 100)];
        
		// Add the menu to the layer
		[self addChild:menu];
        
    }
    
    return self;
}

-(void) GoToMainMenu: (id) sender {
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu node]]];
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