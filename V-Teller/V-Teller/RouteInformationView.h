//
//  RouteInformationView.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 27-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
// View controller to have the snap of summary of the total rotute details. called when infor incon is tapped from callout view  

#import <UIKit/UIKit.h>
#import "RouteSummary.h"

@interface RouteInformationView : UIViewController


// Interface Builder oulet properties to set the values for summary lables programatically
@property (nonatomic, weak) IBOutlet UILabel        *routeSummery;
@property (nonatomic, weak) IBOutlet UILabel        *distance;
@property (nonatomic, weak) IBOutlet UILabel        *time;
@property (nonatomic, weak) IBOutlet UILabel        *trafficTime;
@property (nonatomic, weak) IBOutlet UILabel        *roadContains;

// Varible to hold the passed summary view when model is invoked
@property (nonatomic, strong) RouteSummary *summary;


@end
