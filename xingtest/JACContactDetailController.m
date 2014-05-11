//
//  JACContactDetailController.m
//  xingtest
//
//  Created by Jose Alcalá Correa on 10/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import "JACContactDetailController.h"
#import <XNGAPIClient+UserProfiles.h>
#import <JMImageCache.h>
#import "NSDictionary+TreeAccess.h"

@interface JACContactDetailController ()

@end

@implementation JACContactDetailController

- (BOOL)isUser
{
    return [self.contactId isEqualToString:@"me"];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
    if( _contact[@"photo_urls.large"] == nil) {
        [self reloadUser];
    }
}

- (IBAction)navBarRightAction:(id)sender
{
    if(self.isUser) {
        if(self.mode == JACContactDetailControllerModeDisplay) {
            _mode = JACContactDetailControllerModeEdit;
        } else {
            _mode = JACContactDetailControllerModeDisplay;
            [self uploadChanges];
        }
        
        [self updateView];
    } else {
        [self performSegueWithIdentifier:@"display_contacts" sender:sender];
    }
}


- (void) reloadUser
{
    [[XNGAPIClient sharedClient] getUserWithID:self.contactId userFields:nil success:^(id JSON) {
        _contact = JSON[@"users"][0];
        [self updateView];
    } failure:^(NSError * error) {
        
    }];

}

- (void) uploadChanges
{
    
}

- (void) configureNavigationBar
{
    if(self.mode == JACContactDetailControllerModeDisplay) {
        self.navigationItem.leftBarButtonItem = nil;
        if(self.isUser) {
            [self.navigationItem.rightBarButtonItem setTitle:@"edit"];
        } else {
            [self.navigationItem.rightBarButtonItem setTitle:@"contacts"];
        }
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cancel"
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(cancelEdit)];
        [self.navigationItem.rightBarButtonItem setTitle:@"done"];
    }
}

- (void) configureActionsAndVisibility
{
    self.firstNameEdit.enabled = self.isUser;
    self.surnameEdit.enabled = self.isUser;
    self.currentPositionEdit.enabled = self.isUser;
    self.currentCompanyEdit.enabled = self.isUser;
    
    UITextBorderStyle borderStyle = self.mode==JACContactDetailControllerModeEdit?
                                    UITextBorderStyleRoundedRect :
                                    UITextBorderStyleNone;
    self.firstNameEdit.borderStyle = borderStyle;
    self.surnameEdit.borderStyle = borderStyle;
    self.currentPositionEdit.borderStyle = borderStyle;
    self.currentCompanyEdit.borderStyle = borderStyle;
    self.photoButton.hidden = self.mode==JACContactDetailControllerModeDisplay;
}

- (void) updateView
{
    [self configureNavigationBar];
    [self configureActionsAndVisibility];
    
    self.firstNameEdit.text = [_contact get:@"first_name" defaultValue:@"..."];
    self.surnameEdit.text = [_contact get:@"last_name" defaultValue:@"..."];
    self.currentPositionEdit.text = [_contact get:@"professional_experience.primary_company.title" defaultValue:@"..."];
    self.currentCompanyEdit.text = [_contact get:@"professional_experience.primary_company.name" defaultValue:@"..."];
    
    NSString * imageUrl = [_contact get:@"photo_urls.large"];
    if(imageUrl != nil) {
        [self.photoView setImageWithURL: [NSURL URLWithString:imageUrl] ];
    } else {
        self.photoView.image = nil;
    }
    
    NSArray * badges = [_contact get:@"badges"];
    self.premiumLabel.text = [badges componentsJoinedByString:@", "];
}

- (void) cancelEdit
{
    _mode = JACContactDetailControllerModeDisplay;
    [self updateView];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"display_contacts"]) {
        [segue.destinationViewController setContact:self.contact];
    }
}


@end
