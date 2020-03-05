//
//  SettingGenderViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "SettingGenderViewController.h"

@interface SettingGenderViewController ()
{
NSArray * Array_Gender,*Array_Gender1,*Array_genderImg;
NSUserDefaults * defaults;
    NSString  *Borderline;
}
@end

@implementation SettingGenderViewController
@synthesize HeadTopView,Table_Gender,cell_Gender;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
     Borderline=@"yes";
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    Array_Gender=[[NSArray alloc]initWithObjects:@"Boys \U0001F466",@"Girls \U0001F467",@"Boys & Girls \U0001F466\U0001F467", nil];
    Array_Gender1=[[NSArray alloc]initWithObjects:@"BOY",@"GIRL",@"BOYSANDGIRLS", nil];
    // Array_genderImg=[[NSArray alloc]initWithObjects:@"UserMale-48.png",@"UserFemale-48.png",@"UserMale-48.png",@"UserFemale-48.png", nil];
    Table_Gender.delegate=self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 46)];
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10,10, self.view.frame.size.width-20, 28)];
    labelView.textColor=[UIColor lightGrayColor];
    labelView.text=@"Make friends with";
    labelView.backgroundColor=[UIColor clearColor];
    [headerView addSubview:labelView];
    Table_Gender.tableHeaderView = headerView;
    [Table_Gender reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BackView:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Array_Gender.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 48;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid1=@"Cell_Gender";
    
    cell_Gender = (GenderViewTableViewCell*)[Table_Gender dequeueReusableCellWithIdentifier:mycellid1 forIndexPath:indexPath];
    
    
    if (cell_Gender == nil)
    {
        
        cell_Gender = [[GenderViewTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid1];
    }
    cell_Gender.Names.text=[Array_Gender objectAtIndex:indexPath.row];
    cell_Gender.EmojjiImg.hidden=YES;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([Borderline isEqualToString:@"yes"])
    {
        if (indexPath.row == 0  )
        {
            UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
            topLineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
            [cell_Gender.contentView addSubview:topLineView];
        }
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell_Gender.bounds.size.height-1, self.view.bounds.size.width, 1)];
        bottomLineView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [cell_Gender.contentView addSubview:bottomLineView];
    }
    if (indexPath.row==2)
    {
        Borderline=@"no";
        
    }
    
    if ([[Array_Gender1 objectAtIndex:indexPath.row] isEqualToString:[defaults valueForKey:@"makefriendswith"]])
    {
        cell_Gender.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else
    {
        cell_Gender.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    return cell_Gender;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    [Table_Gender cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [defaults setObject:[Array_Gender1 objectAtIndex:indexPath.row] forKey:@"makefriendswith"];
    [defaults synchronize];
    [Table_Gender reloadData];
}



@end