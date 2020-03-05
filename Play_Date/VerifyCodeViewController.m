//
//  VerifyCodeViewController.m
//  SportsApp
//
//  Created by MacMini2 on 31/07/17.
//  Copyright © 2017 MacMini2. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "FRHyperLabel.h"
#import "Firebase.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "UIView+RNActivityView.h"
#import "SinupStepOneViewController.h"
#import "MainProfilenavigationController.h"
@interface VerifyCodeViewController ()
{
    NSMutableArray * Array_sinupFb;
    NSUserDefaults * defaults;
    NSDictionary * urlplist;
}
@property (weak, nonatomic) IBOutlet FRHyperLabel *termLabel;
@end

@implementation VerifyCodeViewController

@synthesize Button_Verify,textfield_mobileno,Button_Resend;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    defaults=[[NSUserDefaults alloc]init];
    //[defaults setObject:verificationID forKey:@"authVerificationID"];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    Button_Verify.clipsToBounds=YES;
    Button_Verify.layer.cornerRadius=Button_Verify.frame.size.height/2;
    [Button_Verify setBackgroundColor:[UIColor clearColor]];
    Button_Verify.layer.borderColor=[UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1].CGColor;
    Button_Verify.layer.borderWidth=2.5f;
    
    Button_Resend.clipsToBounds=YES;
    Button_Resend.layer.cornerRadius=Button_Verify.frame.size.height/2;
    Button_Resend.layer.borderColor=[UIColor whiteColor].CGColor;
     [Button_Resend setBackgroundColor:[UIColor whiteColor]];
    Button_Resend.layer.borderWidth=2.5f;
    [textfield_mobileno becomeFirstResponder];
    
    Button_Verify .enabled=NO;
    
    Button_Resend.enabled=YES;
    
    CALayer *borderBottom_passeord = [CALayer layer];
    borderBottom_passeord.backgroundColor = [UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1].CGColor;
    borderBottom_passeord.frame = CGRectMake(0, textfield_mobileno.frame.size.height-0.8, textfield_mobileno.frame.size.width,0.5f);
    [textfield_mobileno.layer addSublayer:borderBottom_passeord];
    
    FRHyperLabel *label = self.termLabel;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Roboto" size:12]];
    // UIFont *text1Font = [UIFont fontWithName:@"Helvitica" size:12];
    
    //Step 1: Define a normal attributed string for non-link texts
    
    NSString *string = @"By signing in, you agree to our Terms of Service and Privacy Policy";
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1],NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]};
    
    
    label.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    
    //Step 2: Define a selection handler block
    
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring)
    {
        
        if ([substring isEqualToString:@"Terms of Service"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://play-date.ae/terms.html"]];
            
        }
        if ([substring isEqualToString:@"Privacy Policy"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://play-date.ae/privacy.html"]];
            
        }
    };
    
    //Step 3: Add link substrings
    
    [label setLinksForSubstrings:@[@"Terms of Service", @"Privacy Policy"] withLinkHandler:handler];
   

   
}
-(IBAction)VerfiyButtonAction:(id)sender
{
    [self.view showActivityViewWithLabel:@"Verifying..."];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *verificationID = [defaults stringForKey:@"authVerificationID"];
    FIRAuthCredential *credential = [[FIRPhoneAuthProvider provider]
                                     credentialWithVerificationID:verificationID
                                     verificationCode:textfield_mobileno.text];
  
    
    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  if (error)
                                  {
                                       [self.view hideActivityViewWithAfterDelay:0];
                                      UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Verification code error!" message:@"There is an error in your code. Please enter correct verification code to verify."preferredStyle:UIAlertControllerStyleAlert];
                                      
                                      UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                  {
                                                                      
                                                                      
                                                                      
                                                                  }];
                                      
                                      [alert addAction:yesButton];
                                      [self presentViewController:alert animated:YES completion:nil];
                                      
                                      
                                     
                                      return;
                                  }
                               
                                  NSLog(@"Suceess full sign in");
                                  [self verfyclientserverCommmunication];
                              }];
}
-(IBAction)ResendButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Textfelds_Actions:(id)sender
{
    if (textfield_mobileno .text.length !=0  )
    {
        
        Button_Verify.enabled=YES;

    [Button_Verify setBackgroundColor:[UIColor whiteColor]];
    Button_Verify.layer.borderColor=[UIColor whiteColor].CGColor;
    //Button_Verify.layer.borderColor=[UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1].CGColor;
        
    }
    else
    {
        Button_Verify.enabled=NO;
    [Button_Verify setBackgroundColor:[UIColor clearColor]];
        Button_Verify.layer.borderColor=[UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1].CGColor;
       // [Button_Verify setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
-(void)verfyclientserverCommmunication
{
    
    
    NSString *userid= @"fbid";
    NSString *useridVal =[defaults valueForKey:@"fid"];
    
    NSString *mobileid = @"mobileno";
    NSString *mobileNumberVal =_str_mobileNo;
    
    
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,mobileid,mobileNumberVal];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"verifymobile"];
    url =[NSURL URLWithString:urlStrLivecount];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];//Web API Method
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                     {
                                         
                                         if(data)
                                         {
                                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                             NSInteger statusCode = httpResponse.statusCode;
                                             if(statusCode == 200)
                                             {
                                                 
                                                 Array_sinupFb=[[NSMutableArray alloc]init];
                                                 SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                 Array_sinupFb =[objSBJsonParser objectWithData:data];
                                                 
                                                 
                                                 
                                                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                                 NSLog(@"Array_Verify %@",Array_sinupFb);
                                                 
                                                 if (Array_sinupFb.count !=0)
                                                 {
                                                     
                                                         
                                                         if([[[Array_sinupFb objectAtIndex:0]valueForKey:@"registration_status"] isEqualToString:@"NEWUSER"])
                                                         {
                                                             
                                                             
                                                             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                             
                                                             SinupStepOneViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SinupStepOneViewController"];
                                                             [self.navigationController pushViewController:set animated:YES];
                                                             
                                                            
                                                             
                                                         }
                                                         else if([[[Array_sinupFb objectAtIndex:0]valueForKey:@"registration_status"] isEqualToString:@"COMPLETE"])
                                                         {
                                                             
                                                             
                                                             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                             MainProfilenavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
                                                             [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
                                                             
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"fname"] forKey:@"fname"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"userid"] forKey:@"userid"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emailid"] forKey:@"emailid"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"gender"] forKey:@"gender"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity1"] forKey:@"activity1"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity2"] forKey:@"activity2"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity3"] forKey:@"activity3"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"agegroup"] forKey:@"agegroup"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"pushmatch"] forKey:@"Switch1"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"pushmessage"] forKey:@"Switch2"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"birthdate"] forKey:@"DOB"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"city"] forKey:@"city"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"country"] forKey:@"country"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"description"] forKey:@"description"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"distance"] forKey:@"distance"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"] forKey:@"English"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"] forKey:@"French"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"] forKey:@"Arabic"];
                                                             
                                                             
                                                             if (![[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"] isEqualToString:@""] && [[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&[[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                                                             {
                                                                 
                                                                 [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"] forKey:@"language"];
                                                             }
                                                             if ([[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && ![[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&[[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                                                             {
                                                                 
                                                                 [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"] forKey:@"language"];
                                                             }
                                                             
                                                             if ([[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && [[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&![[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                                                             {
                                                                 
                                                                 [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"] forKey:@"language"];
                                                             }
                                                             
                                                             
                                                             if (![[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && [[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&![[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                                                             {
                                                                 [defaults setObject:[NSString stringWithFormat:@"%@%@%@",[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"],@",",[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]] forKey:@"language"];
                                                             }
                                                             
                                                             
                                                             
                                                             if (![[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && ![[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&![[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                                                             {
                                                                 [defaults setObject:[NSString stringWithFormat:@"%@%@%@%@%@",[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"],@",",[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"],@",",[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]] forKey:@"language"];
                                                             }
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji1"] forKey:@"emoji1"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji2"] forKey:@"emoji2"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji3"] forKey:@"emoji3"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"icanmeet"] forKey:@"icanmeet"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"liketoplay"] forKey:@"liketoplay"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"makefriendswith"] forKey:@"makefriendswith"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"profilepic"] forKey:@"profilepic"];
                                                             
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"age"] forKey:@"age"];
                                                             
                                                             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"superhero"] forKey:@"superhero"];
                                                             
                                                             
                                                             [defaults setObject:@"yes" forKey:@"Loginplay"];
                                                             [defaults synchronize];
                                                             [self.view hideActivityViewWithAfterDelay:1];
                                                             
                                                             NSLog(@"ValuesOfSecondView33=%@",[defaults valueForKey:@"liketoplay"]);
                                                             NSLog(@"ValuesOfSecondView33=%@", [defaults valueForKey:@"liketoplay"]);
                                                             NSLog(@"ValuesOfSecondView33=%@", [defaults valueForKey:@"icanmeet"]);
                                                             
                                                         }
                                                     
                                                     
                                                     
                                                 }
                                                 
                                                 
                                                 if ([ResultString isEqualToString:@"updateerror"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Server encountered an error in verifying your mobile number. Please try again later." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                     
                                                 }
                                                 
                                                 if ([ResultString isEqualToString:@"alreadyregistered"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Already registered" message:@"Sorry your mobile number has already been registered by some other user. Please try using another mobile number." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                     
                                                 }
       
                                                 
                                                 
                                             }
                                             
                                             
                                             else
                                             {
                                                 NSLog(@" error login1 ---%ld",(long)statusCode);
                                                 [self.view hideActivityViewWithAfterDelay:0];
                                             }
                                             
                                             
                                         }
                                         else if(error)
                                         {
                                             [self.view hideActivityViewWithAfterDelay:0];
                                             NSLog(@"error login2.......%@",error.description);
                                         }
                                         
                                         
                                     }];
    [dataTask resume];
    
    
    
    
    
    
    
}
@end
