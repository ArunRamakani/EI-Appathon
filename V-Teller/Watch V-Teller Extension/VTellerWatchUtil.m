//
//  VTellerWatchController.m
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "VTellerWatchUtil.h"
#import "Place.h"


@implementation VTellerWatchUtil

-(instancetype) init {
    
    self = [super init];
    
    if (self) {
      [HEREPlacesDataProvider sharedInstance].delegate = self;
    }
    return self;
}

- (void) fetchDataForIntractionType:(NSString*) type {
    
    if([type isEqualToString:@"ATM"]){
        
        [[HEREPlacesDataProvider sharedInstance] searchForPlaceWithString:@"emirates islamic atm"];
        
    } 
}


// handle success search
-(void) successWithPlaces:(NSArray*) placesList {
 
    NSLog(@" Places array : %@",placesList);
    if ([placesList count] > 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PublishNearestAtmBranch" object:placesList];

    }
    
    
}

// handle failure search
-(void) didSearchFailWithError:(NSString *) errorMessage{
    
    
}


-(void) successWithRoute:(RouteInfo*) routeInfo {
    
}



@end
