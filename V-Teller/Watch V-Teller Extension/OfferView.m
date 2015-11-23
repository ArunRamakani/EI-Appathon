//
//  OfferView.m
//  V-Teller
//
//  Created by Arun Ramakani on 11/21/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "OfferView.h"
#import "OfferRow.h"

@interface OfferView ()

@property (nonatomic, strong) NSArray *foodOfferArray;

@end

@implementation OfferView

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSData *jsonData = [(NSString*)context dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary * offer = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    _foodOfferArray = [offer valueForKey:@"array"];
    
    [self configureTable];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


-(void) configureTable {
    [_offerTable setNumberOfRows:[_foodOfferArray count] withRowType:@"OfferRow"];
    
    for (int i = 0; i < [_foodOfferArray count]; i++) {
        OfferRow *row = [_offerTable rowControllerAtIndex:i];
       
        NSDictionary *restDict = _foodOfferArray[i];
        [row.offerTitle setText:[restDict valueForKey:@"name"]];
        [row.offerDiscription setText:[restDict valueForKey:@"offer"]];
        [row.offerImage setBackgroundImageNamed:[NSString stringWithFormat:@"%@.png",[restDict valueForKey:@"imageName"]]];
        [row.offerRating setImageNamed:[NSString stringWithFormat:@"%d.png",(int)[restDict valueForKey:@"rating"]]];

        
    }
}

@end



