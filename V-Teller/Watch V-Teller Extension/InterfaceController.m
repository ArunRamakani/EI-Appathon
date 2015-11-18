//
//  InterfaceController.m
//  Watch V-Teller Extension
//
//  Created by Arun Ramakani on 11/17/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "InterfaceController.h"
#import <ApiAI/ApiAI.h>


@interface InterfaceController()

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [_pleaseWaitAnimation setImageNamed:@"frame"];
}

- (void)willActivate {
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
              
              if (![text length]) {
                  text = @"<empty response>";
              }
               NSLog(@"Text : %@", text);
              [self dismissProgress];

              
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
}

-(void) dismissProgress {
    [_progressGroup setHidden:TRUE];
    [_recordGroup setHidden:FALSE];
}

@end



