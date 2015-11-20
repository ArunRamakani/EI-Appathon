//
//  RouteLegLine.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 26-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//


//MKPolyline subclass to add color attribute to the MKPolyline , so that it is possible to show different leg in differenr color from a random color picker.

#import <MapKit/MapKit.h>


@interface RouteLegLine : MKPolyline

@property (nonatomic, strong) UIColor *legColor;

//static MKPolyline subclass initializer with a ordered color picked for poly line
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count legIndex:(NSUInteger) legIndex;

@end
