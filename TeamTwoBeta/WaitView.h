//
//  WaitView.h
//  pandalgebra
//
//  Created by Kathryn Aplin on 6/3/13.
//
//

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
