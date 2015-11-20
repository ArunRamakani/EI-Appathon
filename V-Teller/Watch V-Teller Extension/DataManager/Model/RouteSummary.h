//
//  RouteSummary.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteSummary : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger    baseTime;
@property (nonatomic, assign) NSUInteger    traficTime;
@property (nonatomic, assign) NSUInteger    travelTime;
@property (nonatomic, assign) NSUInteger    distance;


@property (nonatomic, strong) NSString     *summeryDisc;
@property (nonatomic, strong) NSArray      *flags;



@end
