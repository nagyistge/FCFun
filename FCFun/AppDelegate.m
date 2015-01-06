//
//  AppDelegate.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "AppDelegate.h"
#import "FFPeopleWindowController.h"
#import "FFMigrator.h"

@interface AppDelegate ()

@property (nonatomic, strong) FFPeopleWindowController *peopleWC;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [FFMigrator migrateToLatestVersionWithCompletionHandler:^(int version, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [[NSAlert alertWithError:error] runModal];
                [NSApp terminate:nil];
            }
            
            NSLog(@"[FFMigrator] Database is version %d", version);
            
            [self showPeopleWindow];
        });
    }];
}

- (void)showPeopleWindow
{
    if (!self.peopleWC) self.peopleWC = [[FFPeopleWindowController alloc] init];
    
    [self.peopleWC showWindow:self];
}

@end
