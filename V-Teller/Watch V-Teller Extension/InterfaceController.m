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

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [_pleaseWaitAnimation setImageNamed:@"frame"];
    _validIntractions = [NSArray arrayWithObjects:@"ATM", @"Branch", @"Offers", @"Balance", nil];
    _util = [[VTellerWatchUtil alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNearestAtmBranch:) name:@"PublishNearestAtmBranch" object:nil];
    
}

- (void) willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [_pleaseWaitAnimation startAnimating];
}

-(IBAction) recordSound:(id)sender {
    
    
    NSURL *sharedContainer = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kSharedGroup];
    NSURL *fileUrl = [sharedContainer URLByAppendingPathComponent:kVoiceRecordFile];
    
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:fileUrl.absoluteString error:&error];
    
    
    
    NSDictionary *options = @{ WKAudioRecorderControllerOptionsMaximumDurationKey:@(5.f), WKAudioRecorderControllerOptionsActionTitleKey:kRecoderSubmitTitle };
    
    
  [self presentAudioRecorderControllerWithOutputURL:fileUrl preset:WKAudioRecorderPresetWideBandSpeech options:options completion:^(BOOL didSave, NSError * _Nullable error) {
      
      if(didSave && !error) {
          
          [self showProgress];
          
          ApiAI *apiai = [ApiAI sharedApiAI];
          
          AIVoiceFileRequest *request = [apiai voiceFileRequestWithFileURL:fileUrl];
          
          [request setMappedCompletionBlockSuccess:^(AIRequest *request, AIResponse *response) {
  
              NSString *text = response.result.fulfillment.speech;
              
              if ([text length] && [self isValidIntraction:text]) {
                 NSLog(@"Text : %@", text);
                  [_util fetchDataForIntractionType:text];
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
      }
      
  }];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [_pleaseWaitAnimation stopAnimating];
}



-(void) showProgress {
    [_progressGroup setHidden:FALSE];
    [_recordGroup setHidden:TRUE];
    _assertionSemaphore = nil;
    _assertionSemaphore = dispatch_semaphore_create(0);
    
    [self requestAssertionWithSmaphore];
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
    [_progressGroup setHidden:TRUE];
    [_recordGroup setHidden:FALSE];
    [self releaseAssertionSmaphore];
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
@end



