//
//  InterfaceController.m
//  Watch V-Teller Extension
//
//  Created by Arun Ramakani on 11/17/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "InterfaceController.h"
#import <ApiAI/ApiAI.h>
#import "VTellerWatchUtil.h"


@interface InterfaceController()

@property (nonatomic, strong) dispatch_semaphore_t assertionSemaphore;
@property (nonatomic, strong) NSArray *validIntractions;
@property (nonatomic, strong) VTellerWatchUtil *util;
@property (nonatomic, strong) NSString *fulfilmentRes;
@property (nonatomic, assign) BOOL activityInprogress;
@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [_pleaseWaitAnimation setImageNamed:@"frame"];
    _validIntractions = [NSArray arrayWithObjects:@"ATM", @"FOOD", @"BALANCE", nil];
    _util = [[VTellerWatchUtil alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNearestAtmBranch:) name:@"PublishNearestAtmBranch" object:nil];
    
    _activityInprogress = FALSE;
    
}

- (void) willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if(_activityInprogress) {
        [_progressGroup setHidden:FALSE];
        [_recordGroup setHidden:TRUE];
        [_pleaseWaitAnimation startAnimating];
    } else {
        [_pleaseWaitAnimation stopAnimating];
        [_progressGroup setHidden:TRUE];
        [_recordGroup setHidden:FALSE];
    }
    
}

-(IBAction) recordSound:(id)sender {
    
    
    NSURL *sharedContainer = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kSharedGroup];
    NSURL *fileUrl = [sharedContainer URLByAppendingPathComponent:kVoiceRecordFile];
    
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:fileUrl.absoluteString error:&error];
    
    
    
    NSDictionary *options = @{ WKAudioRecorderControllerOptionsMaximumDurationKey:@(5.f), WKAudioRecorderControllerOptionsActionTitleKey:kRecoderSubmitTitle };
    
    
  [self presentAudioRecorderControllerWithOutputURL:fileUrl preset:WKAudioRecorderPresetWideBandSpeech options:options completion:^(BOOL didSave, NSError * _Nullable error) {
      
      if(didSave && !error) {
          
          ApiAI *apiai = [ApiAI sharedApiAI];
          
          AIVoiceFileRequest *request = [apiai voiceFileRequestWithFileURL:fileUrl];
          
          [request setMappedCompletionBlockSuccess:^(AIRequest *request, AIResponse *response) {
  
              NSString *intent = response.result.metadata.intentName;
              _fulfilmentRes = response.result.fulfillment.speech;
              
              if ([intent length] && [self isValidIntraction:intent]) {
                 NSLog(@"Text : %@", intent);
                  
                  if([intent isEqualToString:@"FOOD"]) {
                      [self handleFoodOffer];
                  } else if([intent isEqualToString:@"BALANCE"]) {
                      [self handleBalance];
                  } else {
                      [_util fetchDataForIntractionType:intent];
                  }
              } else {
                  WKAlertAction *act = [WKAlertAction actionWithTitle:@"OK" style:WKAlertActionStyleCancel handler:^(void){
                     [self dismissProgress];
                  }];
                  [self presentAlertControllerWithTitle:@"Error" message:@"We are not able to recogonize" preferredStyle:WKAlertControllerStyleAlert actions:[NSArray arrayWithObjects:act,nil]];
              }
          } failure:^(AIRequest *request, NSError *error) {
              NSLog(@"Error : %@", error.localizedDescription);
          }];
          [apiai enqueue:request];
          [self showProgress];
      }
      
  }];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



-(void) showProgress {
    
    _activityInprogress = TRUE;
    _assertionSemaphore = nil;
    _assertionSemaphore = dispatch_semaphore_create(0);
    [self requestAssertionWithSmaphore];
    
    [_progressGroup setHidden:FALSE];
    [_recordGroup setHidden:TRUE];
    [_pleaseWaitAnimation startAnimating];
    
    
    
}


-(void) requestAssertionWithSmaphore {
    
    [[NSProcessInfo processInfo] performExpiringActivityWithReason:@"BackgroundAssertion" usingBlock:^(BOOL expired) {
        if(expired) {
            
            // No background assertion possible now, so release smaphore
            [self releaseAssertionSmaphore];
            
        } else {
            // got a background assertion so wait with Semaphore
            if(_assertionSemaphore) {
                dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (kServiceTimeOut * (double) NSEC_PER_SEC));
                dispatch_semaphore_wait(_assertionSemaphore, time);
 
            }
        }
    }];
    
}



-(void) releaseAssertionSmaphore {
    if(_assertionSemaphore)
        dispatch_semaphore_signal(_assertionSemaphore);
}


-(void) dismissProgress {
    _activityInprogress = FALSE;
    [self releaseAssertionSmaphore];
    
    if([NSThread isMainThread]) {
        
        [_pleaseWaitAnimation stopAnimating];
        [_progressGroup setHidden:TRUE];
        [_recordGroup setHidden:FALSE];
        
    }
    
    
    //[[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeSuccess];
}


-(BOOL) isValidIntraction:(NSString*) resText {
    
    for (NSString *key in _validIntractions) {
        if ([resText isEqualToString:key])
            return TRUE;
    }
    
    return FALSE;
}

-(void) loadNearestAtmBranch :(NSNotification *)notification{
    [self dismissProgress];
    NSArray *arr = (NSArray*) notification.object;
    
    [self pushControllerWithName:@"MapController" context:arr];
    
}


- (void) handleFoodOffer {
    [self dismissProgress];
    [self pushControllerWithName:@"FoodOffer" context:_fulfilmentRes];
}

- (void) handleBalance {
    WKAlertAction *act = [WKAlertAction actionWithTitle:@"OK" style:WKAlertActionStyleCancel handler:^(void){
        [self dismissProgress];
    }];
    [self presentAlertControllerWithTitle:@"Account Balance" message:_fulfilmentRes preferredStyle:WKAlertControllerStyleAlert actions:[NSArray arrayWithObjects:act,nil]];
}

@end



