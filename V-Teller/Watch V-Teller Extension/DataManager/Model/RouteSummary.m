//
//  RouteSummary.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Model to store route summary info

#import "RouteSummary.h"


#define BaseTime                    @"baseTime"
#define TraficTime                  @"traficTime"
#define TravelTime                  @"travelTime"
#define Distance                    @"distance"
#define Flags                       @"flags"
#define SummeryDisc                 @"summeryDisc"


@implementation RouteSummary

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        self.baseTime       = [[aDecoder decodeObjectForKey:BaseTime] unsignedIntegerValue];
        self.traficTime     = [[aDecoder decodeObjectForKey:TraficTime] unsignedIntegerValue];
        self.travelTime     = [[aDecoder decodeObjectForKey:TravelTime] unsignedIntegerValue];
        self.distance       = [[aDecoder decodeObjectForKey:Distance] unsignedIntegerValue];
        
        self.flags          = [aDecoder decodeObjectForKey:Flags];
        
        self.summeryDisc    = [aDecoder decodeObjectForKey:SummeryDisc];
        
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.baseTime] forKey:BaseTime];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.traficTime] forKey:TraficTime];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.travelTime] forKey:TravelTime];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.distance] forKey:Distance];
    
    [aCoder encodeObject:self.flags forKey:Flags];
    
    [aCoder encodeObject:self.summeryDisc forKey:SummeryDisc];
    
}

@end

