//
//  RootMapViewVCViewController.m
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RootMapViewVCViewController.h"
#import "Place.h"
#import "AppDelegate.h"
#import "MRProgress.h"
#import "RouteLegLine.h"
#import "RouteMapUtil.h"
#import "RouteLegBreakPointView.h"


@interface RootMapViewVCViewController ()



@property (nonatomic, strong) RouteInfo                             *routeInfo;
@property (nonatomic, assign) MKCoordinateRegion                    mapRegion;
@property (nonatomic, strong) NSMutableArray<MKPointAnnotation*>    *annotations;
@property (nonatomic, strong) NSMutableArray<RouteLegLine*>         *polyLine;


@end

@implementation RootMapViewVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [MRProgressOverlayView showOverlayAddedTo:appDelegate.window animated:YES];
    
    [HERERoutesDataProvider sharedInstance] .delegate = self;
    [[HERERoutesDataProvider sharedInstance] getRouteFromPlaces:_places];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
}

-(IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void) successWithRoute:(RouteInfo*) routeInfo {
    // remove activity indicator
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [MRProgressOverlayView dismissOverlayForView:appDelegate.window animated:YES];
    
    self.routeInfo = routeInfo;    [self configureMap];
}

-(void) didSearchFailWithError:(NSString *)errorString {
    // remove activity indicator
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [MRProgressOverlayView dismissOverlayForView:appDelegate.window animated:YES];
}



// construct map specific details before we refresh the map view for user. Following details are constructed withe the help of RouteMapUtil utility class
// 1. Map Bounds - Visible area as a region based on the route details we have
// 2. Create Map annotations for all waypoints
// 3. Create leg lines in the form of polyline overlays
- (void)configureMap {
    
    self.mapRegion   = [RouteMapUtil getBoundingBoxRegionForPlace:self.places route:self.routeInfo];
    self.annotations = [RouteMapUtil getAnnotationsForPlace:self.places wayPoints:self.routeInfo.wayPoints];
    self.polyLine    = [RouteMapUtil getPolylineFromRoute:self.routeInfo];
    
    // Refresh map once details are calculated
    [self refreshMap];
}

// Refresh the map once me get the updated tatails on manual route refresh  or details page load first time
-(void) refreshMap {
    
    // Remove old Overlays/Annotations and add the updated once
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self.mapView removeOverlays:[self.mapView overlays]];
    
    
    [self.mapView addAnnotations:self.annotations];
    [self.mapView addOverlays:self.polyLine];
    
    // Set Map visible area
    [self.mapView setRegion:self.mapRegion animated:TRUE];
    
    // Reload instruction table view as we have got a new set of data for given itinerary
    [self.routeInstructions reloadData];
}

#pragma mark - Map view delegates

// view for overLay - set color from the polyline
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    MKPolylineRenderer *lineView = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    RouteLegLine *routeOverlay = (RouteLegLine*)overlay;
    
    lineView.strokeColor = routeOverlay.legColor;
    return lineView;
}


//provide view of annotation
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    // create a annotation for all way points in the route && configure callout view
    RouteLegBreakPointView *legBreakPoint = (RouteLegBreakPointView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"LegBreakPoint"];
    // Use cache annotations with tag "LegBreakPoint"
    if (!legBreakPoint){
        legBreakPoint = [[RouteLegBreakPointView alloc] initWithAnnotation:annotation reuseIdentifier:@"LegBreakPoint"];
        [legBreakPoint configurePinView];
    }
    legBreakPoint.annotation = annotation;
    
    return legBreakPoint;
    
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item

{
    long selectedTag=tabBar.selectedItem.tag;
    
    //  controll visibility of map view and route instruction view based on tab bar button tap
    if (selectedTag==1)
    {
        self.routeInstructions.hidden = TRUE;
        self.mapView.hidden = FALSE;
    }
    else if(selectedTag==2)
    {
        self.routeInstructions.hidden = FALSE;
        self.mapView.hidden = TRUE;
    }
    
}

#pragma mark - UITableViewDataSource - instruction table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Instruction count in each step
    return self.routeInfo.legArray[section].stepsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Each leg is a Table section
    return self.routeInfo.legArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstructionCell"];
    
    // Use cache annotations with tag "InstructionCell"
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstructionCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
    }
    // extract Leg information based on the table section
    RouteLeg *leg = self.routeInfo.legArray[indexPath.section];
    
    // extract step information based on the table row
    StepInLeg *step = leg.stepsArray[indexPath.row];
    NSString *rowText = step.instruction;
    cell.textLabel.text = rowText;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}



#pragma mark - UITableViewDelegate - instruction table

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;//height of section;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create view for header with distance and travel time and neg number
    UILabel *lblSectionName = [[UILabel alloc] init];
    lblSectionName.text = [NSString stringWithFormat:@"  Leg %ld, Distance : %lu KM, Travel Time : %lu Minutes", section + 1, self.routeInfo.legArray[section].length/ 1000 , self.routeInfo.legArray[section].travelTime/ 60];
    lblSectionName.textColor = [UIColor whiteColor];
    lblSectionName.lineBreakMode = NSLineBreakByWordWrapping;
    lblSectionName.backgroundColor = [UIColor grayColor];
    
    lblSectionName.lineBreakMode = NSLineBreakByWordWrapping;
    
    return lblSectionName;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
