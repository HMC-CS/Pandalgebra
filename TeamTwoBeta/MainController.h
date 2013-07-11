//
//  MainController.h
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "cocos2d.h"
#import "CharacterView.h"
#import "AnswerBarView.h"
#import "MathProblemView.h"
#import "ProblemGenerator.h"
#import "PauseMenu.h"
#import "HighScoreMenu.h"
#import "SimpleAudioEngine.h"
#import "WaitView.h"

@interface MainController : CCScene
{
    CharacterView *characterView;
    AnswerBarView *answerBarView;
    MathProblemView *mathProblemView;
    ProblemGenerator *problemGenerator;
    int score;
    int numWrongChoices;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *scoreWordLabel;
    NSArray* platforms;
    BOOL backgroundMusicPlaying;
    int problemDifficulty;
    CCSprite* noSound;
    BOOL waitViewDisplay;
    int numTurns;
    
    NSMutableArray* previousProblems;
}

-(id) init;
-(void) loadNewProblem;
-(void) addPoints;
-(void) displayScore;
-(void) removeLabel: (id) sender;
-(void) update: (ccTime) deltaTime;
-(void) setProblemDifficulty: (int) difficulty;
-(int) problemDifficulty;
-(void) pause: (id) sender;

-(void) changeBackgroundMusic: (id) sender;
+(CCScene*) scene;

@end

