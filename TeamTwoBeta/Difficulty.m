//
//  Difficulty.m
//  TeamTwoBeta
//
//  Created by Izzy Funke on 4/23/13.
//
//

#import "Difficulty.h"

@implementation Difficulty

+ (id) difficultyScene
{
    CCScene * difficultyScene = [CCScene node];
    Difficulty * layer =  [Difficulty node];
    [difficultyScene addChild: layer];
    return difficultyScene;
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
        
        [CCMenuItemFont setFontSize:50];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        
        MainController *mainController = [MainController node];

        
        CCMenuItem *easy = [CCMenuItemFont itemWithString:@"Easy" block:^(id sender) {
            [mainController setProblemDifficulty: 0];
			[[CCDirector sharedDirector] replaceScene: mainController];
        }];
        
        CCMenuItem *hard = [CCMenuItemFont itemWithString:@"Hard" block:^(id sender) {
            [mainController setProblemDifficulty: 1];
			[[CCDirector sharedDirector] replaceScene: mainController];
		}];
        
        CCMenuItem *back = [CCMenuItemFont itemWithString:@"Back" block:^(id sender) {
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                                        scene:[MainMenu node]]];
		}];
        
        CCMenu *menu = [CCMenu menuWithItems: easy, hard, back, nil];
        menu.position = ccp(500, 400);
        
        [menu alignItemsVerticallyWithPadding:40];
        
        [self addChild:menu];
        
    }
    
    return self;
}

@end
