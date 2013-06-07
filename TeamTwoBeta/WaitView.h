//
//  WaitView.h
//  pandalgebra
//
//  Created by Kathryn Aplin on 6/3/13.
//
// This comment is a test by Kate. It shouldn't cause conflicts or anything, I just need to check smthg

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "MathProblemView.h"


@interface WaitView : CCLayer{
    NSString *__unsafe_unretained _problem;
}

-(id) initWithProblem:(NSString*)problemString;
+(id)scene;


@property (unsafe_unretained) NSString* problem;


@end
