//
//  FFPerson.h
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "GRDatedModel.h"

@class Role;

@interface Person : GRDatedModel

@property (nonatomic) int64_t id;
@property (nonatomic, copy) NSString *name;

@property (nonatomic) int64_t role_id;
@property (nonatomic, assign) Role *role;

@property (readonly) BOOL isValid;

@end
