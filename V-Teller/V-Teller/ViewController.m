//
//  ViewController.m
//  V-Teller
//
//  Created by Arun Ramakani on 11/17/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "ViewController.h"
#import "RootMapViewVCViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) restoreUserActivityState:(NSUserActivity *)activity {
    
    RootMapViewVCViewController *routeMap = [[RootMapViewVCViewController alloc] initWithNibName:@"RootMapViewVCViewController" bundle:nil];
    
    routeMap.places  = (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:[[activity userInfo] valueForKey:@"places"]];
    

    [self presentViewController:routeMap animated:YES completion:^{
        
    }];
    
}

@end
