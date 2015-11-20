//
//  RouteLeg.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Model to store leg details

#import <Foundation/Foundation.h>
#import "StepInLeg.h"

@interface RouteLeg : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger shapIndexStart;
@property (nonatomic, assign) NSUInteger shapIndexEnd;

@property (nonatomic, assign) NSUInteger travelTime;
@property (nonatomic, assign) NSUInteger length;

@property (nonatomic, strong) NSArray<StepInLeg *> *stepsArray;


@end
