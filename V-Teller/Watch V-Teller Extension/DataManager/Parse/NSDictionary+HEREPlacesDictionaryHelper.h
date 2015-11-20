//
//  NSDictionary+HEREPlacesDictionaryHelper.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 19-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// helper class to parse places json

#import <Foundation/Foundation.h>
#import "Place.h"

@interface NSDictionary (HEREPlacesDictionaryHelper)

// creates array of places from the places search response
- (NSMutableArray*) getPlacesFromDictionary;
// creates an arry with lat long to get search context location from search res
- (NSArray*) getSearchContextfromDict;
// supports to get place object from a current location search without any text
- (Place*) getCurrentLocationfromDict;

@end
