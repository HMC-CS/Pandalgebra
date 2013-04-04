//
//  MainController.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "MainController.h"

@implementation MainController

-(id)init
{
    if(self = [super init]){
        [self scheduleUpdate];
        
        mathProblemView = [MathProblemView node];
        [self addChild:mathProblemView];
        
        answerBarView = [AnswerBarView node];
        [self addChild:answerBarView];
        
        characterView = [CharacterView node];
        [self addChild:characterView];
        
        //[self loadNewProblem];
    }
    
    return self;
}

-(void) loadNewProblem
{
    // Get the questions and answers from the problem generator.
    NSMutableArray *questionAndAnswers = [ProblemGenerator loadProblem];
    
    // Set the math problem.
    [mathProblemView setMathProblem:[questionAndAnswers objectAtIndex:0]];
    
    // Set the possible answers.
    NSString *first = [questionAndAnswers objectAtIndex:1];
    NSString *second = [questionAndAnswers objectAtIndex:2];
    NSString *third = [questionAndAnswers objectAtIndex:3];
    NSString *fourth = [questionAndAnswers objectAtIndex:4];
    
    [answerBarView setAnswerOptions:first secondOption:second thirdOption:third fourthOption:fourth];
}

- (void)update:(ccTime)deltaTime
{
    if (characterView.answerHit){
        [answerBarView answerSelected];
    }
    // We'll always have 4 possible answers/platforms
    NSArray* platforms = [NSArray arrayWithObjects:
                          [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:0]],
                          [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:1]],
                          [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:2]],
                          [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:3]],
                          nil];
    
    [characterView update: deltaTime withPlatforms:platforms andAnswer:answerBarView.correctAnswer];
}

+ (CCScene*)scene
{
    CCScene *scene = [CCScene node];
    
    MainController *mainController = [self node];
    [scene addChild:mainController];
    
    return scene;
}

@end
