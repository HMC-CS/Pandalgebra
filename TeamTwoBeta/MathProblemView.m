//
//  MathProblemView.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "MathProblemView.h"

@implementation MathProblemView
- (id)init
{
    if ((self = [super init])) {
        
        // Initialize background
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background];
        
        // Initialize and add Math Problem to Screen/View
        CCLabelTTF* label = [CCLabelTTF labelWithString: @"" fontName:@"Arial" fontSize:50];
        //label.position = ccp(500, 600);
        [self addChild:label z:1 tag:1];
    }
    
    return self;
}



-(void) setMathProblem: (NSString*) problem
{
    CCLabelTTF* label = [CCLabelTTF labelWithString: problem fontName:@"Arial" fontSize:50];
    label.position = ccp(500, 600);
    mathProblem = label;
    //CCNode* child = [self getChildByTag:1];
    [self removeChildByTag:1 cleanup:TRUE];
    [self addChild:label z:1 tag:1];
}

- (void)update:(ccTime)deltaTime
{

}

@end
