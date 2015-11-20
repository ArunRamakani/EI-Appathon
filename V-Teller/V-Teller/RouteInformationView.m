//
//  RouteInformationView.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 27-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RouteInformationView.h"

@interface RouteInformationView ()

@end

@implementation RouteInformationView

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Route Summary";
    
    // create and register close navigation for closing the summary view.
    
    UIBarButtonItem *btnClose = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = btnClose;
    
    
    // set all summary values from route summary info
    self.routeSummery.text = self.summary.summeryDisc;
    
    NSMutableString *contains = [NSMutableString string];
    
    [contains appendString:@"This Road Contains "];
    
    BOOL sepNeeded = FALSE;
    for(NSString *flag in self.summary.flags){
        if(sepNeeded){
            [contains appendString:@", "];
        }
        [contains appendString:flag];
        sepNeeded = TRUE;
    }
    self.roadContains.text = [NSString stringWithString:contains];
    self.distance.text =  [NSString stringWithFormat:@"%lu KM", self.summary.distance/1000];
    self.time.text =  [NSString stringWithFormat:@"%lu Minutes", self.summary.travelTime/60];
    self.trafficTime.text =  [NSString stringWithFormat:@"%lu Minutes", self.summary.traficTime/60];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - close action
// Close view in case of close action
-(void) closeView {
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}


@end
