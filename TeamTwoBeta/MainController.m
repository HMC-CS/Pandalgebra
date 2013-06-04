//
//  MainController.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "MainController.h"
#import "HighScoreMenu.h"

@implementation MainController

-(id) init
{
    if(self = [super init]){
        [self scheduleUpdate];
        
        mathProblemView = [MathProblemView node];
        [self addChild:mathProblemView];
        
        answerBarView = [AnswerBarView node];
        [self addChild:answerBarView];
        
        characterView = [CharacterView node];
        [self addChild:characterView];
        
        // don't think we need this
        //[self loadNewProblem];
        
        problemDifficulty = 0;
        
        CCMenuItem *pause = [CCMenuItemImage itemWithNormalImage:@"pausebutton.png" selectedImage: @"pausebutton.png" target:self selector:@selector(pause:)];
        
        CCMenu *pauseButton = [CCMenu menuWithItems: pause, nil];
        
        pauseButton.position = ccp(975, 25);

        [self addChild:pauseButton z:1000];
        
        backgroundMusicPlaying = TRUE;
        
        CCMenuItem *backgroundMusic = [CCMenuItemImage itemWithNormalImage:@"soundIcon.png" selectedImage: @"soundIcon.png" target:self selector:@selector(changeBackgroundMusic:)];
        
        CCMenu *backgroundMusicButton = [CCMenu menuWithItems: backgroundMusic, nil];
        
        backgroundMusicButton.position = ccp(512, 25);
        
        [self addChild:backgroundMusicButton z:1000];
        
        noSound = [CCSprite spriteWithFile: @"soundSlash.png"];
        noSound.position = ccp(512,25);
        [noSound retain];

        
        // Scoring Properties Initalized Here
        numWrongChoices = 0;
        
        score = 0;
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:24];
        scoreLabel.position = ccp(140, 20);
        [self addChild:scoreLabel z:1];
        
        scoreWordLabel = [CCLabelTTF labelWithString:@"SCORE:" fontName:@"Arial" fontSize:24];
        scoreWordLabel.position = ccp(60, 20);
        [self addChild:scoreWordLabel z:1];
        
        SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
        [engine preloadEffect:@"tada.mp3"];
        
    }
    
    return self;
}

-(void) loadNewProblem
{
    // each time a problem is loaded, we want to pause the game and display the problem
    waitViewDisplay = YES;
    

    // Start the character back up.
    
    [characterView resetCharacter];
    
    // Get the questions and answers from the problem generator.
    NSMutableArray *questionAndAnswers = [ProblemGenerator loadProblem: problemDifficulty];
    
    // Make sure that this is a different problem from the previous one.
    while ([mathProblemView.problemString isEqualToString: questionAndAnswers[0]])
        questionAndAnswers = [ProblemGenerator loadProblem: problemDifficulty];
    
    // Set the math problem.
    [mathProblemView setMathProblem:[questionAndAnswers objectAtIndex:0]];
    
    // Set the possible answers.
    NSString *first = [questionAndAnswers objectAtIndex:1];
    NSString *second = [questionAndAnswers objectAtIndex:2];
    NSString *third = [questionAndAnswers objectAtIndex:3];
    NSString *fourth = [questionAndAnswers objectAtIndex:4];
    
    [answerBarView setAnswerOptions:first secondOption:second thirdOption:third fourthOption:fourth];
    [questionAndAnswers release];
    
    
}

-(void) addPoints
{
    if (numWrongChoices == 0) {
        score+=30;
    } else if (numWrongChoices == 1) {
        score += 15;
    } else if (numWrongChoices == 3) {
        score -= 15;
    }
    
    if (score<0) {
        score=0;
    }
    
    [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
}

-(void) displayScore
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    NSString *scoreValue = @"+0";
    
    if (numWrongChoices == 0) {
        scoreValue = @"+30";
    } else if (numWrongChoices == 1) {
        scoreValue = @"+15";
    } else if (numWrongChoices == 3) {
        scoreValue = @"-15";
    }
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:scoreValue fontName:@"Arial" fontSize:100];
    
    [self addChild:label];
    [label setPosition:ccp(screenSize.width/2, screenSize.height/1.5)];
    
    id scaleTo = [CCScaleTo actionWithDuration:0.4f scale:1.3f];
    id scaleBack = [CCScaleTo actionWithDuration:0.4f scale:0.1];
    id seq = [CCSequence actions:scaleTo, scaleBack, [CCCallFuncN
                                                      actionWithTarget:self  selector:@selector(removeLabel:)], nil];
    [label runAction:seq];
    
}

-(void) removeLabel: (id) sender
{
    [self removeChild:sender cleanup:YES];
    
}



- (void) update: (ccTime) deltaTime
{
    // displays the wait scene, if needed
    if (waitViewDisplay)
    {
        NSLog(@"About to init");
        WaitView* waitView = [[WaitView alloc] initWithProblem:mathProblemView.problemString];
        //WaitView* waitView = [WaitView node];
        NSLog(@"returned");
        //waitView.problem = mathProblemView;
        //[waitView addChild:mathProblemView];
        [[CCDirector sharedDirector] pushScene:(CCScene*)waitView];
        //[[CCDirector sharedDirector] pushScene:(CCScene*)mathProblemView];
        waitViewDisplay = NO;
    }
    
    if (characterView.answerHit == answerBarView.correctAnswer){
        [[SimpleAudioEngine sharedEngine] playEffect:@"tada.mp3"];
        [answerBarView answerSelected];
        [characterView stopCharacter];
        numTurns++;
        
        if (numTurns >= 10) {
            [self performSelector:@selector(endCondition:)];
        }
        [NSTimer scheduledTimerWithTimeInterval:2 target:self
                                       selector:@selector(loadNewProblem) userInfo:nil repeats:NO];
        [self displayScore];
        [self addPoints];
        numWrongChoices = 0;
        characterView.answerHit = -1;
    }
    else if (characterView.answerHit != -1){
        [answerBarView wrongAnswerSelected: characterView.answerHit];
        characterView.answerHit = -1;
        numWrongChoices += 1;
    }
    
    // We'll always have 4 possible answers/platforms
    platforms = [NSArray arrayWithObjects:
                 [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:0]],
                 [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:1]],
                 [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:2]],
                 [NSValue valueWithCGPoint:[answerBarView getPlatformPosition:3]],
                 nil];

    [characterView update: deltaTime withPlatforms:platforms andAnswer:answerBarView.correctAnswer];
}

-(void) setProblemDifficulty: (int) difficulty
{
    problemDifficulty = difficulty;
    [self performSelector:@selector(loadNewProblem)];
 

}

-(int) problemDifficulty
{
    return problemDifficulty;
}

-(void) pause: (id) sender
{
    PauseMenu *pauseScene = [PauseMenu node];
    pauseScene.score = score;
	[[CCDirector sharedDirector] pushScene:(CCScene*)pauseScene];
}


-(void) changeBackgroundMusic: (id) sender
{
    if (backgroundMusicPlaying)
    {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];//pause background music
        [self addChild: noSound z: 2 ];  // Adds a slash over the volume icon
        
    }
    else{
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cartoon_battle.mp3"];//play background music
        [self removeChild: noSound cleanup:NO];
    }
    backgroundMusicPlaying = !backgroundMusicPlaying;
}

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    MainController *mainController = [self node];
    [scene addChild:mainController];
    
    return scene;
}

-(void) change{
    waitViewDisplay = NO;
}

-(void) endCondition: (id) sender {
    HighScoreScene *highScoreScene = [HighScoreScene node];
    highScoreScene.score = score;
    [[CCDirector sharedDirector] replaceScene: (CCScene*)highScoreScene];
}

@end
