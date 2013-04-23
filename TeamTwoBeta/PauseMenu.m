//
//  PauseMenu.m
//  TeamTwoBeta
//
//  Created by jarthur on 4/18/13.
//
//

#import "PauseMenu.h"
#import "MainMenu.h"
#import "HighScoreMenu.h"

@implementation PauseScene
@synthesize score = _score;

-(id) init
{
	if(self = [super init]){
        
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Paused" fontName:@"MarkerFelt" fontSize:60];
        
        label.position = ccp(240, 160);
        
        [self addChild: label];
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:35];
        
        CCMenuItem *Resume = [CCMenuItemFont itemFromString:@"Resume" target:self selector:@selector(resume:)];
        
        CCMenuItem *Highscore = [CCMenuItemFont itemFromString:@"Save high score" target:self
            selector:@selector(GoToHighScoreMenu:)];
        
        CCMenuItem *Quit = [CCMenuItemFont itemFromString:@"Quit" target:self selector:@selector(GoToMainMenu:)];
        
        CCMenu *menu = [CCMenu menuWithItems: Resume, Highscore, Quit, nil];
        menu.position = ccp(240, 131.67f);
        
        [menu alignItemsVerticallyWithPadding:12.5f];
        
        [self addChild:menu];
    }
    return self;
}

-(void) resume: (id) sender {
    
    [[CCDirector sharedDirector] popScene];
}

-(void) GoToMainMenu: (id) sender {
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu node]]
     ];
}

-(void) GoToHighScoreMenu: (id) sender {
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] popScene];
    HighScoreScene *highScoreScene = [HighScoreScene node];
    highScoreScene.score = _score;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1
                                                scene:(CCScene*)highScoreScene]];
}

+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	PauseScene *layer = [PauseScene node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}
@end