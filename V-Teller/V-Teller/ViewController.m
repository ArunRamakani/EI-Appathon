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

-(void)viewDidAppear:(BOOL)animated {
//    RootMapViewVCViewController *routeMap = [[RootMapViewVCViewController alloc] initWithNibName:@"RootMapViewVCViewController" bundle:nil];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"yourfilename.dat"];
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:dataPath]];
//    routeMap.places  = (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
//    
//    
//    [self presentViewController:routeMap animated:YES completion:^{
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) restoreUserActivityState:(NSUserActivity *)activity {
    
    RootMapViewVCViewController *routeMap = [[RootMapViewVCViewController alloc] initWithNibName:@"RootMapViewVCViewController" bundle:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // Generate the file path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"yourfilename.dat"];
        
        // Save it into file system
        [[[activity userInfo] valueForKey:@"places"] writeToFile:dataPath atomically:YES];
    });
    
    
    routeMap.places  = (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:[[activity userInfo] valueForKey:@"places"]];
    

    [self presentViewController:routeMap animated:YES completion:^{
        
    }];
    
}

@end
