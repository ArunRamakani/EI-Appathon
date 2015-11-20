//
//  NSDictionary+HEREPlacesDictionaryHelper.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 19-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "NSDictionary+HEREPlacesDictionaryHelper.h"



@implementation NSDictionary (HEREPlacesDictionaryHelper)

- (NSMutableArray*) getPlacesFromDictionary {
    
    
    NSArray *context = [self getSearchContextfromDict];
    
    NSMutableArray *placesArr = [[NSMutableArray alloc] init];
    NSArray *items = [[self valueForKey:@"results"] valueForKey:@"items"];
    
    for (NSDictionary *item in items) {
        
        Place *place = [[Place alloc] init];
        
        place.title = [item valueForKey:@"title"];
        place.vacinity = [item valueForKey:@"vicinity"];
        place.placeId = [item valueForKey:@"id"];
        place.placeLink = [item valueForKey:@"href"];
        place.distance = [[item valueForKey:@"distance"] integerValue];
        
        NSString *icon = [item valueForKey:@"icon"];
        NSArray *iconStrings = [icon componentsSeparatedByString:@"/"];
        place.icon = [iconStrings objectAtIndex:(iconStrings.count -1)];
        
        NSArray *position = [item valueForKey:@"position"];
        place.latitude = [position[0] doubleValue];
        place.longitude = [position[1] doubleValue];
        
        NSDictionary *categoryDict = [item valueForKey:@"category"];
        place.category = [categoryDict valueForKey:@"id"];
        place.categoryTite = [categoryDict valueForKey:@"title"];
        place.latitudeSearchContext = [context[0] doubleValue];
        place.longitudSearchContext = [context[1] doubleValue];
        [placesArr addObject:place];
        
        
    }
    
    return placesArr;
}
- (NSArray*) getSearchContextfromDict {
    
    NSDictionary *contextDict = [[[self valueForKey:@"search"] valueForKey:@"context"] valueForKey:@"location"];

    NSArray *conetxtPosition = [contextDict valueForKey:@"position"];
    
    return conetxtPosition;
}


// supports to get place object from a current location search without any text
- (Place*) getCurrentLocationfromDict {
    
    // for location place search, use the search context and its address to generate place
    
    Place *place = [[Place alloc] init];
    place.title = @"Current Location";
    place.icon = @"06";
    NSArray *context = [self getSearchContextfromDict];
    place.latitude = [context[0] doubleValue];
    place.longitude = [context[1] doubleValue];
    place.latitudeSearchContext = [context[0] doubleValue];
    place.longitudSearchContext = [context[1] doubleValue];
    
    NSDictionary *contextDict = [[[self valueForKey:@"search"] valueForKey:@"context"] valueForKey:@"location"];
    NSDictionary *conetxtAddress = [contextDict valueForKey:@"address"];
    
    place.vacinity = [NSString stringWithFormat:@"%@ , %@ , %@ ", [conetxtAddress valueForKey:@"text"], [conetxtAddress valueForKey:@"city"], [conetxtAddress valueForKey:@"county"]];
    place.title = [conetxtAddress valueForKey:@"text"];
    place.placeLink = [contextDict valueForKey:@"href"];
    place.categoryTite = @"Current Location";
  
    return place;
    
}

@end
