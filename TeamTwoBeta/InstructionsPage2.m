//
//  InstructionsMenu.m
//  TeamTwoBeta
//
//  Created by Izzy Funke on 4/22/13.
//
//

#import "InstructionsPage2.h"


@implementation InstructionsPage2

+ (id) instructionsScene
{
    CCScene * instructionsScene = [CCScene node];
    InstructionsPage2 * layer =  [InstructionsPage2 node];
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
        background.position = ccp( size.width/2, size.height/2);
        [self addChild:background];
        
        
        // Default font size will be 28 points.
		[CCMenuItemFont setFontSize:24];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Main Menu" block:^(id sender) {
            
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                                                         scene:[MainMenu node]]];
		}];
        
        CCMenuItem *previous = [CCMenuItemFont itemWithString:@"Previous Section" block:^(id sender) {
            
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                                                         scene:[InstructionsMenu node]]];
		}];
        
        /*CCMenuItem *next = [CCMenuItemFont itemWithString:@"Next Section" block:^(id sender) {
            
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                                                         scene:[InstructionsPage3 node]]];
		}];*/
        
        CCMenu *menu = [CCMenu menuWithItems: previous, back, nil];
        menu.position = ccp(500, 30);
        
        [menu alignItemsHorizontallyWithPadding:250];
        
        [self addChild:menu];
        
        // Get the file from the resources
        NSString* path = [[NSBundle mainBundle] pathForResource:@"instructionspage2" ofType:@"txt"];
        NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        // Create the label
        CCLabelTTF *label = [CCLabelTTF labelWithString:fileContents fontName:@"Marker Felt" fontSize:30];
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
