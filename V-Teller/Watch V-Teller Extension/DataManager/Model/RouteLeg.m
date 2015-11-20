//
//  RouteLeg.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RouteLeg.h"

#define StepsArray                  @"stepsArray"

#define TravelTime                  @"travelTime"
#define Length                      @"length"
#define ShapIndexStart              @"shapIndexStart"
#define ShapIndexEnd                @"shapIndexEnd"


@implementation RouteLeg


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        self.stepsArray              = [aDecoder decodeObjectForKey:StepsArray];
        
        self.travelTime               = [[aDecoder decodeObjectForKey:TravelTime] unsignedIntegerValue];
        self.length                   = [[aDecoder decodeObjectForKey:Length] unsignedIntegerValue];
        self.shapIndexStart           = [[aDecoder decodeObjectForKey:ShapIndexStart] unsignedIntegerValue];
        self.shapIndexEnd             = [[aDecoder decodeObjectForKey:ShapIndexEnd] unsignedIntegerValue];
        
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.stepsArray forKey:StepsArray];
    
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.travelTime] forKey:TravelTime];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.length] forKey:Length];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.shapIndexStart] forKey:ShapIndexStart];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.shapIndexEnd] forKey:ShapIndexEnd];
    
}


@end


