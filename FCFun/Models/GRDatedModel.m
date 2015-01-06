//
//  GRDatedModel.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "GRDatedModel.h"

@implementation GRDatedModel

- (FCModelSaveResult)save
{
    if (!self.createdAt) self.createdAt = [NSDate date];
    self.updatedAt = [NSDate date];
    
    return [super save];
}

@end
