//
//  RouteLegLine.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 26-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RouteLegLine.h"

static NSArray *colorArr;

@implementation RouteLegLine


//static MKPolyline subclass initializer with a ordered color picked for poly line
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count legIndex:(NSUInteger) legIndex{
    
    RouteLegLine *routLegLine = [super polylineWithCoordinates:coords count:count];
    if(routLegLine){
        NSUInteger colorIndex  = legIndex % [[RouteLegLine colorArr] count];
        routLegLine.legColor = colorArr[colorIndex];
    }
    return routLegLine;

}

// static cololor ininitializer to pick a ordered color for overlay line
+ (NSArray *)colorArr
{
    if (!colorArr)
        colorArr = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor brownColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor blackColor], [UIColor magentaColor], [UIColor cyanColor], [UIColor blueColor], [UIColor darkGrayColor], [UIColor grayColor],  nil];
    
    return colorArr;
}

@end
