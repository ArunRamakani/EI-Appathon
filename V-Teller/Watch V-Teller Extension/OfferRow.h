//
//  OfferRow.h
//  V-Teller
//
//  Created by Arun Ramakani on 11/21/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface OfferRow : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceGroup *offerImage;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *offerTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *offerDiscription;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *offerRating;

@end
