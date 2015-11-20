//
//  RouteInfo.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Model to store total route information

#import <Foundation/Foundation.h>
#import "RouteLeg.h"
#import "RouteSummary.h"
#import "BoundingBox.h"


@interface RouteInfo : NSObject <NSCoding>

@property (nonatomic, strong) NSArray<RouteLeg *> *legArray;
@property (nonatomic, strong) NSArray *shapArr;
@property (nonatomic, strong) NSArray *wayPoints;
@property (nonatomic, strong) RouteSummary *summary;
@property (nonatomic, strong) BoundingBox *boundBox;

@end
