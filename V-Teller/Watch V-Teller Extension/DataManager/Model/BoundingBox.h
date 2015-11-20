//
//  BoundingBox.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Model to store map display region for a route

#import <Foundation/Foundation.h>

@interface BoundingBox : NSObject  <NSCoding>

@property (nonatomic, assign) double     topLeftlatitude;
@property (nonatomic, assign) double     topLeftlongitude;

@property (nonatomic, assign) double     bottomRightlatitude;
@property (nonatomic, assign) double     bottomRightlongitude;

@end
