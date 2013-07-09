//
//  HighScoreMenu.h
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 4/7/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface HighScoreScene : CCLayer
{
    int _score;
    UIAlertView *message;
}

-(id) initWithScore: (int) score;
-(void) GoToMainMenu: (id) sender;
-(void) addScore: (NSString*) userName;
-(NSString*) promptForName;
-(void) writeNames: (NSMutableArray*) names andScores: (NSMutableArray*) scores;
+(CCScene *) sceneWithScore: (int) score;

@property int score;
@end