//
//  RouteMapUtil.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 26-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RouteMapUtil.h"
#import "BoundingBox.h"
#import "CurrentLocationProvider.h"

@implementation RouteMapUtil

// Calculate and prepare map view display region based on the annotations
+ (MKCoordinateRegion) getBoundingBoxRegionForPlace:(NSArray*) places route:(RouteInfo*) route {
    
    MKCoordinateRegion region;
    BoundingBox *box;
    
    //get the region box from route if available
    if(route) {
        
        box = route.boundBox;
        
    } else {
        // in case if route details are not available calculate the region box from place annotation
        if([places count] > 1) {
            
            box = [[BoundingBox alloc] init];
            // initialize with default values for box
            box.topLeftlatitude = -90;
            box.topLeftlongitude = 180;
            
            box.bottomRightlatitude = 90;
            box.bottomRightlongitude = -180;
            
            // Loop for all places lat long to calculate box values from min max
            for(Place *place in places) {
                
                box.topLeftlatitude = fmax(box.topLeftlatitude, place.latitude);
                box.topLeftlongitude = fmin(box.topLeftlongitude, place.longitude);
                box.bottomRightlatitude = fmin(box.bottomRightlatitude, place.latitude);
                box.bottomRightlongitude = fmax(box.bottomRightlongitude, place.longitude);
                
            }
        }
    }
    
    CLLocationCoordinate2D locationCenter;
    
    if(box) {
        
        // If box is calculated in the above steps , calculate center and delta Lat/Long from the box and finally creat the region
        locationCenter.latitude = (box.topLeftlatitude + box.bottomRightlatitude) / 2;
        locationCenter.longitude = (box.topLeftlongitude + box.bottomRightlongitude) / 2;
        
        region = MKCoordinateRegionMakeWithDistance(locationCenter, 2000.0, 2000.0);
        
        region.span.latitudeDelta = (box.topLeftlatitude - locationCenter.latitude) * 2.5;
        region.span.longitudeDelta = (locationCenter.longitude - box.topLeftlongitude) * 2.5;
        
    } else {
        // If box is not available focus the app with current location or one selected place in the itinerary
        if(places.count == 1) {
            Place *place = (Place*) places[0];
            locationCenter.latitude = place.latitude;
            locationCenter.longitude = place.longitude;
            
        } else {
            
            locationCenter.latitude = [CurrentLocationProvider sharedInstance].currentLocation.coordinate.latitude;
            locationCenter.longitude = [CurrentLocationProvider sharedInstance].currentLocation.coordinate.longitude;
        }
        
        
        region = MKCoordinateRegionMakeWithDistance(locationCenter, 2000.0, 2000.0);
        
        region.span.latitudeDelta = 0.2;
        region.span.longitudeDelta = 0.2;
    }
    
     // return the calculated region
    return region;
    
}

// Prepares annotations from waypoints or places
+ (NSMutableArray*) getAnnotationsForPlace:(NSArray*) places wayPoints:(NSArray*) wayPoints {
   
    NSMutableArray *annotationArr = [[NSMutableArray alloc] init];
    
    if(wayPoints){
        //Convert all way points into annotations if you have waypoint info
        for(NSInteger i = 0; i < wayPoints.count ; i++) {
            
            Place *place = places[i];
            CLLocation *location =[wayPoints objectAtIndex:i];
            
            MKPointAnnotation *annotate = [[MKPointAnnotation alloc] init];
    
            annotate.title = place.title;
            annotate.subtitle = [NSString stringWithFormat:@"%@, %@" , place.categoryTite, place.vacinity];
            annotate.coordinate = location.coordinate;
            
            [annotationArr addObject:annotate];
        }
        
    } else if(places) {
        // else draw all places in the itinerray as waypoints
        for(Place *place in places){
        
            CLLocationCoordinate2D location;
            location.latitude = place.latitude;
            location.longitude =  place.longitude;
        
            MKPointAnnotation *annotate = [[MKPointAnnotation alloc] init];
            
            annotate.coordinate = location;
            annotate.title = place.title;
            annotate.subtitle = [NSString stringWithFormat:@"%@, %@" , place.categoryTite, place.vacinity];
            
            [annotationArr addObject:annotate];
                    
        }
    }
    
    return annotationArr;
}

// Calculate route poly line from shape array and leg details. Take the start and end point of a leg from each leg and map them with shap points array to extract all the points in the given leg or the rout. Finally draw a polyline out of it.
+ (NSMutableArray*) getPolylineFromRoute:(RouteInfo*) route {

    NSMutableArray *shapLines = [[NSMutableArray alloc] init];
    
    for (NSUInteger z = 0; z < [route.legArray count]; z++){
        RouteLeg *leg = route.legArray[z];
        
        NSInteger shapCount = leg.shapIndexEnd - leg.shapIndexStart;
        
        CLLocationCoordinate2D shapPoints[shapCount];
        
        int j = 0;
        for (NSUInteger i = leg.shapIndexStart; i <= leg.shapIndexEnd; i++ ) {
            
            CLLocation *shap = route.shapArr[i];
            shapPoints[j] = CLLocationCoordinate2DMake(shap.coordinate.latitude,shap.coordinate.longitude);
            j++;
        }
        
        RouteLegLine *polyLine = [RouteLegLine polylineWithCoordinates:shapPoints count:shapCount legIndex:z];
        [shapLines addObject:polyLine];
    }
    
    return shapLines;
}

@end
