//
//  RouteLegBreakPointView.h
//  MapItineraryManager
//
//  Created by Arun Ramakani on 27-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

// MKAnnotationView sub class to custamize and configure the  annotation view. Can be enhanced to build custom callout views
#import <MapKit/MapKit.h>
#import "RouteInfo.h"

@interface RouteLegBreakPointView : MKAnnotationView

// configure  MKannotation view
-(void) configurePinView;


@end
