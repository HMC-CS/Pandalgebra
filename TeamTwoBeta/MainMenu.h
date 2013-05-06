//
//  MainMenu.h
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 4/7/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//

#import  <GameKit/GameKit.h>
#import "cocos2d.h"
#import "MainController.h"
#import "Difficulty.h"
#import "InstructionsMenu.h"
#import "CreditsMenu.h"
#import "SimpleAudioEngine.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


@interface MainMenu : CCLayer 

+(id) scene;

@end
