//
//  ExtensionDelegate.m
//  Watch V-Teller Extension
//
//  Created by Arun Ramakani on 11/17/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "ExtensionDelegate.h"
#import <ApiAI/ApiAI.h>
#import "CurrentLocationProvider.h"



@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    // Perform any final initialization of your application.
    
    ApiAI *apiai = [ApiAI sharedApiAI];
    
    id <AIConfiguration> configuration = [[AIDefaultConfiguration alloc] init];
    
    configuration.clientAccessToken = @"360b1c4b73c840a7abdb9a8fd0459184";
    configuration.subscriptionKey = @"7904794d-77e9-47ab-b7dd-a141411826c2";
    
    apiai.configuration = configuration;
    
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[CurrentLocationProvider sharedInstance] requestLocation];
    kAppInForeground = TRUE;
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
    kAppInForeground = FALSE;
}

@end
