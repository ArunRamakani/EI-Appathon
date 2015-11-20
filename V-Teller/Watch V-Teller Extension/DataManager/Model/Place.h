//
//  Place.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 19-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Model to store places search result
#import <Foundation/Foundation.h>

@interface Place : NSObject <NSCoding>

@property (nonatomic, assign) double     latitude;
@property (nonatomic, assign) double     longitude;

@property (nonatomic, assign) double     latitudeSearchContext;
@property (nonatomic, assign) double     longitudSearchContext;

@property (nonatomic, assign) NSUInteger     distance;

@property (nonatomic, strong) NSString     *title;
@property (nonatomic, strong) NSString     *categoryTite;
@property (nonatomic, strong) NSString     *category;
@property (nonatomic, strong) NSString     *icon;
@property (nonatomic, strong) NSString     *vacinity;
@property (nonatomic, strong) NSString     *placeId;
@property (nonatomic, strong) NSString     *placeLink;


@end
