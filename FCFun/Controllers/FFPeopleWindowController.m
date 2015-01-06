//
//  FFPeopleWindowController.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "FFPeopleWindowController.h"
#import "FFPeopleDataSource.h"
#import "FFAddPersonWindowController.h"

@interface FFPeopleWindowController ()

@property (strong) IBOutlet FFPeopleDataSource *peopleDataSource;
@property (nonatomic, strong) NSMutableArray *addPersonWindowControllers;

@end

@implementation FFPeopleWindowController

#pragma mark CRUD

- (IBAction)addPersonAction:(id)sender {
    if (!self.addPersonWindowControllers) self.addPersonWindowControllers = [NSMutableArray new];
    
    FFAddPersonWindowController *addWC = [[FFAddPersonWindowController alloc] init];
    [self.addPersonWindowControllers addObject:addWC];
    
    __weak typeof (addWC) weakAddWC = addWC;
    [addWC setCompletionHandler:^(Person *person) {
        if (person) {
            [weakAddWC close];
            
            [self.peopleDataSource refresh:nil];
        }
        
        [self.addPersonWindowControllers removeObject:weakAddWC];
    }];
    
    [addWC showWindow:self];
}

- (IBAction)delete:(id)sender
{
    [self.peopleDataSource deleteSelectedPerson];
}

@end
