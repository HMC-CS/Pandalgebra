//
//  PauseMenu.h
//  TeamTwoBeta
//
//  Created by jarthur on 4/18/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface PauseScene : CCLayer {
    int _score;
}

-(void) resume: (id) sender;
-(void) GoToMainMenu: (id) sender;
-(void) GoToHighScoreMenu: (id) sender;
+(id) scene;

@property int score;
@end