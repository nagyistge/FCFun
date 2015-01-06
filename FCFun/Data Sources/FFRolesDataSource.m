//
//  FFRolesDataSource.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "FFRolesDataSource.h"

#import "Role.h"

@implementation FFRolesDataSource

- (void)awakeFromNib
{
    [self refresh];
}

- (void)refresh
{
    self.roles = [Role allInstances];
    [self.comboBox reloadData];
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    return self.roles.count;
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    Role *r = self.roles[index];
    
    return r.name;
}

- (int64_t)selectedRoleIndex
{
    Role *r = [Role firstInstanceWhere:@"name = ?", self.comboBox.stringValue];

    if (!r) {
        r = [Role new];
        r.name = self.comboBox.stringValue;
        [r save];
    }
    
    return r.id;
}

@end
