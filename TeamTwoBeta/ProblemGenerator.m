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

+(NSMutableArray*) loadProblem
{
    // Hard coded for initial iteration.
    
    NSMutableArray *questionAndAnswers = [[NSMutableArray alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"problems" ofType:@"txt"];
    
    NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray* allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    int questionChoice = arc4random()%9*5;
    
    // Create the button objects
    NSLog([allLinedStrings objectAtIndex:questionChoice]);
    [questionAndAnswers addObject:[allLinedStrings objectAtIndex:questionChoice]];
    [questionAndAnswers addObject:[allLinedStrings objectAtIndex:(questionChoice+1)]];
    [questionAndAnswers addObject:[allLinedStrings objectAtIndex:(questionChoice+2)]];
    [questionAndAnswers addObject:[allLinedStrings objectAtIndex:(questionChoice+3)]];
    [questionAndAnswers addObject:[allLinedStrings objectAtIndex:(questionChoice+4)]];
    
    return questionAndAnswers;
}

@end
