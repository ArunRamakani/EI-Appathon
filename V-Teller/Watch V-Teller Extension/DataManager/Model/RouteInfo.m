//
//  RouteInfo.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RouteInfo.h"

#define LegArray                  @"legArray"
#define ShapArr                   @"shapArr"
#define Summary                   @"summary"
#define BoundBox                  @"boundBox"
#define WayPoints                  @"wayPoints"

@implementation RouteInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        self.legArray           = [aDecoder decodeObjectForKey:LegArray];
        self.shapArr            = [aDecoder decodeObjectForKey:ShapArr];
        self.summary            = [aDecoder decodeObjectForKey:Summary];
        self.boundBox           = [aDecoder decodeObjectForKey:BoundBox];
        self.wayPoints          = [aDecoder decodeObjectForKey:WayPoints];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.legArray forKey:LegArray];
    [aCoder encodeObject:self.shapArr forKey:ShapArr];
    [aCoder encodeObject:self.summary forKey:Summary];
    [aCoder encodeObject:self.boundBox forKey:BoundBox];
    [aCoder encodeObject:self.wayPoints forKey:WayPoints];
}

@end

