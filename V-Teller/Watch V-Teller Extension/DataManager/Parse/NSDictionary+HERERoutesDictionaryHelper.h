//
//  NSDictionary+HERERoutesDictionaryHelper.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// helper class to parse route json

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RouteInfo.h"

@interface NSDictionary (HERERoutesDictionaryHelper)

// return th route info object from the total route info
-(RouteInfo*) getRouteInfo;

@end
