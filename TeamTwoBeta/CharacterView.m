//
//  CharacterView.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "CharacterView.h"
#import "SimpleAudioEngine.h"

@implementation CharacterView
@synthesize answerHit = _answerHit;

// Sets the character sprite up.
-(id) init
{
    if (self = [super init]) {
        NUM_ANSWERS = 4;
        
        _answerHit = -1;
        
        // This batchNode has children sprites with images from some subset of character.png.
        CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:@"character.png" capacity:1];
        [self addChild:batchNode z:-1 tag:0];
        
        // The image for the character is in the specified range of character.png.
        // Therefore, make the character a child of the batchNode.
        CCSprite *character = [CCSprite spriteWithTexture:[batchNode texture] rect:CGRectMake(0,0,50,50)];
        [batchNode addChild:character z:4 tag:0];
        
        self.isTouchEnabled = NO;
        self.isAccelerometerEnabled = YES;
        
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
        
        SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
        [engine preloadEffect:@"jump.mp3"];
        
        [self resetCharacter];
    }
    
    return self;
}

-(int) answerSelected:(NSArray*) platforms
{   
    // Consider each platform.
    // plathform width and height need to be confirmed
        
    float platformWidth = 100.0;
    float platformImpactHeight = 40.0;
        
    for (int p = 0; p < NUM_ANSWERS; p++) {
        NSValue *val = [platforms objectAtIndex:p];
        CGPoint currentPlatform = [val CGPointValue];
        float PlatformMaxX = currentPlatform.x + platformWidth/2.0;
        float PlatformMinX = currentPlatform.x - platformWidth/2.0;
        float PlatformMaxY = currentPlatform.y + (platformImpactHeight+50)/2.0;
        float PlatformMinY = currentPlatform.y - platformImpactHeight/2.0;
        
        if(character_pos.x < PlatformMaxX &&
            character_pos.x > PlatformMinX &&
            character_pos.y < PlatformMaxY &&
            character_pos.y > PlatformMinY) {
            
            return p;
        }
    }
    // Not over a platform.
    return -1;
}


- (void)update:(ccTime)deltaTime withPlatforms: (NSArray*)platforms andAnswer: (int)correctAnswer
{
    // Grab data about the character.
    CCSpriteBatchNode *batchNode = (CCSpriteBatchNode*)[self getChildByTag:0];
	CCSprite *character = (CCSprite*)[batchNode getChildByTag:0];
    
    // Update the character's position appropriately.
    character_pos.x += character_vel.x * deltaTime;
    
    CGSize character_size = character.contentSize;
    
    // Since the game is meant to be played in landscape mode,
    // the height of the iPad coordinates to our x-axis.
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    float max_x = height-character_size.width/2;
    float min_x = 0+character_size.width/2;
    
    if(character_pos.x>max_x) character_pos.x=max_x;
    if(character_pos.x<min_x) character_pos.x=min_x;
    
    character_vel.y += character_acc.y* deltaTime;
    character_pos.y += character_vel.y* deltaTime;
    
    // Making sure the character doesn't fall through
    // the bottom of the screen.
    if(character_pos.y < 0)
    {
        character_vel.y = 0;
        character_pos.y = 0;
    }
    
    // Making sure the character doesn't fly through the
    // top of the screen.
    if(character_pos.y > 700)
    {
        character_vel.y = 0;
        character_pos.y = 700;
    }
    
    if(character_vel.y > -18.0 && character_vel.y < 18.0 && character_pos.y < 10.0) {
        [self jump];
    }
    
	character.position = character_pos;
    if (character_vel.y < 0.0) {
        int chosenAnswer = [self answerSelected: platforms];
        _answerHit = chosenAnswer;
       if (chosenAnswer != -1) {
            [self jump];
        }
    }
}


// Sets all the beginning values of the character
-(void) resetCharacter
{
    CCSpriteBatchNode *batchNode = (CCSpriteBatchNode*)[self getChildByTag:0];
	CCSprite *character = (CCSprite*)[batchNode getChildByTag:0];
    
    character_pos.x = 500;
    character_pos.y = 160;
    character.position = character_pos;
    
    character_vel.x = 0;
    character_vel.y = 0;
    
    character_acc.x = 0;
    character_acc.y = -550.f;  //Start with negative y acceleration so character falls
    
    stopped = FALSE;
}

-(void) stopCharacter
{
    
    character_vel.x = 0;
    character_vel.y = 0;
    
    character_acc.x = 0;
    character_acc.y = 0;
    
    CCSprite *candy = [CCSprite spriteWithFile: @"charactercandy.png"];
    
    [self addChild:candy];
    [candy setPosition:ccp(character_pos.x , character_pos.y)];
    
    id rotateCandy = [CCRotateBy actionWithDuration:0.4f angle:180];
    id seq = [CCSequence actions:rotateCandy, rotateCandy, [CCCallFuncN
                                                      actionWithTarget:self  selector:@selector(removeCandy:)], nil];
    [candy runAction:seq];

    
    stopped = TRUE;
}

-(void) removeCandy: (id) sender
{
    [self removeChild:sender cleanup:YES];
    
}

// Controls how high the character jumps.
// The higher the variable, the higher the jump.
-(void) jump
{
    // We add in the absolute value of the x velocity
    // to account for the tilting, so we follow the
    // laws of motion.
    character_vel.y = 680.0f;
    [[SimpleAudioEngine sharedEngine] playEffect:@"jump.mp3"];//play a sound
}

-(void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    // This variable affects how fast the character moves
    // when the screen is tilted.
    float accel_filter = 0.1f;
    // We take the absolute value of the accelerometer data
    // to account for what orientation the iPad is in.
    UIAccelerationValue accelerate = acceleration.y;
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft){
        accelerate = -1*(accelerate);
    }
    // Because we don't care what happens when we tilt
    // vertically, we only change the x velocity
    // when we tilt.
    if(!stopped){
        character_vel.x = character_vel.x * accel_filter + accelerate * (1.0f - accel_filter) * 800.0f;
    }
}

@end
