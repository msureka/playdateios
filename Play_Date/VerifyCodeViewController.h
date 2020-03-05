//
//  VerifyCodeViewController.h
//  SportsApp
//
//  Created by MacMini2 on 31/07/17.
//  Copyright © 2017 MacMini2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCodeViewController : UIViewController
@property(nonatomic,weak)IBOutlet UITextField * textfield_mobileno;
@property(nonatomic,weak)IBOutlet UIButton *  Button_Verify;
@property(nonatomic,weak)IBOutlet UIButton *  Button_Resend;
-(IBAction)VerfiyButtonAction:(id)sender;
-(IBAction)ResendButtonAction:(id)sender;
- (IBAction)Textfelds_Actions:(id)sender;
@property(nonatomic,strong)NSString * str_mobileNo;
@end
