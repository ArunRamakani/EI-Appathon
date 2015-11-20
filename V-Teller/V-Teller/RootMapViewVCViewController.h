//
//  RootMapViewVCViewController.h
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HERERoutesDataProvider.h"
#import <MapKit/MapKit.h>

@interface RootMapViewVCViewController : UIViewController <HERERouteDataProviderDelegate>

@property (nonatomic, strong) NSArray *places;
@property (weak, nonatomic) IBOutlet MKMapView    *mapView;
@property (weak, nonatomic) IBOutlet UITableView  *routeInstructions;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;


@end
