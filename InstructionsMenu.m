//
//  InstructionsMenu.m
//  TeamTwoBeta
//
//  Created by Izzy Funke on 4/22/13.
//
//

#import "InstructionsMenu.h"


@implementation InstructionsMenu

+ (id) instructionsScene
{
    CCScene * instructionsScene = [CCScene node];
    InstructionsMenu * layer =  [InstructionsMenu node];
    [instructionsScene addChild: layer];
    return instructionsScene;
}

- (id)init
{
    if ((self = [super init])) {
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        // Create Instructions Background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        NSAssert(background != nil, @"background.png not found. Failed to initialize Instructions");

        background.position = ccp( size.width/2, size.height/2);
        [self addChild:background];
        
        
        // Default font size will be 28 points.
		[CCMenuItemFont setFontSize:24];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Main Menu" block:^(id sender) {
            
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                                            scene:[MainMenu node]]];
		}];
        
        /*
        CCMenuItem *next = [CCMenuItemFont itemWithString:@"Next Section" block:^(id sender) {
            
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                                                         scene:[InstructionsPage2 node]]];
		}];
         */
        
        CCMenu *menu = [CCMenu menuWithItems: back, nil];
        menu.position = ccp(512, 30);
        
        [menu alignItemsHorizontallyWithPadding:250];
        
        [self addChild:menu];
        
        // Get the file from the resources
        NSString* path = [[NSBundle mainBundle] pathForResource:@"instructions" ofType:@"txt"];
        NSAssert(path!=nil, @"instructions.txt not found. Failed to load Instructions screen");
        NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        // Create the label
        CCLabelTTF *label = [CCLabelTTF labelWithString:fileContents fontName:@"Marker Felt" fontSize:20];
        [label setColor:ccWHITE];
        [label setFontSize:34];
        
        // Position it on the screen
        label.position = ccp(500,400);
        
        // Add it to the scene so it can be displayed
        [self addChild:label];
        
    }
    
    return self;
}

@end
