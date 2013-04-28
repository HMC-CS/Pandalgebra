//
//  Difficulty.h
//  TeamTwoBeta
//
//  Created by Izzy Funke on 4/23/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "MainController.h"
#import "MainMenu.h"
#import "GlobalVariables.h"

@interface Difficulty : CCLayer
{
    GlobalVariables *globalVariables;
}


+ (id) difficultyScene;
- (id)init;

@end