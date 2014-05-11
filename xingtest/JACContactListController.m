//
//  JACContactListController.m
//  xingtest
//
//  Created by Jose Alcalá Correa on 10/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import "JACContactListController.h"
#import <XNGAPIClient.h>
#import <XNGAPIClient+Contacts.h>
#import <JMImageCache.h>

#import "JACContactDetailController.h"
#import "JACContactCell.h"
#import "NSDictionary+TreeAccess.h"

@interface JACContactListController ()
{
    NSInteger _totalContacts;
    NSMutableArray *_contacts;
}
@end

@implementation JACContactListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    self.refreshControl = refresh;
    [self.refreshControl addTarget:self
                            action:@selector(requestContacts)
                  forControlEvents:UIControlEventValueChanged];
    
    if(_contacts == nil) {
        [refresh beginRefreshing];
        [self requestContacts];
    }
}

- (void) requestContacts
{
    [self requestContacts:0];
}


- (void) requestContacts:(NSUInteger)offset
{
    [[XNGAPIClient sharedClient] getContactsForUserID:self.contact[@"id"] limit:10 offset:offset orderBy:XNGContactsOrderOptionByLastName userFields:@"id,display_name,photo_urls,professional_experience.primary_company" success:^(id JSON) {
        NSLog(@"contacts: %@", JSON);
        [self.refreshControl endRefreshing];
        
        
        NSArray * obtainedContacts = [JSON get:@"contacts.users"];
        if([obtainedContacts isKindOfClass:[NSNull class]]) {
            _totalContacts = 0;
            return;
        }
        
        _totalContacts = [[JSON get:@"contacts.total"] integerValue];
        
        // if the obtained contacts are null, the user is hiding his/her contacts
        if(offset == 0) {
            if([obtainedContacts isKindOfClass:[NSArray class]]) {
                _contacts = [NSMutableArray arrayWithArray:obtainedContacts];
            } else {
                _contacts = [NSMutableArray new];
            }
            
            [self.tableView reloadData];
        } else {
            [self.tableView beginUpdates];
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_contacts.count inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationLeft];
            NSMutableArray * addedIndexPaths = [NSMutableArray arrayWithCapacity:obtainedContacts.count];
            for(NSDictionary * contact in obtainedContacts) {
                [addedIndexPaths addObject: [NSIndexPath indexPathForRow:_contacts.count inSection:0] ];
                [_contacts addObject:contact];
            }
            if(_contacts.count < _totalContacts) {
                [addedIndexPaths addObject:[NSIndexPath indexPathForRow:_contacts.count inSection:0]];
            }
            [self.tableView insertRowsAtIndexPaths:addedIndexPaths
                                  withRowAnimation:UITableViewRowAnimationTop];
            
            [self.tableView endUpdates];
        }
        
        self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"%d contacts", _totalContacts];
        
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_contacts.count == _totalContacts) {
        return _contacts.count;
    } else {
        return _contacts.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _contacts.count) {
        JACContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
        
        NSDictionary * user = _contacts[indexPath.row];
        [cell.photoView setImageWithURL:[NSURL URLWithString: [user get:@"photo_urls.medium_thumb"]]];
        cell.nameLabel.text = user[@"display_name"];
        NSString * position = [user get:@"professional_experience.primary_company.title"];
        NSString * company_name = [user get:@"professional_experience.primary_company.title"];
        
        cell.positionCompanyLabel.text = [NSString stringWithFormat:@"%@ @ %@", position, company_name];
        
        return cell;
    } else {
        UITableViewCell * loadingCell = [tableView dequeueReusableCellWithIdentifier:@"loading" forIndexPath:indexPath];
        [self requestContacts:_contacts.count];
        return loadingCell;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"display_contact"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary * user = _contacts[indexPath.row];
        [segue.destinationViewController setContact:user];
        [segue.destinationViewController setContactId:user[@"id"]];
    }
}


@end
