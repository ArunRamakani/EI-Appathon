//
//  HERERoutesDataProvider.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 24-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Clase to support route search API call

#import "AFHTTPSessionManager.h"
#import "WatchExtCons.h"

#import "RouteInfo.h"

// delegate to send back the success or failure route sesarch
@protocol HERERouteDataProviderDelegate <NSObject>

@required

-(void) successWithRoute:(RouteInfo*) routeInfo;

@optional

-(void) didSearchFailWithError:(NSString *)errorString;

@end


@interface HERERoutesDataProvider : AFHTTPSessionManager

@property (nonatomic, weak) id<HERERouteDataProviderDelegate> delegate;

// creat share instance
+(HERERoutesDataProvider*) sharedInstance;
// do route search operation
-(void) getRouteFromPlaces:(NSArray*) places;

@end
