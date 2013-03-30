//
//  ProblemGenerator.m
//  TeamTwoBeta
//
//  Created by Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker on 3/29/13.
//  Copyright Ari Schlesinger, Abby Gregory, Izzy Funke, and Miranda Parker 2013. All rights reserved.
//
//

#import "ProblemGenerator.h"

@implementation ProblemGenerator

-(NSMutableArray*) loadProblem
{
    // Hard coded for initial iteration.
    
    NSMutableArray *questionAndAnswers = [[NSMutableArray alloc] init];
    
    // Create the button objects
    [questionAndAnswers addObject:@"7x = 77"];
    [questionAndAnswers addObject:@"9"];
    [questionAndAnswers addObject:@"10"];
    [questionAndAnswers addObject:@"11"];
    [questionAndAnswers addObject:@"12"];
    
    return questionAndAnswers;
}

@end
