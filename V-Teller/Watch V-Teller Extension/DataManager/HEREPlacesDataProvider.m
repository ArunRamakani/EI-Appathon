//
//  HEREPlacesDataProvider.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 19-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "HEREPlacesDataProvider.h"
#import "NSDictionary+HEREPlacesDictionaryHelper.h"
#import "NSDictionary+HEREParseError.h"
#import "CurrentLocationProvider.h"
#import "Place.h"


@implementation HEREPlacesDataProvider

#define herePlacesBaseUrlString         @"https://places.cit.api.here.com/places/v1/"
#define herePlacesResponcetextFormat    @"plain"

// creat share instance

+(HEREPlacesDataProvider*) sharedInstance{
    static HEREPlacesDataProvider *sharedHEREDataProvider;
    static dispatch_once_t singleton;
    dispatch_once(&singleton,^{
        NSURL *hereURL = [NSURL URLWithString:herePlacesBaseUrlString];
        sharedHEREDataProvider = [[self alloc] initWithBaseURL:hereURL];
    });
    return sharedHEREDataProvider;
}

// init with appropriate request and response serialization
-(instancetype) initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if(self){
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

// do place search for the provided string
-(void) searchForPlaceWithString:(NSString*) searchString {
    
    // Sample header set
    [self.requestSerializer setValue:@"drive" forHTTPHeaderField:@"X-Mobility-Mode"];
    
    
    // Construct request parameter
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    
    paramDict[@"at"]        = [[CurrentLocationProvider sharedInstance] getCommaSeperatedLatLong];
    paramDict[@"q"]         = searchString;
    paramDict[@"app_id"]    = hereAppID;
    paramDict[@"app_code"]  = hereAppCode;
    paramDict[@"tf"]        = herePlacesResponcetextFormat;


    // call places search API
    [self GET:@"discover/search" parameters:paramDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                     error:&error];
        
                if (! jsonData) {
                    NSLog(@"Got an error: %@", error);
                } else {
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
                }
        
        // Parse success responce and delegate back
        NSDictionary *responseDict  = (NSDictionary*)responseObject;
        
        
        
        NSMutableArray *arrPlace = [responseDict getPlacesFromDictionary];
        NSArray *places;
        if([arrPlace count]  > 0) {
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance"
                                                         ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            Place *nearestAtm = [[arrPlace sortedArrayUsingDescriptors:sortDescriptors] objectAtIndex:0];
            Place *currentLocation = [responseDict getCurrentLocationfromDict];
            places = [NSArray arrayWithObjects:nearestAtm,currentLocation, nil];
        }
        
        [self.delegate successWithPlaces:places];
      
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        // Parse failure responce and delegate back
        NSString *errorString;
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *errorDict;
        if(errorData) {
            errorDict = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        }
        
        if(errorDict){
            errorString = [errorDict placesErrorSringFromDict];
        } else {
            errorString = error.localizedDescription;
        }
        
        [self.delegate didSearchFailWithError:errorString];
    }];
    
}

@end
