//
//  VTellerWatchUtil.h
//  V-Teller
//
//  Created by Arun Ramakani on 11/20/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEREPlacesDataProvider.h"


@interface VTellerWatchUtil : NSObject <HEREPlacesDataProviderDelegate>

-(void) fetchDataForIntractionType:(NSString*) type;

@end
