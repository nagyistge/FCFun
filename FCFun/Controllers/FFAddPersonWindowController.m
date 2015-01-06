//
//  FFAddPersonWindowController.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "FFAddPersonWindowController.h"

#import "Person.h"
#import "FFRolesDataSource.h"

@interface FFAddPersonWindowController ()

@property (strong) IBOutlet FFRolesDataSource *rolesDataSource;

@property (weak) IBOutlet NSTextField *nameField;
@property (weak) IBOutlet NSComboBox *roleComboBox;
@property (weak) IBOutlet NSButton *addButton;
@property (assign, getter=isDone) BOOL done;
@property (weak) IBOutlet NSTextField *errorLabel;

@end

@implementation FFAddPersonWindowController

- (instancetype)init
{
    return [super initWithWindowNibName:NSStringFromClass([self class])];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillCloseNotification object:self.window queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if (!self.isDone && self.completionHandler) self.completionHandler(nil);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowDidBecomeKeyNotification object:self.window queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        // if we have more than one FFAddPersonWindowController on screen, one of them may have added a new role, so we update the list of roles when the window becomes key
        [self.rolesDataSource refresh];
    }];
}

- (IBAction)addAction:(id)sender {
    Person *person = [Person new];
    person.name = self.nameField.stringValue;
    
    if (!person.isValid) {
        [self showError:@"Please make sure the name is at least 3 characters long"];
        [self.nameField becomeFirstResponder];
        return;
    }
    
    if (!self.roleComboBox.stringValue || [self.roleComboBox.stringValue isEqualToString:@""]) {
        [self showError:@"Please select an existing role or provide a new role name"];
        [self.roleComboBox becomeFirstResponder];
        return;
    }
    
    person.role_id = self.rolesDataSource.selectedRoleIndex;
    
    [person save];
    self.done = YES;
    
    if (self.completionHandler) {
        self.done = YES;
        self.completionHandler(person);
    }
}

- (void)showError:(NSString *)errorString
{
    self.errorLabel.stringValue = errorString;
    self.errorLabel.hidden = NO;
}

@end
