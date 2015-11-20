//
//  MapInterfaceController.h
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface MapInterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceMap *map;

-(IBAction) handOff:(id)sender;

@end
