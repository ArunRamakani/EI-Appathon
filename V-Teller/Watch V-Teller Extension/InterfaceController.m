//
//  InterfaceController.m
//  Watch V-Teller Extension
//
//  Created by Arun Ramakani on 11/17/15.
//  Copyright © 2015 Arun Ramakani. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end



@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
  
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    

}



-(IBAction) recordSound:(id)sender {
    
    
    NSURL *sharedContainer = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kSharedGroup];
    NSURL *fileUrl1 = [sharedContainer URLByAppendingPathComponent:kVoiceRecordFile];
    
    
    NSDictionary *options = @{ WKAudioRecorderControllerOptionsMaximumDurationKey:@(10.f), WKAudioRecorderControllerOptionsActionTitleKey:kRecoderSubmitTitle };
    
    
  [self presentAudioRecorderControllerWithOutputURL:fileUrl1 preset:WKAudioRecorderPresetWideBandSpeech options:options completion:^(BOOL didSave, NSError * _Nullable error) {
      
  }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



