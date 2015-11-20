//
//  HEREPlacesDataProvider.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 19-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Clase to support Places search API call

#import "AFHTTPSessionManager.h"
#import "WatchExtCons.h"



// delegate to send back the success or failure place sesarch
@protocol HEREPlacesDataProviderDelegate <NSObject>

@required

-(void) successWithPlaces:(NSArray*) placesList;

@optional

-(void) didSearchFailWithError:(NSString *) errorMessage;

@end


@interface HEREPlacesDataProvider : AFHTTPSessionManager

@property (nonatomic, weak) id<HEREPlacesDataProviderDelegate> delegate;

// creat share instance
+(HEREPlacesDataProvider*) sharedInstance;
// do search operation
-(void) searchForPlaceWithString:(NSString*) searchString ;

@end
