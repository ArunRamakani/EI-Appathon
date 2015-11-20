//
//  HERERoutesDataProvider.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 24-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "HERERoutesDataProvider.h"
#import "NSDictionary+HERERoutesDictionaryHelper.h"
#import "NSDictionary+HEREParseError.h"
#import "Place.h"

#define hereRoutesBaseUrlString @"https://route.cit.api.here.com/routing/7.2/"
#define hereRouteResponcetextFormat @"text"
#define hereRouteResponceLanguage @"en-us"
#define hereRouteResponceAttribute @"wp,sm,sh,wp,bb,li,tx,lg"



#define TrafficModeDefault @"disabled"

#define TransportModeDefault @"car"

#define RouteModeDefault @"fastest"

#define WaypointDefault @"stopOver"



@implementation HERERoutesDataProvider

// creat share instance
+(HERERoutesDataProvider*) sharedInstance{
    static HERERoutesDataProvider *sharedHERERouteDataProvider;
    static dispatch_once_t singleton;
    dispatch_once(&singleton,^{
        NSURL *hereURL = [NSURL URLWithString:hereRoutesBaseUrlString];
        sharedHERERouteDataProvider = [[self alloc] initWithBaseURL:hereURL];
    });
    return sharedHERERouteDataProvider;
}

// init with appropriate request and response serialization
-(instancetype) initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if(self){
        self.requestSerializer      = [AFJSONRequestSerializer serializer];
        self.responseSerializer     = [AFJSONResponseSerializer serializer];
   
    }
    return self;
}

// do Route search for the provided places array
-(void) getRouteFromPlaces:(NSArray*) places{
    
    // Construct Request Param
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    
    paramDict[@"instructionFormat"]     = hereRouteResponcetextFormat;
    paramDict[@"language"]              = hereRouteResponceLanguage;
    paramDict[@"routeAttributes"]       = hereRouteResponceAttribute;
    paramDict[@"app_id"]                = hereAppID;
    paramDict[@"app_code"]              = hereAppCode;
    paramDict[@"mode"]                  = [self getRouteMode];
    
    int i = 0;
    
    // Construct way point parameter based on place index and user preference
    for(Place *place in places) {
        
        NSString *paramValue;
        
        if(!(places.count == i + 1) && !(i == 0)){
            paramValue = [NSString stringWithFormat:@"geo!%@!%f,%f",WaypointDefault, place.latitude, place.longitude];
        } else {
            paramValue = [NSString stringWithFormat:@"geo!%f,%f",place.latitude, place.longitude];
        }
       
        NSString *paramName = [NSString stringWithFormat:@"waypoint%d",i];
        paramDict[paramName] = paramValue;
        
        i = i + 1;
    }
    
    // Invove Here Route API
    [self GET:@"calculateroute.json" parameters:paramDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *responseDict  = (NSDictionary*)responseObject;
        
        // Print Route response
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDict
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
        }
        
        // parse success response
        NSDictionary *route = [[responseDict valueForKey:@"response"] valueForKey:@"route"][0];
        
        [self.delegate successWithRoute:[route getRouteInfo]];
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        // Parse error info
        NSString *errorString;
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *errorDict;
        if(errorData) {
             errorDict = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        }
        
        if(errorDict){
            errorString = [errorDict routeErrorSringFromDict];
        } else {
            errorString = error.localizedDescription;
        }
        
        [self.delegate didSearchFailWithError:errorString];
        
    }];
    
}


-(NSString*) getRouteMode {
    return [NSString stringWithFormat:@"%@;%@;traffic:%@",RouteModeDefault, TransportModeDefault, TrafficModeDefault];
}



@end
