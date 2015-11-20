//
//  StepInLeg.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "StepInLeg.h"


#define Instruction             @"instruction"
#define StepId                  @"stepId"

#define Steplat                 @"steplat"
#define Steplong                @"steplong"


#define StepTime                @"stepTime"
#define StepLength              @"stepLength"



@implementation StepInLeg

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        self.instruction              = [aDecoder decodeObjectForKey:Instruction];
        self.stepId                   = [aDecoder decodeObjectForKey:StepId];
        
        self.steplat                  = [aDecoder decodeDoubleForKey:Steplat];
        self.steplong                 = [aDecoder decodeDoubleForKey:Steplong];
        
        self.stepTime                 = [[aDecoder decodeObjectForKey:StepTime] unsignedIntegerValue];
        self.stepLength               = [[aDecoder decodeObjectForKey:StepLength] unsignedIntegerValue];
        
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.instruction forKey:Instruction];
    [aCoder encodeObject:self.stepId forKey:StepId];
    
    [aCoder encodeDouble:self.steplat forKey:Steplat];
    [aCoder encodeDouble:self.steplong forKey:Steplong];
    
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.stepTime] forKey:StepTime];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.stepLength] forKey:StepLength];
    
}

@end




