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
    MathProblemView *_problem;
}


+(id)scene;

@property MathProblemView* problem;

@end
