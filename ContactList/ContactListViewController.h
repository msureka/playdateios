//
//  ContactListViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 5/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactTableViewCell.h"
#import "ContactAddTableViewCell.h"
@interface ContactListViewController : UIViewController
{
    
}
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(strong,nonatomic)IBOutlet UITableView *tableview_contact;
@property(strong,nonatomic)ContactTableViewCell *cell_contact;
@property(strong,nonatomic)ContactAddTableViewCell *cell_contactAdd;
@property(strong,nonatomic)IBOutlet UISearchBar *searchbar;
@property(strong,nonatomic)IBOutlet UIActivityIndicatorView *indicator;
@property(strong,nonatomic)IBOutlet NSString  *invitetype;
@property(strong,nonatomic)IBOutlet NSString *eventidvalue;

-(IBAction)Button_Back:(id)sender;
@end
