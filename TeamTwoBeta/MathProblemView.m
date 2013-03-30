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
        mathProblem = [self setMathProblem:@"7x = 77"];
        [self addChild:mathProblem];
        
        [self schedule:@selector(update:)];
    }
    
    return self;
}



-(CCLabelTTF*) setMathProblem: (NSString*) problem
{
    
    CCLabelTTF* label = [CCLabelTTF labelWithString: problem fontName:@"Arial" fontSize:150];
    label.position = ccp(500, 600);
    return label;
}

- (void)update:(ccTime)deltaTime
{

}

@end
