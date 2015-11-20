//
//  RootMapViewVCViewController.m
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "RootMapViewVCViewController.h"

@interface RootMapViewVCViewController ()

@end

@implementation RootMapViewVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
