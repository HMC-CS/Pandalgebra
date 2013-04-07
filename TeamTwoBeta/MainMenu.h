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


@interface MainMenu : CCLayer 

+(id) menuScene;
-(void) startGame;

@end
