//
//  BoundingBox.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "BoundingBox.h"

#define TopLeftLatitude                @"topLeftlatitude"
#define TopLeftLongitude               @"topLeftlongitude"
#define BottomRightLatitude            @"bottomRightlatitude"
#define BottomRightLongitude           @"bottomRightlongitude"


@implementation BoundingBox


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        self.topLeftlatitude            = [aDecoder decodeDoubleForKey:TopLeftLatitude];
        self.topLeftlongitude           = [aDecoder decodeDoubleForKey:TopLeftLongitude];
        self.bottomRightlatitude        = [aDecoder decodeDoubleForKey:BottomRightLatitude];
        self.bottomRightlongitude       = [aDecoder decodeDoubleForKey:BottomRightLongitude];
        
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:self.topLeftlatitude forKey:TopLeftLatitude];
    [aCoder encodeDouble:self.topLeftlongitude forKey:TopLeftLongitude];
    [aCoder encodeDouble:self.bottomRightlatitude forKey:BottomRightLatitude];
    [aCoder encodeDouble:self.bottomRightlongitude forKey:BottomRightLongitude];

}



@end
