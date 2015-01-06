//
//  FFPeopleDataSource.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "FFPeopleDataSource.h"

@implementation FFPeopleDataSource

- (void)awakeFromNib
{
    [self refresh:nil];
}

- (IBAction)refresh:(id)sender
{
    if (self.isRefreshing) return;
    
    self.refreshing = YES;
    
    self.people = [Person instancesOrderedBy:@"createdAt DESC"];
    [self.tableView reloadData];
    
    self.refreshing = NO;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.people.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"person" owner:tableView];
    
    Person *p = self.people[row];
    cellView.textField.stringValue = p.name;
    
    return cellView;
}

- (void)deleteSelectedPerson
{
    if (self.tableView.selectedRow < 0) return;
    
    [self.tableView beginUpdates];
    {
        Person *p = self.people[self.tableView.selectedRow];
        [p delete];
        
        NSMutableArray *mutablePeople = [self.people mutableCopy];
        [mutablePeople removeObjectAtIndex:self.tableView.selectedRow];
        self.people = mutablePeople;
        
        [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.tableView.selectedRow] withAnimation:NSTableViewAnimationEffectGap];
    }
    [self.tableView endUpdates];
}

@end
