//
//  CurrentLocationProvider.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 20-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Manager class to provide current location by activily watching for location upsates
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface CurrentLocationProvider : NSObject <CLLocationManagerDelegate>

@property (readonly, strong, nonatomic) CLLocationManager *locationManager;
@property (readonly, strong, nonatomic) CLLocation *currentLocation;

// provides shared instance of location managed , lanched on app delegate
+(CurrentLocationProvider*) sharedInstance;

- (void) requestLocation;
- (NSString*) getCommaSeperatedLatLong;

@end
