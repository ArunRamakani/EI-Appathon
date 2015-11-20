//
//  NSDictionary+HEREParseError.m
//  MapItineraryManager
//
//  Created by Arun Ramakani on 26-9-15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "NSDictionary+HEREParseError.h"

// Route error messages

#define InvalidInputData @"Invalid route request"

#define NoRouteFound @"Not able to construct route for the given itinerary"

#define RouteNotReconstructed @"The route is invalid"

#define LinkIdNotFound @"Link could not be found"

#define WaypointNotFound @"Waypoint could not be found"

#define SystemError @"There is technical error during route calculation"

#define PermissionError @"This user account is not valid"

#define General @"There is technical error during the route calculation"

// Places error messages
#define Error400 @"The request can not be fulfilled"

#define Error401 @"This user account is not valid"

#define Error403 @"User is not allowed to access this resource"

#define Error404 @"Requested resource was not found"

#define Error405 @"Method not allow"

#define Error406 @"The server can not generate content which is acceptable to the client according to the request's Accept header."

#define Error408 @"The client did not complete its request in a reasonable timeframe."

#define Error410 @"The resource is gone"

#define Error415 @"The server can not process the request body because it is of an unsupported MIME type."

#define Error429 @"Request quota has been exceeded."

#define Error500 @"The server encountered an unexpected condition which prevented it from fulfilling the request."

#define Error501 @"The server can not process the request method"

#define Error503 @"The resource is temporarily unavailable."

#define ErrorGeneral @"There is technical error in finding the place requested."




@implementation NSDictionary (HEREParseError)

// Looking for appropriate error type from error dict and match with appropriate message for route search
- (NSString*) routeErrorSringFromDict {
    
    NSString *errorMessage;
    
    NSString *errorType     = [self valueForKey:@"type"];
    NSString *errorSubType  = [self valueForKey:@"subtype"];
    
    if([errorType isEqualToString:@"ApplicationError"]) {
        
        if([errorSubType isEqualToString:@"InvalidInputData"]) {
            errorMessage = InvalidInputData;
        } else if([errorSubType isEqualToString:@"WaypointNotFound"]) {
            errorMessage = WaypointNotFound;
        } else if([errorSubType isEqualToString:@"NoRouteFound"]) {
            errorMessage = NoRouteFound;
        } else if([errorSubType isEqualToString:@"LinkIdNotFound"]) {
            errorMessage = LinkIdNotFound;
        } else if([errorSubType isEqualToString:@"RouteNotReconstructed"]) {
            errorMessage = RouteNotReconstructed;
        }
        if(errorMessage == nil)
            errorMessage = General;
        
    } else if([errorType isEqualToString:@"SystemError"]) {
        errorMessage = SystemError;
    } else if([errorType isEqualToString:@"PermissionError"]) {
        errorMessage = PermissionError;
    }
    
    if(errorMessage == nil)
        errorMessage = General;
    
    return errorMessage;
}

// Looking for appropriate error type from error dict and match with appropriate message for place search
- (NSString*) placesErrorSringFromDict {
    
    NSString *errorMessage;
    
    short status     = [[self valueForKey:@"status"] intValue];
    
    switch (status) {
        case 400:
            errorMessage = Error400;
            break;
        case 401:
            errorMessage = Error401;
            break;
        case 403:
            errorMessage = Error403;
            break;
        case 404:
            errorMessage = Error404;
            break;
        case 405:
            errorMessage = Error405;
            break;
        case 406:
            errorMessage = Error406;
            break;
        case 408:
            errorMessage = Error408;
            break;
        case 410:
            errorMessage = Error410;
            break;
        case 415:
            errorMessage = Error415;
            break;
        case 429:
            errorMessage = Error429;
            break;
        case 500:
            errorMessage = Error500;
            break;
        case 501:
            errorMessage = Error501;
            break;
        case 503:
            errorMessage = Error503;
            break;
        default:
            errorMessage = ErrorGeneral;
            break;
    }
    
    return errorMessage;
}



@end

