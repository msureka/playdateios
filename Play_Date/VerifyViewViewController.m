//
//  VerifyViewViewController.m
//  SportsApp
//
//  Created by MacMini2 on 31/07/17.
//  Copyright © 2017 MacMini2. All rights reserved.
//

#import "VerifyViewViewController.h"
#import "VerifyCodeViewController.h"
#import "FRHyperLabel.h"
#import "Firebase.h"
#import "UIView+RNActivityView.h"
@interface VerifyViewViewController ()
{
    NSUserDefaults *defaults;
    NSDictionary * dictonarCountrycode;
}
@property (weak, nonatomic) IBOutlet FRHyperLabel *termLabel;
@end

@implementation VerifyViewViewController
@synthesize Button_Verify,textfield_mobileno;
- (void)viewDidLoad {
    [super viewDidLoad];
  defaults = [NSUserDefaults standardUserDefaults];

    
//     [Button_Verify setTitleColor:[UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1] forState:UIControlStateNormal];
    Button_Verify.clipsToBounds=YES;
    Button_Verify.layer.cornerRadius=Button_Verify.frame.size.height/2;
    Button_Verify.layer.borderColor=[UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1].CGColor;
    Button_Verify.layer.borderWidth=2.5f;
    [textfield_mobileno becomeFirstResponder];
    
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
    

    dictonarCountrycode=[NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
     @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
     @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
     @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
     @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
     @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
     @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
     @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
     @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
     @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
     @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
     @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
     @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
     @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
     @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
     @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
     @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
     @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
     @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
     @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
     @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
     @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
     @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
     @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
     @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
     @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
     @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
     @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
     @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
     @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
     @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
     @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
     @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
     @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
     @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
     @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
     @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
     @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
     @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
     @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
     @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
     @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
     @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
     @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
     @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
     @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
     @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
     @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
     @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
     @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
     @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
     @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
     @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
     @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
     @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
     @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
     @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
     @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
     @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
     @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
     @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    [self setDefaultCountryCode];
    [label setLinksForSubstrings:@[@"Terms of Service", @"Privacy Policy"] withLinkHandler:handler];
    Button_Verify .enabled=NO;
}

-(void)setDefaultCountryCode
{
    NSString *countryIdentifier = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSLog(@"%@",[NSString stringWithFormat:@"+%@",[dictonarCountrycode objectForKey:countryIdentifier]]);
    NSString * contrycodes=[NSString stringWithFormat:@"%@",[dictonarCountrycode objectForKey:countryIdentifier]];
    if (contrycodes !=nil)
    {
        textfield_mobileno.text=contrycodes;
    }
}
-(IBAction)VerfiyButtonAction:(id)sender
{
    [self.view showActivityViewWithLabel:@"Sending..."];
    
    [[FIRPhoneAuthProvider provider] verifyPhoneNumber:[NSString stringWithFormat:@"%@%@",@"+",textfield_mobileno.text]
                                            completion:^(NSString * _Nullable verificationID, NSError * _Nullable error) {
                                                if (error)
                                                {
                                    [self.view hideActivityViewWithAfterDelay:0];
                                                    
                                                    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not send you a verification code. Please check your mobile no. and try again."preferredStyle:UIAlertControllerStyleAlert];
                                                    
                                                    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                                {
                                                                                    
                                                                                    
                                                                                    
                                                                                }];
                                                    
                                                    [alert addAction:yesButton];
                                                    [self presentViewController:alert animated:YES completion:nil];
                                                    
                                                    return;
                                                }
                                                else
                                                {
                [defaults setObject:verificationID forKey:@"authVerificationID"];
                        [defaults synchronize];
                [self.view hideActivityViewWithAfterDelay:0];
                                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                    
                VerifyCodeViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"VerifyCodeViewController"];
                                                    set.str_mobileNo=textfield_mobileno.text;
                                                    [self.navigationController pushViewController:set animated:YES];
                                                }
                       
                            NSLog(@"Verification Id==%@",verificationID);
                                            }];
}

- (IBAction)Textfelds_Actions:(id)sender
{
    if (textfield_mobileno.text.length !=0  )
    {
        
        Button_Verify.enabled=YES;
       
        [Button_Verify setBackgroundColor:[UIColor whiteColor]];
 Button_Verify.layer.borderColor=[UIColor whiteColor].CGColor;
        
    }
    else
    {
             Button_Verify.enabled=NO;
       [Button_Verify setBackgroundColor:[UIColor clearColor]];
    Button_Verify.layer.borderColor=[UIColor colorWithRed:39/255.0 green:40/255.0 blue:39/255.0 alpha:1].CGColor;
   
        
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

@end
