//
//  RouteMapUtil.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 26-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Utility class to calculate/create data needed to build map view

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "RouteInfo.h"
#import "Place.h"
#import "RouteLegLine.h"

@interface RouteMapUtil : NSObject

// Calculate and prepare map view display region based on the annotations
+ (MKCoordinateRegion) getBoundingBoxRegionForPlace:(NSArray*) places route:(RouteInfo*) route;
// Prepares annotations from waypoints or places
+ (NSMutableArray*) getAnnotationsForPlace:(NSArray*) places wayPoints:(NSArray*) wayPoints;
// Calculate route poly line from shape array and leg details
+ (NSMutableArray*) getPolylineFromRoute:(RouteInfo*) route;


@end
