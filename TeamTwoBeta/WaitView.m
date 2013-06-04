//
//  WaitView.m
//  pandalgebra
//
//  Created by Kathryn Aplin on 6/3/13.
//
//

#import "WaitView.h"
#import "MainController.h"


@implementation WaitView
@synthesize problem = _problem;

- (id)init
{
    self = [super init];
    if (self) {
        
        // Initialization code
        
        // Replace with the current problem later
        
        // Ask director for the window size
        [self setIsTouchEnabled:YES];
		CGSize size = [[CCDirector sharedDirector] winSize];
        // Create Background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( size.width/2 , size.height/2 );
        [self addChild:background];
        //_problem = [MathProblemView alloc];
        //[self addChild:_problem];
        
        CCLabelTTF* label = [CCLabelTTF labelWithString: @"TEST" fontName:@"Arial" fontSize:50];
        label.position = ccp(size.width/2,size.height/2);
        [self addChild:label z:1 tag:1];
    
    }
    return self;
}

-(id) initWithProblem:(NSString*)problemString
{
    self = [super init];
    if (self) {
        NSLog(@"initing");
        // Initialization code
        
        // Replace with the current problem later
        
        // Ask director for the window size
        [self setIsTouchEnabled:YES];
		CGSize size = [[CCDirector sharedDirector] winSize];
        // Create Background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( size.width/2 , size.height/2 );
        [self addChild:background];
        
        NSLog(@"about to add problem");
        CCLabelTTF* label = [CCLabelTTF labelWithString: problemString fontName:@"Arial" fontSize:50];

        label.position = ccp(size.width/2,size.height/2);
        [self addChild:label z:1 tag:1];

        //_problem = problemView;
        //_problem = [MathProblemView alloc];
        //[self addChild:_problem];
        
        [self performSelector:@selector(endWaitScene:) withObject: nil afterDelay:10];
        
    }
    NSLog(@"inited");
    return self;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


// return to  the game
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(endWaitScene:) object:nil];
    [[CCDirector sharedDirector] popScene];
}

-(void) endWaitScene: (id) sender{
    [[CCDirector sharedDirector] popScene];
}


+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	WaitView *layer = [WaitView node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

@end
