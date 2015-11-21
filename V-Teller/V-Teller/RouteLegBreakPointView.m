//
//  RouteLegBreakPointView.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 27-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RouteLegBreakPointView.h"


@implementation RouteLegBreakPointView


// configure  MKannotation view
-(void) configurePinView {
    
    // Enable Callout
    self.canShowCallout = YES;
    self.calloutOffset = CGPointMake(-5, 5);
    self.enabled = YES;

    
    self.image = [UIImage imageNamed:@"MapPin"];
    
}




@end
