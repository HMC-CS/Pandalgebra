//
//  AnswerBarView.h
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "cocos2d.h"

@interface AnswerBarView : CCLayer
{
    NSMutableArray *answerOptionsContainer;
    int _correctAnswer;
    int NUM_ANSWERS;
}

-(void) setAnswerOptions: (NSString*) first secondOption: (NSString*) second thirdOption: (NSString*) third fourthOption: (NSString*) fourth;
-(void) randomizeAnswerOrder: (NSString*) first;
-(void) resetPlatforms;
-(void) answerSelected;
-(void) wrongAnswerSelected: (int) tag;
-(void) answerUnselected;
-(CGPoint) getPlatformPosition: (int) platformTag;
-(void) update: (ccTime) deltaTime;


@property int correctAnswer;

@end
