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
    NSMutableArray *questionAndAnswers = [[NSMutableArray alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"problems" ofType:@"txt"];
    
    NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray* allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // Groups of 5 because one line of question
    // and 4 lines of answers.
    int questionChoice = (arc4random()%55)*5;
    
    // Create the selected question and answers to the array objects
    for (int i = 0; i < 5; i++){
        [questionAndAnswers addObject:[allLinedStrings objectAtIndex:questionChoice+i]];
    }
    
    return questionAndAnswers;
}

@end
