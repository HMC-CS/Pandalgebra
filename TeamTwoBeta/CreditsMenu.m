//
//  CreditsMenu.m
//  pandalgebra
//
//  Created by Abigail Gregory on 5/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CreditsMenu.h"


@implementation CreditsMenu
+ (id) creditsScene
{
    CCScene * creditsScene = [CCScene node];
    CreditsMenu * layer =  [CreditsMenu node];
    [creditsScene addChild: layer];
    return creditsScene;
}

- (id) init
{
    if ((self = [super init])) {
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create Instructions Background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( size.width/2, size.height/2);
        [self addChild:background];
        
        // The menu's title
        int text_width = 400;
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Credits"
                                             dimensions:CGSizeMake(200, 100)
                                             hAlignment:UITextAlignmentLeft
                                             fontName:@"Marker Felt"
                                             fontSize:34];
        title.position = ccp(412-text_width/2, 612);
        [self addChild:title];

        // The text and the main menu button
		[CCMenuItemFont setFontSize:24];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        
        // Get the file from the resources
        NSString* path = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"txt"];
        NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        // Create the label
        CCLabelTTF *label = [CCLabelTTF labelWithString:fileContents
                                             dimensions:CGSizeMake(700, 500)
                                             hAlignment:UITextAlignmentLeft
                                             fontName:@"Marker Felt" fontSize:24];
        [label setColor:ccWHITE];
        
        // Position it on the screen
        label.position = ccp(432,362);
        
        // Add it to the scene so it can be displayed
        [self addChild:label];
        
        // Button to go back to the main menu.
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Main Menu" block:^(id sender) {
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                        scene:[MainMenu node]]];
		}];
        
        CCMenu *menu = [CCMenu menuWithItems: back, nil];
        menu.position = ccp(512, 70);
        
        //[menu alignItemsHorizontallyWithPadding:250];
        
        [self addChild:menu];
        
    }
    
    return self;
}
@end
