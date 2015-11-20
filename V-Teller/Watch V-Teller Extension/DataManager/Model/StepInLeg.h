//
//  StepInLeg.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//
// Model to store instruction for a leg
#import <Foundation/Foundation.h>



@interface StepInLeg : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger stepTime;
@property (nonatomic, assign) NSUInteger stepLength;
@property (nonatomic, strong) NSString *instruction;
@property (nonatomic, strong) NSString *stepId;
@property (nonatomic, assign) double steplat;
@property (nonatomic, assign) double steplong;

@end
