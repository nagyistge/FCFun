//
//  GRProperWindowController.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "GRProperWindowController.h"

@interface GRProperWindowController ()

@end

@implementation GRProperWindowController

- (instancetype)init
{
    return [self initWithWindowNibName:NSStringFromClass([self class])];
}

- (void)showWindow:(id)sender
{
    if (!self.window.restorable) [self.window center];
    
    [super showWindow:sender];
}

@end
