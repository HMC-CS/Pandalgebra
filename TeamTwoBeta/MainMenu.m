//
//  MainMenu.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 4/7/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//

// Background image used for noncommericial use as allowed by Mike Lowe. Original image found at following link
// http://www.flickr.com/photos/mikelowe/17520932/sizes/l/


#import "MainMenu.h"

@implementation MainMenu
-(id) init
{
    if (self = [super init]) {

        
        // Create Menu Background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        NSAssert(background != nil, @"background.png not found. Failed to initialize MainMenu");
        //background.position = ccp( size.width/2 + 128, size.height/2 - 128);
        background.position = ccp(512, 384);
        [self addChild:background];
        
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"PANDALGEBRA" fontName:@"Marker Felt" fontSize:64];
        title.position = ccp(512, 512);
        [self addChild:title];

		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		// Menu items for playing the game and exiting the game
		CCMenuItem *playGame = [CCMenuItemFont itemWithString:@"Play Game" block:
        ^(id sender) {
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                        scene:[Difficulty node]]];
		}];
        
        CCMenuItem *instructions = [CCMenuItemFont itemWithString:@"Instructions" block:^(id sender) {
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                        scene:[InstructionsMenu node]]];
		}];
        
        CCMenuItem *highScore = [CCMenuItemFont itemWithString:@"High Scores" block:^(id sender) {
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                                                         scene:[HighScoreScene sceneWithScore:0]]];
		}];
        
        
        CCMenuItem *credits = [CCMenuItemFont itemWithString:@"Credits" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                        scene:[CreditsMenu node]]];
		}];
        
  

		CCMenu *menu = [CCMenu menuWithItems:playGame, instructions, highScore, credits, nil];
		
		[menu alignItemsVerticallyWithPadding:20];
        [menu setPosition:ccp(512, 300)];
        
        //play background music
        NSString* path = [[NSBundle mainBundle] pathForResource:@"cartoon_battle" ofType:@"mp3"];
        NSAssert(path != nil, @"Failed to locate background music cartoon_battle.mp3");
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cartoon_battle.mp3"];
        
        
		// Add the menu to the layer
		[self addChild:menu];

    }
    
    return self;
}


+(id) scene
{
    CCScene *menuScene = [CCScene node];
    MainMenu *layer = [MainMenu node];
    [menuScene addChild:layer];
    return menuScene;
}

@end
