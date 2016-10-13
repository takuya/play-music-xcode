//
//  AppDelegate.m
//  PlaySoundSample
//
//  Created by takuya on 20161012.
//  Copyright © 2016年 takuya. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property AVAudioPlayer *player;
@property NSURL *url;
@property (weak) IBOutlet NSButtonCell *btn1;
@property (weak) IBOutlet NSTextFieldCell *lb1;
@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  _lb1.title = @"";
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}
- (IBAction)onclick:(id)sender {


  if ( _player && _player.isPlaying ){
    [_player pause];
    _btn1.title = @"play";
    _player = nil;

  }else{
    NSError *err;
    _player = [AVAudioPlayer alloc];
    _player = [_player initWithContentsOfURL:_url error:&err];
    if( [_player prepareToPlay] ) {
      [_player play];
      _btn1.title = @"stop";
    };

  }
}
- (IBAction)selectFile:(id)sender {
  NSOpenPanel *panel = [NSOpenPanel openPanel];
  panel.title = @"Choose Music file";
  panel.showsResizeIndicator = YES;
  panel.showsHiddenFiles = NO;
  panel.canChooseDirectories = NO;
  panel.canCreateDirectories = NO;
  panel.allowsMultipleSelection=NO;
  panel.allowedFileTypes = @[@"mp3",@"m4a"];
  [panel beginSheetModalForWindow:_window  completionHandler:^(NSInteger result) {
    //if the result is NSOKButton
    //the user selected a file
    if (result==NSModalResponseOK) {

      //get the selected file URLs
      NSURL *selection = panel.URLs[0];

      //finally store the selected file path as a string
      NSString* path = [[selection path] stringByResolvingSymlinksInPath];


      //here add yuor own code to open the file
      _url =  [NSURL fileURLWithPath:path];
      _lb1.title = path;

    }
  }];



}


@end
