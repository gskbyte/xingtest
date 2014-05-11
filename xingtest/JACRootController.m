//
//  MasterViewController.m
//  xingtest
//
//  Created by Jose Alcalá Correa on 07/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import "JACRootController.h"

#import <XNGAPIClient.h>
#import <XNGAPIClient+Contacts.h>
#import <XNGAPIClient+UserProfiles.h>

#import <UIImageView+JMImageCache.h>

#import "NSDictionary+TreeAccess.h"
#import "JACTitleCell.h"
#import "JACContactDetailController.h"

typedef NS_ENUM(NSUInteger, JACCellIndex)
{
    JACCellIndexTitle = 0,
    JACCellIndexContacts,
    
    JACCellIndexCount
};

@interface JACRootController ()
{
    NSDictionary * _user;
}
@end

@implementation JACRootController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    
    if( ! [XNGAPIClient sharedClient].isLoggedin ) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login requested", @"Login requested")
                                                             message:NSLocalizedString(@"This app needs your permission to access your XING account", @"")
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                   otherButtonTitles:@"OK", nil];
        [alertView show];
    } else if (!self.displayData) {
        [self.refreshControl beginRefreshing];
        [self loadData];
    }
}

- (void) loadData
{
    [[XNGAPIClient sharedClient] getUserWithID:@"me" userFields:nil success:^(id JSON) {
        NSLog(@"%@", JSON);
        _user = JSON[@"users"][0];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        
    }];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        NSLog(@"User doesn't want to login :(");
    } else {
        XNGAPIClient * client = [XNGAPIClient sharedClient];
        [client loginOAuthWithSuccess:^{
            [self.refreshControl beginRefreshing];
            [self loadData];
        } failure:^(NSError *error) {
            
        }];
    }
}

- (BOOL) displayData
{
    return [XNGAPIClient sharedClient].isLoggedin && _user!=nil;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.displayData ) {
        return JACCellIndexCount;
    } else {
        return 0;
    }
}

// why doesn't it take it from the storyboard???
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case JACCellIndexTitle:
            return 170;
        case JACCellIndexContacts:
            return 44;
        default:
            return 44; // explode!
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case JACCellIndexTitle: {
            JACTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath];
            cell.nameLabel.text = _user[@"display_name"];
            cell.positionLabel.text = [_user get:@"professional_experience.companies.0.title"];
            cell.companyLabel.text = [_user get:@"professional_experience.companies.0.name"];
            [cell.photoView setImageWithURL:[NSURL URLWithString: [_user get:@"photo_urls.large"] ]];
            
            return cell;
        }
            break;
            
        case JACCellIndexContacts: {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"contacts" forIndexPath:indexPath];
            
            return cell;
        }
            break;
        default:
            return nil; // explode!
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if([segue.identifier isEqualToString:@"display_me"]) {
        [segue.destinationViewController setContact:_user];
        [segue.destinationViewController setContactId:@"me"];
    } else if([segue.identifier isEqualToString:@"contacts"]) {
        [segue.destinationViewController setContact:_user];
    }
}

@end
