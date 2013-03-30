//
//  MathProblemView.h
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "cocos2d.h"

@interface MathProblemView : CCLayer
{
    CCLabelTTF* mathProblem;
}

-(CCLabelTTF*) setMathProblem: (NSString*) problem;
-(void)update:(ccTime)deltaTime;

@end
