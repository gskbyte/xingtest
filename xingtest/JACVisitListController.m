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
    BOOL _allVisitsLoaded;
}
@end

@implementation JACVisitListController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    self.refreshControl = refresh;
    [self.refreshControl addTarget:self
                            action:@selector(requestInitialVisits)
                  forControlEvents:UIControlEventValueChanged];
    
    if(_visits == nil) {
        [refresh beginRefreshing];
        [self requestInitialVisits];
    }
}

- (void) requestInitialVisits
{
    [self requestVisitsWithOffset:0];
}

-(void) requestVisitsWithOffset:(int)offset
{
    NSDate* now = [NSDate date];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    components.day = -30;
    NSDate * beginDate = [calendar dateByAddingComponents:components toDate:now options:0];
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

    NSString * beginDateStr = [formatter stringFromDate:beginDate];
    
    
    
    [[XNGAPIClient sharedClient] getVisitsWithLimit:10 offset:offset since:beginDateStr stripHTML:NO success:^(id JSON) {
        NSArray * receivedVisits = JSON[@"visits"];
        if(offset == 0) {
            _visits = [NSMutableArray new];
            _allVisitsLoaded = NO;
        }
        
        NSLog(@"%@", JSON);
        
        if (receivedVisits.count == 0) {
            _allVisitsLoaded = YES;
        } else {
            [_visits addObjectsFromArray:receivedVisits];
        }
        
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"fuck");
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _visits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"visitCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _visits[indexPath.row][@"display_name"];
    cell.detailTextLabel.text = _visits[indexPath.row][@"visited_at"];
    
    if(indexPath.row == _visits.count-1) {
        [self requestVisitsWithOffset:_visits.count];
    }
    
    return cell;
}


/*
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
