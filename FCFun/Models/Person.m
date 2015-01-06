//
//  FFPerson.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "Person.h"

#import "Role.h"

@implementation Person

- (Role *)role
{
    if (self.role_id) {
        return [Role instanceWithPrimaryKey:@(self.role_id)];
    } else {
        return nil;
    }
}

- (void)setRole:(Role *)role
{
    [role save];
    
    if (!role) {
        self.role_id = 0;
    } else {
        self.role_id = role.id;
    }
}

- (FCModelSaveResult)delete
{
    [self deleteRoleIfNeeded];
    
    return [super delete];
}

- (BOOL)isValid
{
    // a valid person must have a name of at least 3 characters
    return (self.name.length >= 3);
}

/**
 Deletes this person's role if no other person is assigned the same role
 */
- (void)deleteRoleIfNeeded
{
    NSArray *peopleWithMyRole = [Person instancesWhere:@"role_id = ?" arguments:@[@(self.role_id)]];
    if (peopleWithMyRole.count == 1) {
        [self.role delete];
    }
}

@end
