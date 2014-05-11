//
//  JACContactCell.h
//  xingtest
//
//  Created by Jose Alcalá Correa on 10/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JACContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionCompanyLabel;

@end
