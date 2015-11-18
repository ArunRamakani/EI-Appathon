//
//  InterfaceController.h
//  Watch V-Teller Extension
//
//  Created by Arun Ramakani on 11/17/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "WatchExtCons.h"

@interface InterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceImage *pleaseWaitAnimation;

@property (nonatomic, weak) IBOutlet WKInterfaceGroup *progressGroup;

@property (nonatomic, weak) IBOutlet WKInterfaceGroup *recordGroup;

-(IBAction) recordSound:(id)sender;

@end
