//
//  VTellerWatchUtil.h
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEREPlacesDataProvider.h"
#import "HERERoutesDataProvider.h"

@interface VTellerWatchUtil : NSObject <HEREPlacesDataProviderDelegate, HERERouteDataProviderDelegate>

-(void) fetchDataForIntractionType:(NSString*) type;

@end
