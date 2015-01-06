//
//  FFAddPersonWindowController.h
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GRProperWindowController.h"

@class Person;

@interface FFAddPersonWindowController : GRProperWindowController

@property (strong) void (^completionHandler)(Person *person);

@end
