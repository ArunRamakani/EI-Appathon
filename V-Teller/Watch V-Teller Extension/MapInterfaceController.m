//
//  MapInterfaceController.m
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "MapInterfaceController.h"
#import "BoundingBox.h"
#import "Place.h"

@interface MapInterfaceController ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *stringPlaces;

@end

@implementation MapInterfaceController

- (void)awakeWithContext:(id)context {
    
    [super awakeWithContext:context];
    _array = (NSArray*) context;
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [_map removeAllAnnotations];
    
    _stringPlaces = @"";
    
    if ([_array count] > 1) {
        
        BoundingBox *box = [[BoundingBox alloc] init];
        // initialize with default values for box
        box.topLeftlatitude = -90;
        box.topLeftlongitude = 180;
        
        box.bottomRightlatitude = 90;
        box.bottomRightlongitude = -180;
        
        // Loop for all places lat long to calculate box values from min max
        for(Place *place in _array) {
            
            _stringPlaces = [NSString stringWithFormat:@"%@~%f:%f",_stringPlaces,place.latitude, place.latitude];
                             
            CLLocationCoordinate2D location;
            location.latitude = place.latitude;
            location.longitude =  place.longitude;
            [_map addAnnotation:location withPinColor:WKInterfaceMapPinColorRed];
            
            
            
            box.topLeftlatitude = fmax(box.topLeftlatitude, place.latitude);
            box.topLeftlongitude = fmin(box.topLeftlongitude, place.longitude);
            box.bottomRightlatitude = fmin(box.bottomRightlatitude, place.latitude);
            box.bottomRightlongitude = fmax(box.bottomRightlongitude, place.longitude);
            
        }
        
        CLLocationCoordinate2D locationCenter;
        locationCenter.latitude = (box.topLeftlatitude + box.bottomRightlatitude) / 2;
        locationCenter.longitude = (box.topLeftlongitude + box.bottomRightlongitude) / 2;
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(locationCenter, 2000.0, 2000.0);
        
        region.span.latitudeDelta = (box.topLeftlatitude - locationCenter.latitude) * 2.5;
        region.span.longitudeDelta = (locationCenter.longitude - box.topLeftlongitude) * 2.5;
        
        [_map setRegion:region];
        
        
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(IBAction)handOff:(id)sender {
    
    NSData *dataOnObject = [NSKeyedArchiver archivedDataWithRootObject:_array];
    
    [self updateUserActivity:@"com.NLP.Bank.V-Teller.MapRoute" userInfo:@{@"places": dataOnObject} webpageURL:nil];
}

@end



