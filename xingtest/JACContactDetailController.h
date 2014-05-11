//
//  JACContactDetailController.h
//  xingtest
//
//  Created by Jose Alcalá Correa on 10/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JACContactDetailControllerMode) {
    JACContactDetailControllerModeDisplay = 0,
    JACContactDetailControllerModeEdit,
};

@interface JACContactDetailController : UIViewController

@property (strong, nonatomic) NSString * contactId;
@property (strong, nonatomic) NSDictionary * contact;
@property (readonly, nonatomic) JACContactDetailControllerMode mode;
@property (readonly, nonatomic) BOOL isUser;

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@property (weak, nonatomic) IBOutlet UITextField *firstNameEdit;
@property (weak, nonatomic) IBOutlet UITextField *surnameEdit;
@property (weak, nonatomic) IBOutlet UITextField *currentPositionEdit;
@property (weak, nonatomic) IBOutlet UITextField *currentCompanyEdit;

@property (weak, nonatomic) IBOutlet UILabel *premiumLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;

@end
