//
//  CharacterView.h
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "cocos2d.h"
#import "CCSprite.h"

@interface CharacterView : CCLayer
{
    CGPoint character_pos;
    ccVertex2F character_vel;
    ccVertex2F character_acc;
    int NUM_ANSWERS;
    int _answerHit;
    
}
-(id) init;
-(int) answerSelected:(NSArray*) platforms;
-(void)update:(ccTime)deltaTime withPlatforms: (NSArray*)platforms andAnswer:
        (int)correctAnswer;
-(void) dealloc;
-(void) resetCharacter;
-(void) stopCharacter;
-(void) jump;
-(void)accelerometer:(UIAccelerometer*) accelerometer
       didAccelerate:(UIAcceleration *) acceleration;

@property int answerHit;

@end
