//
//  NSDictionary+HERERoutesDictionaryHelper.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 25-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "NSDictionary+HERERoutesDictionaryHelper.h"
#import "BoundingBox.h"
#import "RouteSummary.h"
#import "RouteLeg.h"
#import "StepInLeg.h"

@implementation NSDictionary (HERERoutesDictionaryHelper)

// Parse bounding box data from response and creates bounding box object
-(BoundingBox*) getRouteBox {
    
    NSDictionary *topLeft       = [[self valueForKey:@"boundingBox"] valueForKey:@"topLeft"];
    NSDictionary *bottomRight   = [[self valueForKey:@"boundingBox"] valueForKey:@"bottomRight"];
    
    
    BoundingBox *routeBox = [[BoundingBox alloc] init];
    
    routeBox.topLeftlatitude        = [[topLeft valueForKey:@"latitude"] doubleValue];
    routeBox.topLeftlongitude       = [[topLeft valueForKey:@"longitude"] doubleValue];
    
    routeBox.bottomRightlatitude    = [[bottomRight valueForKey:@"latitude"] doubleValue];
    routeBox.bottomRightlongitude   = [[bottomRight valueForKey:@"longitude"] doubleValue];
    
    return routeBox;
}

// Parse shape array object data from response and creates CLLocation array
-(NSArray*) getShapeArray {
    
    NSArray *shapesArray = [self valueForKey:@"shape"];
    NSMutableArray *shapesArr = [[NSMutableArray alloc] init];
    
    for (NSString *shape in shapesArray) {
        NSArray *latLong = [shape componentsSeparatedByString:@","];
        CLLocation *shapePoint = [[CLLocation alloc] initWithLatitude:[latLong[0] doubleValue] longitude:[latLong[1] doubleValue]];
        [shapesArr addObject:shapePoint];
    }
    
    return [shapesArr copy];
}

// Parser to parse the summary information of route
-(RouteSummary*) getRouteSummary {
    
    RouteSummary *summery = [[RouteSummary alloc] init];
    NSDictionary *summaryDict = [self valueForKey:@"summary"];
    
    
    summery.baseTime    = [[summaryDict valueForKey:@"baseTime"] integerValue] ;
    summery.traficTime  = [[summaryDict valueForKey:@"trafficTime"] integerValue] ;
    summery.travelTime  = [[summaryDict valueForKey:@"travelTime"] integerValue] ;
    summery.distance    = [[summaryDict valueForKey:@"distance"] integerValue] ;
    
    summery.summeryDisc = [summaryDict valueForKey:@"text"];
    summery.flags       = [summaryDict valueForKey:@"flags"];
    
    return summery;

}

// Parser to parse the leg array from json to great an array of RouteLeg object
-(NSArray*) getLegArray {
    
    NSArray *legArr = [self valueForKey:@"leg"];
    NSMutableArray *legArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *leg in legArr) {
       
        RouteLeg *routeLeg = [[RouteLeg alloc] init];
        
        routeLeg.length             = [[leg valueForKey:@"length"] integerValue];
        routeLeg.travelTime         = [[leg valueForKey:@"travelTime"] integerValue];
        routeLeg.shapIndexStart     = [[[leg valueForKey:@"start"] valueForKey:@"shapeIndex"] integerValue];
        routeLeg.shapIndexEnd       = [[[leg valueForKey:@"end"] valueForKey:@"shapeIndex"] integerValue];
        
        routeLeg.stepsArray         = [self getStepsArr:leg];
    
        [legArray addObject:routeLeg];
    }
    
    return [legArray copy];
    
}

// Parse steps array for the given route leg returnd array of StepInLeg object
-(NSArray*) getStepsArr:(NSDictionary *) leg{
    
    NSArray *stepArr = [leg valueForKey:@"maneuver"];
    NSMutableArray *stepArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *step in stepArr) {
        
        StepInLeg *stepLeg = [[StepInLeg alloc] init];
        
        stepLeg.stepTime                = [[step valueForKey:@"travelTime"] integerValue];
        stepLeg.stepLength              = [[step valueForKey:@"length"] integerValue];
        
        stepLeg.stepId                  = [step valueForKey:@"id"];
        stepLeg.instruction             = [step valueForKey:@"instruction"];
        
        stepLeg.steplat                 = [[[step valueForKey:@"position"] valueForKey:@"latitude"] floatValue];
        stepLeg.steplong                = [[[step valueForKey:@"position"] valueForKey:@"longitude"] floatValue];

        
        [stepArray addObject:stepLeg];
    }
    
    return [stepArray copy];
    
}

// Parse for way points 
-(NSArray*)getWayPoints {
    
    NSArray *wayPoints = [self valueForKey:@"waypoint"];
    NSMutableArray *waypointArr = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *wayPoint in wayPoints) {
        CLLocation *wayPointLocation = [[CLLocation alloc] initWithLatitude:[[[wayPoint valueForKey:@"mappedPosition"] valueForKey:@"latitude"] doubleValue] longitude:[[[wayPoint valueForKey:@"mappedPosition"] valueForKey:@"longitude"] doubleValue]];
        [waypointArr addObject:wayPointLocation];
    }
    
    return [waypointArr copy];
}

// return th route info object from the total route info. Uses aother utility methods to generate nessary data
-(RouteInfo*) getRouteInfo {
    
    RouteInfo *routeInfo = [[RouteInfo alloc] init];
    
    routeInfo.boundBox  = [self getRouteBox];
    routeInfo.shapArr   = [self getShapeArray];
    routeInfo.summary   = [self getRouteSummary];
    routeInfo.legArray  = [self getLegArray];
    routeInfo.wayPoints = [self getWayPoints];
    
    return routeInfo;
}

@end
