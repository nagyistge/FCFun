//
//  Role.h
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "GRDatedModel.h"

@interface Role : GRDatedModel

@property (nonatomic) int64_t id;
@property (nonatomic, copy) NSString *name;

@end
