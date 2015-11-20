//
//  Place.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 19-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "Place.h"

#define TitleKey                @"title"
#define CategoryTitle           @"categoryTite"
#define Category                @"category"
#define Icon                    @"icon"
#define Vacinity                @"vacinity"
#define PlaceId                 @"placeId"
#define PlaceLink               @"placeLink"

#define Latitude                @"latitude"
#define Longitude               @"longitude"
#define Distance                @"distance"
#define LatitudeSearchContext   @"latitudeSearchContext"
#define LongitudSearchContext   @"longitudSearchContext"



@implementation Place


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        self.title                          = [aDecoder decodeObjectForKey:TitleKey];
        self.categoryTite                   = [aDecoder decodeObjectForKey:CategoryTitle];
        self.category                       = [aDecoder decodeObjectForKey:Category];
        self.icon                           = [aDecoder decodeObjectForKey:Icon];
        self.vacinity                       = [aDecoder decodeObjectForKey:Vacinity];
        self.placeId                        = [aDecoder decodeObjectForKey:PlaceId];
        self.placeLink                      = [aDecoder decodeObjectForKey:PlaceLink];
        
        self.latitude                       = [aDecoder decodeDoubleForKey:Latitude];
        self.longitude                      = [aDecoder decodeDoubleForKey:Longitude];
        self.latitudeSearchContext          = [aDecoder decodeDoubleForKey:LatitudeSearchContext];
        self.longitudSearchContext          = [aDecoder decodeDoubleForKey:LongitudSearchContext];
        
        self.distance                       = [[aDecoder decodeObjectForKey:Distance] unsignedIntegerValue];
        
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.title forKey:TitleKey];
    [aCoder encodeObject:self.categoryTite forKey:CategoryTitle];
    [aCoder encodeObject:self.category forKey:Category];
    [aCoder encodeObject:self.icon forKey:Icon];
    [aCoder encodeObject:self.vacinity forKey:Vacinity];
    [aCoder encodeObject:self.placeId forKey:PlaceId];
    [aCoder encodeObject:self.placeLink forKey:PlaceLink];
    
    [aCoder encodeDouble:self.latitude forKey:Latitude];
    [aCoder encodeDouble:self.longitude forKey:Longitude];
    [aCoder encodeDouble:self.latitudeSearchContext forKey:LatitudeSearchContext];
    [aCoder encodeDouble:self.longitudSearchContext forKey:LongitudSearchContext];
    
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.distance] forKey:Distance];
    
}


@end
