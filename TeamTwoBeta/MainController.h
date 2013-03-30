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


@interface MainController : CCScene
{
    CharacterView *characterView;
    AnswerBarView *answerBarView;
    MathProblemView *mathProblemView;
    ProblemGenerator *problemGenerator;
}

-(void) loadNewProblem;
-(void)update:(ccTime)deltaTime;
+(CCScene*)scene;

@end
