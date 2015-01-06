//
//  FFPeopleDataSource.h
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

@import Cocoa;

#import "Person.h"

@interface FFPeopleDataSource : NSObject <NSTableViewDataSource, NSTableViewDelegate>

@property (copy) NSArray *people;
@property (weak) IBOutlet NSTableView *tableView;
@property (assign, getter=isRefreshing) BOOL refreshing;

- (IBAction)refresh:(id)sender;
- (void)deleteSelectedPerson;

@end
