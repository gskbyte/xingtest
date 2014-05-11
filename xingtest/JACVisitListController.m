//
//  JACContactListController.m
//  xingtest
//
//  Created by Jose Alcalá Correa on 10/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import "JACVisitListController.h"
#import <XNGAPIClient.h>
#import <XNGAPIClient+ProfileVisits.h>
#import <JMImageCache.h>

#import "JACContactDetailController.h"
#import "JACContactCell.h"
#import "NSDictionary+TreeAccess.h"

@interface JACVisitListController ()
{
    NSMutableArray *_visits;
}
@end

@implementation JACVisitListController
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    self.refreshControl = refresh;
    [self.refreshControl addTarget:self
                            action:@selector(requestVisits)
                  forControlEvents:UIControlEventValueChanged];
    
    if(_visits == nil) {
        [refresh beginRefreshing];
        [self requestGroups];
    }
}

- (void) requestGroups
{

    
    [[XNGAPIClient sharedClient] getContactsForUserID:@"me" limit:100 offset:0 orderBy:XNGContactsOrderOptionByLastName userFields:@"display_name,photo_urls,professional_experience" success:^(id JSON) {
        _users = [NSMutableArray new];
        [self.refreshControl endRefreshing];
        _users = JSON[@"contacts"][@"users"];
        [self.tableView reloadData];
        NSLog(@"contacts: %@", JSON);
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JACContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
    
    NSDictionary * user = _users[indexPath.row];
    [cell.photoView setImageWithURL:[NSURL URLWithString: [user get:@"photo_urls.medium_thumb"]]];
    cell.nameLabel.text = user[@"display_name"];
    NSString * position = [user get:@"professional_experience.primary_company.title"];
    NSString * company_name = [user get:@"professional_experience.primary_company.title"];
    
    cell.positionCompanyLabel.text = [NSString stringWithFormat:@"%@ @ %@", position, company_name];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _users[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
    }
}
*/

@end
