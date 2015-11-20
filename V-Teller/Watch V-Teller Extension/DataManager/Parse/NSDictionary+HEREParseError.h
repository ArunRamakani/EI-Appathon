//
//  NSDictionary+HEREParseError.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 26-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Parser to handle error response for Route search and places search
#import <Foundation/Foundation.h>

@interface NSDictionary (HEREParseError)

// Get route error from error dict
- (NSString*) routeErrorSringFromDict;
// Get places error from error dict
- (NSString*) placesErrorSringFromDict;

@end
