//
//  FFRolesDataSource.h
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

@import Cocoa;

@interface FFRolesDataSource : NSObject <NSComboBoxDataSource, NSComboBoxDelegate>

@property (copy) NSArray *roles;
@property (weak) IBOutlet NSComboBox *comboBox;
@property (nonatomic, readonly) int64_t selectedRoleIndex;

- (void)refresh;

@end
