//
//  AnswerBarView.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013.
//  All rights reserved.
//

#import "AnswerBarView.h"

@implementation AnswerBarView
@synthesize correctAnswer = _correctAnswer;

// Sets the answer sprites and labels up.
-(id) init
{
    if (self = [super init]) {
        NUM_ANSWERS = 4;
        
        // Initialize the container for the answer labels
        answerOptionsContainer = [[NSMutableArray alloc] init];
        
        // Add labels to answerOptionsContainer
        for (int i = 0; i < NUM_ANSWERS; i++)
        {
            CCLabelTTF* label = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:40];
            label.position = ccp(200 + 200*i, 300);
            [answerOptionsContainer addObject:label];
        }
        
        // Add the answer option labels to this view
        for (int i = 0; i < NUM_ANSWERS; i++)
        {
            [self addChild: [answerOptionsContainer objectAtIndex:i] z: 1 tag: i];
        }
        
        // This batchNode has children sprites with images from some subset of platform.png.
        CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:@"platforms.png" capacity:NUM_ANSWERS];
        [self addChild:batchNode z:-1 tag:4];
        
        // The image for the platform is in the specified range of sprites.png.
        // Therefore, make the platforms children of the batchNode.
        for (int p = 0; p < NUM_ANSWERS; p++)
        {
            CCSprite *platform = [CCSprite spriteWithTexture:[batchNode texture] rect:CGRectMake(0, 0, 100, 40)];
            [batchNode addChild:platform z:3 tag:p];
        }
        
        [self resetPlatforms];
    }
    
    return self;
}

// Handles what happens when an answer is chosen by the player/character
-(void) answerSelected
{
    CCSpriteBatchNode *batchNode = (CCSpriteBatchNode*)[self getChildByTag:4];
    CCSprite *platform = [CCSprite spriteWithTexture:[batchNode texture] rect:CGRectMake(0, 40, 100, 40)];
    [batchNode removeChildByTag:_correctAnswer cleanup:TRUE];
    [batchNode addChild:platform z:3 tag:_correctAnswer];
    [self resetPlatforms];
}

-(void) wrongAnswerSelected: (int) tag
{
    CCSpriteBatchNode *batchNode = (CCSpriteBatchNode*)[self getChildByTag:4];
    CCSprite *platform = [CCSprite spriteWithTexture:[batchNode texture] rect:CGRectMake(0, 80, 100, 40)];
    [batchNode removeChildByTag:tag cleanup:TRUE];
    [batchNode addChild:platform z:3 tag:tag];
    [self resetPlatforms];
}

-(void) answerUnselected
{
    CCSpriteBatchNode *batchNode = (CCSpriteBatchNode*)[self getChildByTag:4];
    
    for(int i = 0; i < 4; i++)
    {
        CCSprite *platform = [CCSprite spriteWithTexture:[batchNode texture] rect:CGRectMake(0, 0, 100, 40)];
        [batchNode removeChildByTag:i cleanup:TRUE];
        [batchNode addChild:platform z:3 tag:i];
    }
    [self resetPlatforms];
}

// Move the platforms to their initial positions
-(void) resetPlatforms
{
    CCSpriteBatchNode *batchNode = (CCSpriteBatchNode*)[self getChildByTag:4];
    
    for (int p = 0; p < NUM_ANSWERS; p++)
    {
        CCSprite *platform = (CCSprite*)[batchNode getChildByTag:p];
        platform.position = ccp(200 + 200*p, 300);
    }
}

-(void) setAnswerOptions: (NSString*) first secondOption: (NSString*) second thirdOption: (NSString*) third fourthOption: (NSString*) fourth
{
    // Reset previous correct platform
    [self answerUnselected];
    
    // Add labels to answerOptionsContainer
    [answerOptionsContainer removeAllObjects];
    [answerOptionsContainer addObject:[CCLabelTTF labelWithString: first fontName:@"Arial" fontSize:40]];
    [answerOptionsContainer addObject:[CCLabelTTF labelWithString: second fontName:@"Arial" fontSize:40]];
    [answerOptionsContainer addObject:[CCLabelTTF labelWithString: third fontName:@"Arial" fontSize:40]];
    [answerOptionsContainer addObject:[CCLabelTTF labelWithString: fourth fontName:@"Arial" fontSize:40]];
    
    [self randomizeAnswerOrder: first];
    
    // Set the position for all the labels in answerOptionsContainer
    for (int i = 0; i < NUM_ANSWERS; i++)
    {
        CCLabelTTF* label = [answerOptionsContainer objectAtIndex:i];
        label.position = ccp(200 + 200*i, 300);
        [answerOptionsContainer replaceObjectAtIndex:i withObject:label];
    }
    
    // Add the answer option labels to this view
    for (int i = 0; i < NUM_ANSWERS; i++)
    {
        [self removeChildByTag:i cleanup:TRUE];
        [self addChild:[answerOptionsContainer objectAtIndex:i] z:1 tag:i];
    }
}

- (void) randomizeAnswerOrder: (NSString*) first
{
    // Randomize order of answers
    for (int i=3; i>=0; i--) {
        int j = arc4random()%(i+1);
        [answerOptionsContainer exchangeObjectAtIndex:i withObjectAtIndex:j];
        // Check whether the placed answers is the correct answer.
        if ([[answerOptionsContainer objectAtIndex: i] string] == first)
            _correctAnswer = i;
    }
}

- (CGPoint) getPlatformPosition: (int) platformTag
{
    CCSpriteBatchNode *batchNode = (CCSpriteBatchNode*)[self getChildByTag:4];
    CCSprite *platform = (CCSprite*)[batchNode getChildByTag:platformTag];
    return platform.position;
}

- (void)update:(ccTime) deltaTime
{

}

@end
