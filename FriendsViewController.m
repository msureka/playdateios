//
//  FriendsViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FriendsViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "FriendCahtingViewController.h"
#import "FriendRequestViewController.h"
#import "ContactListViewController.h"
#import "FacebookListViewController.h"
#import "NavigationNewPlayDateViewController.h"
#import "FriendCahtingViewControlleroneViewController.h"
#import "UIView+RNActivityView.h"
#import <Social/Social.h>
#import "HelpPopViewController.h"
#import "HelpPopChatViewController.h"
#import "HelpPopMeetupsViewController.h"
#import <MessageUI/MessageUI.h>
#import "UIViewController+KeyboardAnimation.h"
@interface FriendsViewController ()<UISearchBarDelegate>
{
     NSTimer *HomechatTimer,*HomechatTimerplaydate;
    NSArray *Array_Title1,*Array_Title2,*Array_Title3,*Array_Title4,*Array_Gender2,*Array_Gender1;
    UIView *sectionView,*transparancyTuchView;
    NSUserDefaults *defaults;
     NSString * TagId_plist,*FlagSearchBar,*searchString;
       BOOL flag;
    NSDictionary *urlplist;
    NSURLConnection *Connection_Match,*Connection_Messages;
    NSMutableData *webData_Match,*webData_Messages;
    NSMutableArray * Array_MatchMessages,*Array_Match,*Array_Messages,*Array_Comment1,*Array_Messages22,*Array_Request,*Array_RequestMessages,*array_createEvent,*Array_Meetups;
    NSArray *SearchCrickArray,*Array_Match1,*Array_Messages1,*Array_Request1,*Array_Meetups1;
    UIScrollView * scrollView;
   
    CGFloat Xpostion, Ypostion, Xwidth, Yheight, ScrollContentSize,Xpostion_label, Ypostion_label, Xwidth_label, Yheight_label;
    CGRect scrollFrame;
    UISearchBar * searchbar;
    NSMutableArray * myarr;
    NSMutableDictionary *dictionary;
     CALayer *borderBottom_chat,*borderBottom_playdate;
    NSString * Str_ChangeScreen,*Str_TextfieldJoinText;
    NSInteger senderTagPlus;
    HelpPopViewController * controllerpop;
    HelpPopChatViewController * controllerpopchat;
    HelpPopMeetupsViewController * controllerpopmeetups;
    
    NSString * Str_MessageAlert,* Str_mobileNumberText,*str_textfield,*str_EmailidText,*placeholder_Alert,*Str_InviteSelect;
    NSDictionary * dictonarCountrycode;
    
     CGFloat tableview_height;
}
@property(nonatomic, strong)UIAlertAction *confirmAction;
@end

@implementation FriendsViewController
@synthesize HeadTopView,Table_Friend,Cell_One,Cell_Two,Button_chats,Button_playdates,Label_HeadTop,Button_Plustap,Cell_Two2,Button_Join,Button_Create,Button_JoinImage,Button_Help,confirmAction;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
//    HelpPopViewController * controller = [[HelpPopViewController alloc] initWithNibName:@"AlertSetViewController"  bundle:nil];
//    
//    [controller.Button_tour addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view  addSubview:controller.view];
    
//    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"HelpPopView" owner:self options:nil];
//    
//    UIView *mainView = [subviewArray objectAtIndex:0];
//    [self.view addSubview:mainView];
   
//    [helpview.Button_tour addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.view.frame.size.width==375.00 && self.view.frame.size.height==812.00)
    {
    [Button_Help setFrame:CGRectMake(Button_Help.frame.origin.x, Button_Help.frame.origin.y+17,Button_Help.frame.size.width,Button_Help.frame.size.height-4)];
        
         [Button_Plustap setFrame:CGRectMake(Button_Plustap.frame.origin.x, Button_Plustap.frame.origin.y+15,26,27)];
        
          [Button_Create setFrame:CGRectMake(Button_Create.frame.origin.x, Button_Create.frame.origin.y+14,53,19)];
        
       [Button_JoinImage setFrame:CGRectMake(Button_JoinImage.frame.origin.x, Button_JoinImage.frame.origin.y+16,Button_JoinImage.frame.size.width,Button_JoinImage.frame.size.height)];
       [Button_Join setFrame:CGRectMake(Button_Join.frame.origin.x, Button_Join.frame.origin.y+14,38,19)];
    }
    
    defaults=[[NSUserDefaults alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"UpdatenotificationChat" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Refresh_UpdatedBudge) name:@"UpdatedBudge" object:nil];
    borderBottom_chat = [CALayer layer];
    borderBottom_playdate = [CALayer layer];
    Label_HeadTop.text=@"Friends";
   // Button_Plustap.tag=1;
    [Button_chats setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    
     _ImageMessageread_Button_chat.hidden=YES;
     _ImageMessageread_Button_playdates.hidden=YES;
    
//    _ImageMessageread_Button_chat.hidden=NO;
//    [_ImageMessageread_Button_chat setImage:[UIImage imageNamed:@"SpeechBubble1.png"]];
    
//    Button_chats.clipsToBounds=YES;
//    Button_playdates.clipsToBounds=YES;
    
    tableview_height=Table_Friend.frame.size.height;
        Array_Comment1=[[NSMutableArray alloc]init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    FlagSearchBar=@"no";
    
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText.plist"];
    
    dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    myarr=[[NSMutableArray alloc]initWithContentsOfFile:path];
    
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:@"ChatText1.plist"];
    
    NSMutableArray *Array_Plist = [[NSMutableArray alloc] initWithContentsOfFile:path1];
    
    NSLog(@"dictionary setValue:=%@",Array_Plist );
    
    if (Array_Plist.count !=0)
    {
        Array_Request = [[NSMutableArray alloc]init];
        Array_Match=[[NSMutableArray alloc]init];
        Array_Messages=[[NSMutableArray alloc]init];
        
        
//        for (int i=0; i<Array_Plist.count; i++)
//        {
//            if ([[[Array_Plist objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
//            {
//                [Array_Match addObject:[Array_Plist objectAtIndex:i]];
//            }
//            else
//            {
//                [Array_Messages addObject:[Array_Plist objectAtIndex:i]];
//             // SearchCrickArray=[Array_Plist mutableCopy];
//            }
//        }
//         SearchCrickArray=[Array_Plist mutableCopy];
//        [Table_Friend reloadData];
        
        
        
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
        
        
        for (int i=0; i<Array_Plist.count; i++)
        {
            if ([[[Array_Plist objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
            {
                
                if (Array_Match.count==0)
                {
                    [Array_Match addObject:[Array_Plist objectAtIndex:i]];
                }
                else
                {
//                    for (int k=0; k<Array_Match.count; k++)
//                    {
//                        if (![[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"] isEqualToString:[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"]])
//                        {
//                            
//                         [Array_Match addObject:[Array_Plist objectAtIndex:i]];
//                            
//                        }
//                        
//                        
//                    }
                    for (NSInteger k=Array_Match.count-1; k<Array_Match.count; k++)
                    {
                        NSString * fbMatch11=[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch22=[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch22 isEqualToString:fbMatch11])
                        {
                            
                            [Array_Match addObject:[Array_Plist objectAtIndex:i]];
                            break;
                        }
                        
                    }

                    
                }
            }
            
          else  if ([[[Array_Plist objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"request"])
            {
                
                if (Array_Request.count==0)
                {
                    [Array_Request addObject:[Array_Plist objectAtIndex:i]];
                }
                else
                {
                    
                    for (NSInteger k=Array_Request.count-1; k<Array_Request.count; k++)
                    {
                        NSString * fbMatch11=[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch22=[[Array_Request objectAtIndex:k]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch22 isEqualToString:fbMatch11])
                        {
                            
                            [Array_Request addObject:[Array_Plist objectAtIndex:i]];
                            break;
                        }
                        
                    }
                    
                    
                }
            }

            
            else
            {
                if (Array_Messages.count==0)
                {
                    [Array_Messages addObject:[Array_Plist objectAtIndex:i]];
                }
                else
                {
                    
                    for (NSInteger J=Array_Messages.count-1; J<Array_Messages.count; J++)
                    {
                        NSString * fbMatch=[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch2=[[Array_Messages objectAtIndex:J]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch2 isEqualToString:fbMatch])
                        {
                            
                            [Array_Messages addObject:[Array_Plist objectAtIndex:i]];
                            break;
                        }
                        
                    }
                }
                
            }
        }
        
        
        SearchCrickArray=[Array_MatchMessages mutableCopy];
        Array_Messages1=[Array_Messages mutableCopy];
        Array_Match1=[Array_Match mutableCopy];
        Array_Request1 = [Array_Request mutableCopy];
        [Table_Friend reloadData];
   
    }
    
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];

    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
     SearchCrickArray=[[NSArray alloc]init];
    Array_Match1=[[NSArray alloc]init];
    Array_Request1 = [[NSArray alloc]init];
    Array_Messages1=[[NSArray alloc]init];
    
    Xpostion=12;
    Ypostion=16;
    Xwidth=72;
    Yheight=72;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=87;
    Xwidth_label=72;
    Yheight_label=22;
    
    transparancyTuchView=[[UIView alloc]initWithFrame:CGRectMake(0, HeadTopView.frame.size.height+44, self.view.frame.size.width,self.view.frame.size.height-HeadTopView.frame.size.height-44)];
    transparancyTuchView.backgroundColor=[UIColor whiteColor];
    [transparancyTuchView setAlpha:0.5];
    [self.view addSubview:transparancyTuchView];
    transparancyTuchView.hidden=YES;
     UITapGestureRecognizer * ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(ViewTap51Tapped:)];
    [transparancyTuchView addGestureRecognizer:ViewTap51];
    
    UIColor *bgRefreshColor = [UIColor whiteColor];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = Table_Friend.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [Table_Friend insertSubview:bgView atIndex:0];
    self.refreshControl = self.refreshControl;
    
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(PulltoRefershtable)
                  forControlEvents:UIControlEventValueChanged];
    
   // [Table_Friend addSubview:self.refreshControl];
    
    if ( [[defaults valueForKey:@"tapindex"] isEqualToString:@"yes"])
    {
        [defaults setObject:@"no" forKey:@"tapindex"];
        [defaults synchronize];
        Button_Join.hidden=NO;
        Button_JoinImage.hidden=NO;
        
        Button_Help.hidden = YES;
        
        [Button_Create setTitle:@"CREATE" forState:UIControlStateNormal];
        Button_Plustap.tag=2;
        Button_Create.tag=2;
        Str_ChangeScreen=@"playdate";
        Label_HeadTop.text=@"Play:Date";
        [Button_chats setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [Button_playdates setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
//        borderBottom_playdate.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
        
        if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
        {
            
            
            
            borderBottom_playdate.backgroundColor =[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1].CGColor;
        }
        else
        {
            
            
            borderBottom_playdate.backgroundColor =[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1].CGColor;
        }
        
        borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-2.5, Button_playdates.frame.size.width, 2.5);
        [Button_playdates.layer addSublayer:borderBottom_playdate];
        
        
        
        borderBottom_chat.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
        borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-1, Button_chats.frame.size.width, 1);
        [Button_chats.layer addSublayer:borderBottom_chat];
       
    }
    else
    {
        Button_Plustap.tag=1;
        Button_Create.tag=1;
        Str_ChangeScreen=@"chats";
        Label_HeadTop.text=@"Friends";
         Button_Join.hidden=YES;
        Button_JoinImage.hidden=YES;
        
        Button_Help.hidden = NO;
         [Button_Create setTitle:@"ADD" forState:UIControlStateNormal];
        [Button_chats setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        [Button_playdates setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
        {
           
            
          
             borderBottom_chat.backgroundColor =[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1].CGColor;
        }
        else
        {
           
            
            borderBottom_chat.backgroundColor =[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1].CGColor;
        }

        
        
        
       
        borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-2.5, Button_chats.frame.size.width, 2.5);
        [Button_chats.layer addSublayer:borderBottom_chat];
        
        borderBottom_playdate.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
        borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-1, Button_playdates.frame.size.width, 1);
        [Button_playdates.layer addSublayer:borderBottom_playdate];
        
        [self NewMatchServerComm];
        [Table_Friend reloadData];
    }
       [self communication_Eventsmeetups];
    // [self NewMatchServerComm];
    
    
//     HomechatTimer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(NewMatchServerComm) userInfo:nil  repeats:YES];
  
   //  [self homeTimer];
    
    
    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * pathhelp = [documnetPath1 stringByAppendingPathComponent:@"HelpPopup.plist"];
    
    NSString * bundlePath = [[NSBundle mainBundle]pathForResource:@"HelpPopup" ofType:@"plist"];

    
    if([[NSFileManager defaultManager]fileExistsAtPath:pathhelp])
    {
        NSLog(@"File alredy exists");
    }
    else
    {
//        [[NSFileManager defaultManager]copyItemAtPath:bundlePath toPath:pathhelp error:nil]; //mohitcomment
        controllerpop = [[HelpPopViewController alloc] initWithNibName:@"HelpPopViewController"  bundle:nil];
        [controllerpop.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [controllerpop.Button_tour addTarget:self action:@selector(buttonTappedpop:) forControlEvents:UIControlEventTouchUpInside];
        [controllerpop.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9]];
        //        controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view  addSubview:controllerpop.view];
    }
//    controllerpop = [[HelpPopViewController alloc] initWithNibName:@"HelpPopViewController"  bundle:nil];
//    [controllerpop.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [controllerpop.Button_tour addTarget:self action:@selector(buttonTappedpop:) forControlEvents:UIControlEventTouchUpInside];
//    [controllerpop.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1]];
//    //        controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view  addSubview:controllerpop.view];


     NSLog(@"dictionary1_Array_Comment1:=%@",Array_Comment1 );
    
    
    
}
- (void)Refresh_UpdatedBudge
{
    if ( [[defaults valueForKey:@"budgechat"]isEqualToString:@"0"] )
    {
        
        _ImageMessageread_Button_chat.hidden=YES;
       
        
    }
    else
    {
        _ImageMessageread_Button_chat.hidden=NO;
       
    }
    if ( [[defaults valueForKey:@"budgeplaydate"]isEqualToString:@"0"] )
    {
      
        _ImageMessageread_Button_playdates.hidden=YES;
        
    }
    else
    {
     
        _ImageMessageread_Button_playdates.hidden=NO;
    }
    
}
//- (void) viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    CALayer *borderBottom = [CALayer layer];
//    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
//    
//    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
//    [HeadTopView.layer addSublayer:borderBottom];
////    borderBottom_chat.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
////    borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-2.5, Button_chats.frame.size.width, 2.5);
////    [Button_chats.layer addSublayer:borderBottom_chat];
////    
////    
////    
////    
////    
////    
////    borderBottom_playdate.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
////    borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-1, Button_playdates.frame.size.width, 1);
////    [Button_playdates.layer addSublayer:borderBottom_playdate];
//
//}
-(void)homeTimer
{
    
    
    HomechatTimer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(NewMatchServerComm) userInfo:nil  repeats:YES];
    

}
-(void)homeTimerPlaydate
{
    
    
    HomechatTimerplaydate =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(communication_Eventsmeetups) userInfo:nil  repeats:YES];
    
    
}

- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}
-(void)calculate
{
   
   
//    UIAlertView * alt=[[UIAlertView alloc]initWithTitle:@"dasdd" message:@"fdsdss" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
//    [alt show];

    
}
-(void)PulltoRefershtable
{

    
}




- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
     [self an_unsubscribeKeyboard];
    [HomechatTimer invalidate];
      HomechatTimer=nil;
    
        [HomechatTimerplaydate invalidate];
        HomechatTimerplaydate=nil;
        [Table_Friend reloadData];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
        [self communication_Eventsmeetups];
        [self homeTimerPlaydate];
   
        [self NewMatchServerComm];
        [self homeTimer];
       
        
    
    Xpostion=12;
    Ypostion=16;
    Xwidth=72;
    Yheight=72;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=87;
    Xwidth_label=72;
    Yheight_label=22;
    transparancyTuchView.hidden=YES;
    searchbar.text=@"";
    FlagSearchBar=@"no";
      [self subscribeToKeyboard];
    [Table_Friend reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)subscribeToKeyboard
{
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing)
        {
            
            [Table_Friend setFrame:CGRectMake(0, Table_Friend.frame.origin.y, self.view.frame.size.width, (tableview_height-keyboardRect.size.height)+20)];
            
            
        } else
        {
            
            [Table_Friend setFrame:CGRectMake(0, Table_Friend.frame.origin.y, self.view.frame.size.width, tableview_height-45)];
        }
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
        if (section==0)
        {
            return 0;
        }
        if (section==1)
        {
            return 1;
        }
        if (section==2)
        {
            return 1;
        }
        if (section==3)
        {
            return Array_Messages.count;
        }
    }
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        
        if (section==0)
        {
            return 0;
        }
        if (section==1)
        {
            return 0;
        }
       
        if (section==2)
        {
            if ( Array_Meetups.count==0)
            {
                return 0;
            }
            else
            {
               return Array_Meetups.count;
            }
           
        }
        
    }
    
   
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    if (indexPath.section==0)
    {
        return 0;
    }
    
    if (indexPath.section==1)
    {
        if (Array_Request.count==0)
        {
            return 0;
        }
        else
        {
            return 138;
        }
        
        
    }
    if (indexPath.section==2)
    {
        if (Array_Match.count==0)
        {
            return 0;
        }
        else
        {
            return 138;
        }
        
        
    }

    if (indexPath.section==3)
    {
        
        if (Array_Messages.count==0)
        {
            return 0;
        }
        else
        {
            return 98;
        }
        
        
    }
    }
    
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        if (indexPath.section==0)
        {
            return 0;
        }
        
        if (indexPath.section==1)
        {
//            if (Array_Match.count==0)
//            {
                return 0;
//            }
//            else
//            {
//                return 138;
//            }
//            
            
        }
        
        if (indexPath.section==2)
        {
            
            if (Array_Meetups.count==0)
            {
                return 0;
            }
            else
            {
                return 98;
            }
            
            
        }
    }
    return 0;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"CellOne";
    
    
    static NSString *cellId2=@"CellTwo";
static NSString * Cellid111=@"Cellmeet";
    
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    switch (indexPath.section)
    {
         
        case 0:
        {
            return 0;
        }
           break;
        case 1:
        {
            
            Cell_One = (FriendsSeconeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
            
            for(UIImageView* view in Cell_One.myscrollView.subviews)
            {
                
                [view removeFromSuperview];
                
            }
            
            
            
            
            CALayer *borderBottomViewTap6 = [CALayer layer];
            borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
            borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
            [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
            
            for (int i=0; i<Array_Request.count; i++)
            {
                
                UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                
                
                Imagepro.userInteractionEnabled=YES;
                
                [Imagepro setTag:i];
                
                
                UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(ImageTapped_profile1:)];
                [Imagepro addGestureRecognizer:ImageTap];
                
                
                Imagepro.clipsToBounds=YES;
                Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                [Imagepro setBackgroundColor:[UIColor clearColor]];
                Label_name.backgroundColor=[UIColor clearColor];
                Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                
                Label_name.text=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                

                
                
                Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                Label_name.numberOfLines = 1;
                Label_name.adjustsFontSizeToFitWidth=YES;
                Label_name.minimumScaleFactor=0.5;
                //                Label_name.baselineAdjustment = YES;
                //                Label_name.adjustsFontSizeToFitWidth = YES;
                //                Label_name.adjustsLetterSpacingToFitWidth = YES;
                
                Label_name.textAlignment=NSTextAlignmentCenter;
                
//----------------------------------latest edit 1 apr ---------------------------------------------------
                
                NSString *textfname=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                
                if (searchString.length==0)
                    
                {
                    
                    Label_name.text=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    
                }
                
                else
                    
                {
                    
                   
                    
                    
                    NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                    
                    
                    NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    
                    
                    NSRange rangefname = NSMakeRange(0 ,textfname.length);
                    
                    
                    [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    if ([FlagSearchBar isEqualToString:@"yes"])
                    {
                        
                        Label_name.attributedText=mutableAttributedStringfname;
                    }
                    else
                    {
                        
                        Label_name.text=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                        
                        FlagSearchBar=@"no";
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                
//-------------------------------------------------------------------------------------------------------------
                
                
                
                
                [Cell_One.myscrollView addSubview:Label_name];
                [Cell_One.myscrollView addSubview:Imagepro];
                
                
                
                NSURL * url=[[Array_Request objectAtIndex:i]valueForKey:@"profilepic"];
                
                if ([[[Array_Request objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    
                    
                    [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                    
                }
                else
                {
                    [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]options:SDWebImageRefreshCached];
                }
                
                
                
                Xpostion+=Xwidth+20;
                //Xpostion_label+=Xwidth_label+12;
                
                ScrollContentSize+=Xwidth;
                Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 125);
            }
            
            
            
            Xpostion=12;
            Ypostion=16;
            Xwidth=72;
            Yheight=72;
            ScrollContentSize=0;
            Xpostion_label=12;
            Ypostion_label=87;
            Xwidth_label=72;
            Yheight_label=22;
            if (Array_Request.count==0)
            {
                Cell_One.Label_Noresult.hidden=NO;
            }
            else
            {
                Cell_One.Label_Noresult.hidden=YES;
            }
            return Cell_One;
            
            
        }
            break;
//---------------------------------------------------Match Cell --------------------------------------------------------------
            
        case 2:
        {
            
            Cell_One = (FriendsSeconeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
            
            for(UIImageView* view in Cell_One.myscrollView.subviews)
            {
                
                [view removeFromSuperview];
                
            }
            
            
            
            
            CALayer *borderBottomViewTap6 = [CALayer layer];
            borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
            borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
            [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
            
            for (int i=0; i<Array_Match.count; i++)
            {
                
                UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                
                
                Imagepro.userInteractionEnabled=YES;
                
                [Imagepro setTag:i];
                
                
                UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(ImageTapped_profile:)];
                [Imagepro addGestureRecognizer:ImageTap];
                
                
                Imagepro.clipsToBounds=YES;
                Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                [Imagepro setBackgroundColor:[UIColor clearColor]];
                Label_name.backgroundColor=[UIColor clearColor];
                Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                
                Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                
                
                
                
                Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                Label_name.numberOfLines = 1;
                Label_name.adjustsFontSizeToFitWidth=YES;
                Label_name.minimumScaleFactor=0.5;
                //                Label_name.baselineAdjustment = YES;
                //                Label_name.adjustsFontSizeToFitWidth = YES;
                //                Label_name.adjustsLetterSpacingToFitWidth = YES;
                
                Label_name.textAlignment=NSTextAlignmentCenter;
                
                //----------------------------------latest edit 1 apr ---------------------------------------------------
                
                NSString *textfname=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                
                if (searchString.length==0)
                    
                {
                    
                    Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    
                }
                
                else
                    
                {
                    
                   
                    
                    
                    NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                    
                    
                    NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    
                    
                    NSRange rangefname = NSMakeRange(0 ,textfname.length);
                    
                    
                    [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    if ([FlagSearchBar isEqualToString:@"yes"])
                    {
                        
                        Label_name.attributedText=mutableAttributedStringfname;
                    }
                    else
                    {
                        
                        Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                        
                        FlagSearchBar=@"no";
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                
                //-------------------------------------------------------------------------------------------------------------
                
                
                
                
                [Cell_One.myscrollView addSubview:Label_name];
                [Cell_One.myscrollView addSubview:Imagepro];
                
                
                
                NSURL * url=[[Array_Match objectAtIndex:i]valueForKey:@"profilepic"];
                
                if ([[[Array_Match objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    
                    
                    [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                    
                }
                else
                {
                    [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]options:SDWebImageRefreshCached];
                }
                
                
                
                Xpostion+=Xwidth+20;
                //Xpostion_label+=Xwidth_label+12;
                
                ScrollContentSize+=Xwidth;
                Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 125);
            }
            
            
            
            Xpostion=12;
            Ypostion=16;
            Xwidth=72;
            Yheight=72;
            ScrollContentSize=0;
            Xpostion_label=12;
            Ypostion_label=87;
            Xwidth_label=72;
            Yheight_label=22;
            if (Array_Match.count==0)
            {
                Cell_One.Label_Noresult.hidden=NO;
            }
            else
            {
                Cell_One.Label_Noresult.hidden=YES;
            }
            return Cell_One;
            
            
        }
            break;

//-----------------------------------------------end-----------------------------------------------------------------
        case 3://2
            
        {
            Cell_Two = (FriendsSecTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
            NSURL * url=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"profilepic"];
           // Cell_Two.Label_name.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
            // Cell_Two.Label_chatInfo.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"message"];
            
            NSString *text;
            if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
            {
                text =[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"message"];
            }
            else
            {
             text=@"Image";
            }
           
            NSString *textfname=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
            
            if (searchString.length==0)
            {
                
               Cell_Two.Label_name.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
               Cell_Two.Label_chatInfo.text=text;
                Cell_Two.Label_chatInfo.textColor=[UIColor lightGrayColor];
              Cell_Two.Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            }
            else
            {
                
               
                
                NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
                NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                 NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                
                NSRange range = NSMakeRange(0 ,text.length);
                 NSRange rangefname = NSMakeRange(0 ,textfname.length);
              
                [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    
                    NSRange subStringRange = [result rangeAtIndex:0];
                    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                }];
                
                [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    
                    NSRange subStringRange = [result rangeAtIndex:0];
                    [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                }];
                
                if ([FlagSearchBar isEqualToString:@"yes"])
                {
                    Cell_Two.Label_chatInfo.attributedText = mutableAttributedString;
                    Cell_Two.Label_name.attributedText=mutableAttributedStringfname;
                }
                else
                {
                    
                    
                    
                    Cell_Two.Label_name.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
                    Cell_Two.Label_chatInfo.text=text;
                    Cell_Two.Label_chatInfo.textColor=[UIColor lightGrayColor];

                   FlagSearchBar=@"no";
                    
                }
                
                
                
//                   Cell_Two.Label_chatInfo.attributedText = mutableAttributedString;
//                   Cell_Two.Label_name.attributedText=mutableAttributedStringfname;
                
                
            }
            
            
            if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqual:[NSNull null ]] || [[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"gender"] == nil)
                
            {
                [Cell_Two.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
            }
            
            else
                
            {
                if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    [Cell_Two.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
                    
                    
                    
                }
                else
                {
                    [Cell_Two.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"] options:SDWebImageRefreshCached];
                    
                }
            }
            
            
            
            
            Cell_Two.Image_messagered.tag=indexPath.row;
            if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"msgread"]isEqualToString:@"no"])
            {
                Cell_Two.Image_messagered.hidden=NO;
               [Cell_Two.Image_messagered setImage:[UIImage imageNamed:@"SpeechBubble1.png"]];
               
            }
            else
            {
                Cell_Two.Image_messagered.hidden=YES;
                 [Cell_Two.Image_messagered setImage:[UIImage imageNamed:@""]];
//                _ImageMessageread_Button_chat.hidden=YES;
//                [_ImageMessageread_Button_chat setImage:[UIImage imageNamed:@""]];
                
            }
            
                       return Cell_Two;
            
        }
            break;
            
          
    
}
}
    
  if ([Str_ChangeScreen isEqualToString:@"playdate"])
    
    {
        switch (indexPath.section)
        {
                
            case 0:
            {
                return 0;
            }
                break;
            case 1:
            {
                
                Cell_One = (FriendsSeconeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
                
                for(UIImageView* view in Cell_One.myscrollView.subviews)
                {
                    
                    [view removeFromSuperview];
                    
                }
                
                
                
                
                CALayer *borderBottomViewTap6 = [CALayer layer];
                borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
                borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
                [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
                
                for (int i=0; i<Array_Match.count; i++)
                {
                    
                    UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                    UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                    
                    
                    Imagepro.userInteractionEnabled=YES;
                    
                    [Imagepro setTag:i];
                    
                    
                    UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(ImageTapped_profile:)];
                    [Imagepro addGestureRecognizer:ImageTap];
                    
                    
                    Imagepro.clipsToBounds=YES;
                    Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                    [Imagepro setBackgroundColor:[UIColor clearColor]];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                    
                    Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                    
                    
                    
                    
                    Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                    Label_name.numberOfLines = 1;
                    Label_name.adjustsFontSizeToFitWidth=YES;
                    Label_name.minimumScaleFactor=0.5;
                    //                Label_name.baselineAdjustment = YES;
                    //                Label_name.adjustsFontSizeToFitWidth = YES;
                    //                Label_name.adjustsLetterSpacingToFitWidth = YES;
                    
                    Label_name.textAlignment=NSTextAlignmentCenter;
                    
                    //----------------------------------latest edit 1 apr ---------------------------------------------------
                    
                    NSString *textfname=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                    
                    if (searchString.length==0)
                        
                    {
                        
                        Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                        Label_name.backgroundColor=[UIColor clearColor];
                        Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                       Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    }
                    
                    else
                        
                    {
                        
                       
                        
                        
                        NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                        
                        
                        NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                        
                        
                        NSRange rangefname = NSMakeRange(0 ,textfname.length);
                        
                        
                        [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                            
                            NSRange subStringRange = [result rangeAtIndex:0];
                            [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                        }];
                        
                        if ([FlagSearchBar isEqualToString:@"yes"])
                        {
                            
                            Label_name.attributedText=mutableAttributedStringfname;
                        }
                        else
                        {
                            
                            Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                            
                            FlagSearchBar=@"no";
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    //-------------------------------------------------------------------------------------------------------------
                    
                    
                    
                    
                    [Cell_One.myscrollView addSubview:Label_name];
                    [Cell_One.myscrollView addSubview:Imagepro];
                    
                    
                    
                    NSURL * url=[[Array_Match objectAtIndex:i]valueForKey:@"profilepic"];
                    
                    if ([[[Array_Match objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
                    {
                        
                        
                        
                        [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                        
                    }
                    else
                    {
                        [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]options:SDWebImageRefreshCached];
                    }
                    
                    
                    
                    Xpostion+=Xwidth+20;
                    //Xpostion_label+=Xwidth_label+12;
                    
                    ScrollContentSize+=Xwidth;
                    Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 125);
                }
                
                
                
                Xpostion=12;
                Ypostion=16;
                Xwidth=72;
                Yheight=72;
                ScrollContentSize=0;
                Xpostion_label=12;
                Ypostion_label=87;
                Xwidth_label=72;
                Yheight_label=22;
                if (Array_Match.count==0)
                {
                    Cell_One.Label_Noresult.hidden=NO;
                }
                else
                {
                    Cell_One.Label_Noresult.hidden=YES;
                }
                
                
                
                
                
                
                return Cell_One;
                
                
            }
                break;
              
               
            case 2:
                
            {
                
                
//                chattype = EVENT;
//                createdate = "2017-06-16 11:44:33";
//                creatorfbid = 1224819434269672;
//                eventdate =     {
//                    date = "2017-06-18 13:45:22.000000";
//                    timezone = UTC;
//                    "timezone_type" = 3;
//                };
//                eventdateformat = "18th June 2017, 1:45pm";
//                eventdescription = Nznznznnz;
//                eventid = QYLL0;
//                eventtitle = Nznznzn;
//                fname = test;
//                gender = Boy;
//                invitedate = "2017-06-16 11:44:33";
//                location = "M M Mmz";
//                message = Nznznzn;
//                msgdate = "2017-06-16 11:44:33";
//                msgread = self;
                
   
                
                
                Cell_Two2 = (MymeetupsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid111 forIndexPath:indexPath];
                NSURL * url=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"profilepic"];
           
                
                NSString *text;
                if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
                {
                    text =[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"message"];
                }
                else if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"chattype"] isEqualToString:@"EVENT"])
                {
                    text =@"";
                }
                else
                {
                    text=@"Image";
                }
                
                NSString *textfname=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventtitle"];
                
                Cell_Two2.Label_Date.text=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventdateformat"];
                
                
                if (searchString.length==0)
                {
                    
                    Cell_Two2.Label_name.text=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventtitle"];
                    Cell_Two2.Label_chatInfo.text=text;
                    Cell_Two2.Label_chatInfo.textColor=[UIColor lightGrayColor];
                    Cell_Two.Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                }
                else
                {
                    
                    
                    
                    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
                    NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                    
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    
                    NSRange range = NSMakeRange(0 ,text.length);
                    NSRange rangefname = NSMakeRange(0 ,textfname.length);
                    
                    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    if ([FlagSearchBar isEqualToString:@"yes"])
                    {
                        Cell_Two2.Label_chatInfo.attributedText = mutableAttributedString;
                        Cell_Two2.Label_name.attributedText=mutableAttributedStringfname;
                    }
                    else
                    {
                        
                        
                        
                        Cell_Two2.Label_name.text=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventtitle"];
                        Cell_Two2.Label_chatInfo.text=text;
                        Cell_Two2.Label_chatInfo.textColor=[UIColor lightGrayColor];
                         Cell_Two.Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                        FlagSearchBar=@"no";
                        
                    }
                    
                    
                    
                    //                   Cell_Two.Label_chatInfo.attributedText = mutableAttributedString;
                    //                   Cell_Two.Label_name.attributedText=mutableAttributedStringfname;
                    
                    
                }
                
                
                if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqual:[NSNull null ]] || [[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"gender"] == nil)
                    
                {
                    [Cell_Two2.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
                }
                
                else
                    
                {
                    if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqualToString:@"Boy"])
                    {
                        
                        [Cell_Two2.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
                        
                        
                        
                    }
                    else
                    {
                        [Cell_Two2.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"] options:SDWebImageRefreshCached];
                        
                    }
                }
                
                
                Cell_Two2.Image_messagered.tag=indexPath.row;
                if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"msgread"]isEqualToString:@"no"])
                {
                    Cell_Two2.Image_messagered.hidden=NO;
                    [Cell_Two2.Image_messagered setImage:[UIImage imageNamed:@"SpeechBubble1.png"]];
                    
                  
                }
                else
                {
                    Cell_Two2.Image_messagered.hidden=YES;
                    [Cell_Two2.Image_messagered setImage:[UIImage imageNamed:@""]];
                    

                    
                }
                
              
                
                return Cell_Two2;
                
            }
                break;
                
                
                
        }
    }
    
     return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    return 4;
    }
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
         return 3;
    }
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        //        [sectionView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionView.frame.size.height)];
        searchbar.translucent=YES;
        searchbar.delegate=self;
        searchbar.searchBarStyle=UISearchBarStyleMinimal;

        [searchbar setShowsCancelButton:NO animated:YES];
        [self searchBarCancelButtonClicked:searchbar];
        
        
//        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 2)],UITextAttributeTextShadowOffset,nil]forState:UIControlStateNormal];
        
       [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9], NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:16]} forState:UIControlStateNormal];
        

        
        [searchbar setTintColor:[UIColor lightGrayColor]];
//
        [sectionView addSubview:searchbar];
        sectionView.tag=section;
        
    }
  
    if (section==1)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor whiteColor]]; //[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        Label1.text=@"Friend Requests";
        
        
        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(150,6,24,24)];
        Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
        Label2.clipsToBounds=YES;
        Label2.layer.cornerRadius=Label2.frame.size.height/2;
        Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Request.count];
        Label2.textAlignment=NSTextAlignmentCenter;
        [sectionView addSubview:Label2];
       
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }

   
    
    if (section==2)//1
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor whiteColor]]; //[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        Label1.text=@"New matches";
        
        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(130,6,24,24)];
        Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
        Label2.clipsToBounds=YES;
        Label2.layer.cornerRadius=Label2.frame.size.height/2;
        Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Match.count];
        Label2.textAlignment=NSTextAlignmentCenter;
        [sectionView addSubview:Label2];
        
        
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }

    if (section==3)//2
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];//[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];

        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        Label1.text=@"Messages";
        
        [sectionView addSubview:Label1];
        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(105,6,24,24)];
        Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
        Label2.clipsToBounds=YES;
        Label2.layer.cornerRadius=Label2.frame.size.height/2;
        Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Messages.count];
        Label2.textAlignment=NSTextAlignmentCenter;
        
#pragma mark - message count hidden
        
        Label2.hidden = YES;
        
        [sectionView addSubview:Label2];
        
        sectionView.tag=section;
        
    }
    
    
    return  sectionView;
    
}
    
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        if (section==0)
        {
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
            //        [sectionView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
            [sectionView setBackgroundColor:[UIColor whiteColor]];
            searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionView.frame.size.height)];
            searchbar.translucent=YES;
            searchbar.delegate=self;
            searchbar.searchBarStyle=UISearchBarStyleMinimal;
            
            [searchbar setShowsCancelButton:NO animated:YES];
            [self searchBarCancelButtonClicked:searchbar];
            
            
            //        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 2)],UITextAttributeTextShadowOffset,nil]forState:UIControlStateNormal];
            
            [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9], NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:16]} forState:UIControlStateNormal];
            
            
            
            [searchbar setTintColor:[UIColor lightGrayColor]];
            //
            [sectionView addSubview:searchbar];
            sectionView.tag=section;
            
        }
        
        if (section==1)
        {
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
            [sectionView setBackgroundColor:[UIColor whiteColor]]; //[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
            UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
            Label1.backgroundColor=[UIColor clearColor];
            Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            Label1.text=@"New Invites";
            
            UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(130,6,24,24)];
            Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
            Label2.clipsToBounds=YES;
            Label2.layer.cornerRadius=Label2.frame.size.height/2;
            Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
            Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Match.count];
            Label2.textAlignment=NSTextAlignmentCenter;
            [sectionView addSubview:Label2];
            
            
            [sectionView addSubview:Label1];
            sectionView.tag=section;
            
        }
        
        if (section==2)
        {
            
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
            [sectionView setBackgroundColor:[UIColor whiteColor]];//[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
            
            
            UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
            Label1.backgroundColor=[UIColor clearColor];
            Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            Label1.text=@"My Meetups";
            
            [sectionView addSubview:Label1];
            UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(105,6,24,24)];
            Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
            Label2.clipsToBounds=YES;
            Label2.layer.cornerRadius=Label2.frame.size.height/2;
            Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
            Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Messages.count];
            Label2.textAlignment=NSTextAlignmentCenter;
            
#pragma mark - message count hidden
            
            Label2.hidden = YES;
            
            [sectionView addSubview:Label2];
            
            sectionView.tag=section;
            
        }
        
        return  sectionView;
        
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    if (section==0)
    {
        return 44;
    }

    if (section==1)
    {
        if (Array_Request.count==0)
        {
            return 0;
        }
        else
        {
            return 36;
        }
    }

    

    
    
    
    if (section==2)//1
    {
        if (Array_Match.count==0)
        {
            return 0;
        }
        else
        {
            return 36;
        }
    }
    if (section==3)//2
    {
        if (Array_Messages.count==0)
        {
            return 0;
        }
        else
        {
            return 36;
        }
      
    }
    }
     if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        if (section==0)
        {
            return 44;
        }
        
        if (section==1)
        {
//            if (Array_Match.count==0)
//            {
                return 0;
//            }
//            else
//            {
//                return 36;
//            }
        }
        
        
        if (section==2)
        {
            if (Array_Meetups.count==0)
            {
                return 0;
            }
            else
            {
                return 36;
            }
            
        }
    }
    
    
    return 0;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    [self.view endEditing:YES];

    transparancyTuchView.hidden=YES;
  
    
    if (indexPath.section==3)//2
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        FriendCahtingViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewController"];
        if (indexPath.section==0)
        {
//            set.AllDataArray=[Array_MatchMessages objectAtIndex:indexPath.row];
        }
        if (indexPath.section==3)
        {
            NSDictionary * dic=[Array_Messages objectAtIndex:indexPath.row];
            NSMutableArray * array_new=[[NSMutableArray alloc]init];
            [array_new addObject:dic];
            set.AllDataArray=array_new;
        }

        [self.navigationController pushViewController:set animated:YES];
    }
    }
     if ([Str_ChangeScreen isEqualToString:@"playdate"])
     {
         [self.view endEditing:YES];
         
         transparancyTuchView.hidden=YES;
         
         
         if (indexPath.section==2)//2
         {
             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             
             FriendCahtingViewControlleroneViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewControlleroneViewController"];
             if (indexPath.section==0)
             {
               
             }
             if (indexPath.section==2)
             {
                 NSDictionary * dic=[Array_Meetups objectAtIndex:indexPath.row];
                 NSMutableArray * array_new=[[NSMutableArray alloc]init];
                 [array_new addObject:dic];
                 set.AllDataArray=array_new;
             }
             
             [self.navigationController pushViewController:set animated:YES];
         }
     }
}


-(void)ImageTapped_profile1:(UITapGestureRecognizer *)sender
{
    
    
    [self.view endEditing:YES];
    transparancyTuchView.hidden=YES;
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FriendRequestViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendRequestViewController"];
    
    NSDictionary * dic=[Array_Request objectAtIndex:(long)imageView.tag];
    NSMutableArray * array_new=[[NSMutableArray alloc]init];
    [array_new addObject:dic];
    set.Array_UserInfo=array_new;
    
    [self.navigationController pushViewController:set animated:YES];
}


-(void)ImageTapped_profile:(UITapGestureRecognizer *)sender
{
    
    
    [self.view endEditing:YES];
      transparancyTuchView.hidden=YES;
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FriendCahtingViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewController"];
    
    NSDictionary * dic=[Array_Match objectAtIndex:(long)imageView.tag];
    NSMutableArray * array_new=[[NSMutableArray alloc]init];
    [array_new addObject:dic];
    set.AllDataArray=array_new;
    
    [self.navigationController pushViewController:set animated:YES];
}
-(void)communication_Eventsmeetups
{
    
    
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        //        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        message.tag=100;
        //        [message show];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
    
    NSString *fbid1= @"fbid";
    NSString *fbid1Val=[defaults valueForKey:@"fid"];
    
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",fbid1,fbid1Val];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"events"];;
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
                                                 
                array_createEvent=[[NSMutableArray alloc]init];
             Array_Meetups=[[NSMutableArray alloc]init];
            Array_Meetups1=[[NSArray alloc]init];

                SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        array_createEvent=[objSBJsonParser objectWithData:data];
            NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 ;
                                                 
            ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                    NSLog(@"array_createEvent %@",array_createEvent);
                                                 
                NSLog(@"array_createEvent ResultString %@",ResultString);
                                    if ([ResultString isEqualToString:@"inserterror"])
                                                 {
                              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The server encountered an error and your Play:Date could not be created. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                              UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                     [alertController   addAction:actionOk];
                            [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                            if (array_createEvent.count !=0)
                            {
                                for (int i=0; i<array_createEvent.count; i++)
                                {
                                if (Array_Meetups.count==0)
                                {
                            [Array_Meetups addObject:[array_createEvent objectAtIndex:i]];
                                }
                                else
                            {
                                                         
                                    for (NSInteger J=Array_Meetups.count-1; J<Array_Meetups.count; J++)
                            {
                        NSString * fbMatch=[[array_createEvent objectAtIndex:i]valueForKey:@"eventid"];
                            NSString * fbMatch2=[[Array_Meetups objectAtIndex:J]valueForKey:@"eventid"];
                                                             
                                    if (![fbMatch2 isEqualToString:fbMatch])
                                                             {
                                                                 
                            [Array_Meetups addObject:[array_createEvent objectAtIndex:i]];
                                                                 break;
                                                             }
                                                             
                                                         }
                                                     }
                                                 }
                                
                                  Array_Meetups1=[Array_Meetups mutableCopy];
                                [Table_Friend reloadData];
                            }
                                             }
                                             
                                             else
                                             {
                                                 NSLog(@" error login1 ---%ld",(long)statusCode);
                                                
                                                 
                                             }
                                             
                                             
                                         }
                                         else if(error)
                                         {
 
                                             NSLog(@"error login2.......%@",error.description);
                                         }
                                         
                                         
                                     }];
    [dataTask resume];
    }
}



-(void)NewMatchServerComm
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        message.tag=100;
//        [message show];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        NSURL *url;
        
        NSString *  urlStrLivecount=[urlplist valueForKey:@"friends"];
        
 //       NSString *  urlStrLivecount=[urlplist valueForKey:@"friends-new"];
        
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defaults valueForKey:@"fid"];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",fbid1,fbid1Val];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        [request setHTTPBody: requestData];
        
        Connection_Match = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_Match)
            {
                webData_Match =[[NSMutableData alloc]init];
                
                
            }
            else
            {
                NSLog(@"theConnection is NULL");
            }
        }
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSLog(@"connnnnnnnnnnnnnn=%@",connection);
    
    if(connection==Connection_Match)
    {
        [webData_Match setLength:0];
        
        
    }
    
    
    if(connection==Connection_Messages)
    {
        [webData_Messages setLength:0];
        
        
    }
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_Match)
    {
        [webData_Match appendData:data];
    }
    if(connection==Connection_Messages)
    {
        [webData_Messages appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //  [indicatorView stopAnimating];
    
    if (connection==Connection_Match)
    {
        Array_Request = [[NSMutableArray alloc]init];
        Array_RequestMessages = [[NSMutableArray alloc]init];
        
        Array_MatchMessages=[[NSMutableArray alloc]init];
        Array_Match=[[NSMutableArray alloc]init];
        Array_Messages=[[NSMutableArray alloc]init];
        Array_Messages22=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_MatchMessages=[objSBJsonParser objectWithData:webData_Match];
        Array_RequestMessages = [objSBJsonParser objectWithData:webData_Match];
        NSMutableDictionary * dicone=[[NSMutableDictionary alloc]init];
        dicone=[objSBJsonParser objectWithData:webData_Match];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Match encoding:NSUTF8StringEncoding];
        //  Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_LodingPro options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"_Array_Match %@",Array_MatchMessages);
        NSLog(@"_Array_Request %@",Array_RequestMessages);
      
        NSLog(@"ResultString_Array_Match %@",ResultString);
        if ([ResultString isEqualToString:@"error"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Fid Id not exist" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
        }
        if (Array_MatchMessages.count !=0)
        {
            
            
            
            NSError *error;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            //
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText1.plist"];
            
          
            
            
                    [dicone writeToFile:path atomically:YES];
            
            
            
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            
            
            
            
            
for (int i=0; i<Array_MatchMessages.count; i++)
    {
  if ([[[Array_MatchMessages objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
  {
    
                    if (Array_Match.count==0)
                    {
                        [Array_Match addObject:[Array_MatchMessages objectAtIndex:i]];
                    }
                    else
                    {
        
                        for (NSInteger k=Array_Match.count-1; k<Array_Match.count; k++)
                        {
                            NSString * fbMatch11=[[Array_MatchMessages objectAtIndex:i]valueForKey:@"matchedfbid"];
                            NSString * fbMatch22=[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"];
                            
                            if (![fbMatch22 isEqualToString:fbMatch11])
                            {
                                
                                [Array_Match addObject:[Array_MatchMessages objectAtIndex:i]];
                                break;
                            }
                            
                        }
                }
    }
        
        
        
        else if ([[[Array_MatchMessages objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"request"])
        {
            if (Array_Request.count==0)
            {
                [Array_Request addObject:[Array_RequestMessages objectAtIndex:i]];
            }
            else
            {
                
                for (NSInteger k=Array_Request.count-1; k<Array_Request.count; k++)
                {
                    NSString * fbMatch11=[[Array_RequestMessages objectAtIndex:i]valueForKey:@"matchedfbid"];
                    NSString * fbMatch22=[[Array_Request objectAtIndex:k]valueForKey:@"matchedfbid"];
                    
                    if (![fbMatch22 isEqualToString:fbMatch11])
                    {
                        
                        [Array_Request addObject:[Array_RequestMessages objectAtIndex:i]];
                        break;
                    }
                    
                }
            }

            
            
        }
        
   else
        {
            if (Array_Messages.count==0)
                {
                        [Array_Messages addObject:[Array_MatchMessages objectAtIndex:i]];
                }
                else
                {
                
                  for (NSInteger J=Array_Messages.count-1; J<Array_Messages.count; J++)
                    {
                    NSString * fbMatch=[[Array_MatchMessages objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch2=[[Array_Messages objectAtIndex:J]valueForKey:@"matchedfbid"];
                            
                   if (![fbMatch2 isEqualToString:fbMatch])
                   {
                   
                      [Array_Messages addObject:[Array_MatchMessages objectAtIndex:i]];
                       break;
                    }
                        
                        }
                    }
            
                }
            }
            
           
       SearchCrickArray=[Array_MatchMessages mutableCopy];
          Array_Messages1=[Array_Messages mutableCopy];
            Array_Match1=[Array_Match mutableCopy];
            Array_Request1 = [Array_Request mutableCopy];
            [Table_Friend reloadData];
            
        }
        
}
    
    
    if (connection==Connection_Messages)
    {
        
        Array_Messages=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Messages=[objSBJsonParser objectWithData:webData_Messages];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Messages encoding:NSUTF8StringEncoding];
        // Array_sinupFb=[NSJSONSerialization JSONObjectWithData:webData_Reg options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_Messages %@",Array_Messages);
        NSLog(@"Array_Messages %@",[[Array_Messages objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"ResultString_Array_Messages %@",ResultString);
        
        if ([ResultString isEqualToString:@"error"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else if ([ResultString isEqualToString:@"updateerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error in updating your account. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in updating your account. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
            
        }
        else if ([ResultString isEqualToString:@"error"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else if ([ResultString isEqualToString:@"selecterror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
        }
        else if ((Array_Messages.count !=0))
        {
            
              }
    
    
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   

     transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
        [HomechatTimer invalidate];
        HomechatTimer=nil;
    }
    
    
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
 
    [HomechatTimerplaydate invalidate];
    HomechatTimerplaydate=nil;
    }

    FlagSearchBar=@"yes";
    transparancyTuchView.hidden=NO;
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    transparancyTuchView.hidden=YES;
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
    FlagSearchBar=@"yes";
    
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    
    if (searchText.length==0)
    {
        searchString=@"";
        transparancyTuchView.hidden=NO;
        [Array_Match removeAllObjects];
        [Array_Request removeAllObjects];
        [Array_Messages removeAllObjects];
        [Array_Messages22 removeAllObjects];
        [Array_Messages addObjectsFromArray:Array_Messages1];
        [Array_Match addObjectsFromArray:Array_Match1];
        [Array_Request addObjectsFromArray:Array_Request1];
        [Array_Messages22 addObjectsFromArray:SearchCrickArray];

        
    }
    else
        
    {
      transparancyTuchView.hidden=YES;
     
        [Array_Messages removeAllObjects];
        [Array_Match removeAllObjects];
        [Array_Request removeAllObjects];
        [Array_Messages22 removeAllObjects];
        
        for (NSDictionary *book in SearchCrickArray)
        {
            NSString * string=[book objectForKey:@"fname"];
            NSString * stringcom=[book objectForKey:@"message"];
            NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange rcompetition=[stringcom rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location !=NSNotFound || rcompetition.location !=NSNotFound)
            {
                searchString=searchText;
                [Array_Messages22 addObject:book];
                
            }
            
        }
        
        
       
        for (int i=0; i<Array_Messages22.count; i++)
        {
            if ([[[Array_Messages22 objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
            {
                
                if (Array_Match.count==0)
                {
                    [Array_Match addObject:[Array_Messages22 objectAtIndex:i]];
                }
                else
                {
                    for (int k=0; k<Array_Match.count; k++)
                    {
                        if (![[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"] isEqualToString:[[Array_Messages22 objectAtIndex:i]valueForKey:@"matchedfbid"]])
                        {
                            
                            [Array_Match addObject:[Array_Messages22 objectAtIndex:i]];
                            
                        }
                        
                        
                    }
                    
                    
                }
            }
            
          else if ([[[Array_Messages22 objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"request"])
            {
                
                if (Array_Request.count==0)
                {
                    [Array_Request addObject:[Array_Messages22 objectAtIndex:i]];
                }
                else
                {
                    for (int k=0; k<Array_Request.count; k++)
                    {
                        if (![[[Array_Request objectAtIndex:k]valueForKey:@"matchedfbid"] isEqualToString:[[Array_Messages22 objectAtIndex:i]valueForKey:@"matchedfbid"]])
                        {
                            
                            [Array_Request addObject:[Array_Messages22 objectAtIndex:i]];
                            
                        }
                        
                        
                    }
                    
                    
                }
            }
            
            else
            {
                if (Array_Messages.count==0)
                {
                    [Array_Messages addObject:[Array_Messages22 objectAtIndex:i]];
                }
                else
                {
                    
                    for (NSInteger J=Array_Messages.count-1; J<Array_Messages.count; J++)
                    {
                        NSString * fbMatch=[[Array_Messages22 objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch2=[[Array_Messages objectAtIndex:J]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch2 isEqualToString:fbMatch])
                        {
                            
                            [Array_Messages addObject:[Array_Messages22 objectAtIndex:i]];
                            break;
                        }
                        
                    }
                }
                
            }
        }
        

        
        
 
    }

    }
    

if ([Str_ChangeScreen isEqualToString:@"playdate"])
{
    
    if (searchText.length==0)
    {
        searchString=@"";
        transparancyTuchView.hidden=NO;
        [Array_Meetups removeAllObjects];
       
        [Array_Meetups addObjectsFromArray:Array_Meetups1];
       
        
        
    }
    else
        
    {
        transparancyTuchView.hidden=YES;
        
        [Array_Meetups removeAllObjects];
       
        
        for (NSDictionary *book in Array_Meetups1)
        {
            NSString * string=[book objectForKey:@"eventtitle"];
            NSString * stringcom=[book objectForKey:@"message"];
            NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange rcompetition=[stringcom rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location !=NSNotFound || rcompetition.location !=NSNotFound)
            {
                searchString=searchText;
                [Array_Meetups addObject:book];
                
            }
            
        }
        
        
        
    }
    
}


     [searchBar setShowsCancelButton:YES animated:YES];
    
    [Table_Friend reloadData];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    
    transparancyTuchView.hidden=YES;
  [self.view endEditing:YES];
    searchBar.text=@"";
    searchString=@"";
     [searchBar setShowsCancelButton:NO animated:YES];
    if ([FlagSearchBar isEqualToString:@"yes"])
    {
            [Array_Match removeAllObjects];
            [Array_Request removeAllObjects];
            [Array_Messages removeAllObjects];
            [Array_Messages22 removeAllObjects];
            [Array_Messages addObjectsFromArray:Array_Messages1];
            [Array_Match addObjectsFromArray:Array_Match1];
            [Array_Request addObjectsFromArray:Array_Request1];
            [Array_Messages22 addObjectsFromArray:SearchCrickArray];
            [Table_Friend reloadData];
          FlagSearchBar=@"no";
        
        [self homeTimer];
    }

}
-(void)updateLabel
{
    [self NewMatchServerComm];
}
-(void)Plus_Action
{
    if (senderTagPlus==1)
    {
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Facebook friends",@"Invite by email address",@"Invite by mobile number",@"Invite contacts",@"Post on Facebook",nil];
        popup.tag = 777;
        [popup showInView:self.view];
    }
    if (senderTagPlus==2)
    {
        NSLog(@"button oplus tag is ==2");
        [defaults setObject:@"newedit" forKey:@"checkview"];
        [defaults synchronize];
        NavigationNewPlayDateViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationNewPlayDateViewController"];
        [self.navigationController presentModalViewController:tvc animated:YES];
    }
 
}
- (IBAction)Button_Plus:(id)sender
{
    senderTagPlus=[sender tag];
    [self Plus_Action];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((long)actionSheet.tag == 777)
    {
        NSLog(@"INDEXAcrtionShhet==%ld",(long)buttonIndex);
        
        if (buttonIndex== 0)
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
            [self.navigationController pushViewController:set animated:YES];
        }
        if (buttonIndex== 1)
        {
           
            
            Str_InviteSelect=@"email";
            placeholder_Alert=@"Enter email address";
            Str_MessageAlert=@"Enter the email address of the user you wish to invite.";
            [self InviteTextfield];
            
        }
        if (buttonIndex== 2)
        {
          
            Str_InviteSelect=@"mobileno";
            placeholder_Alert=@"Enter mobile number";
            Str_MessageAlert=@"Enter the mobile number with country code of the user you wish to invite.";
            
            [self InviteTextfield];
        }
        else  if (buttonIndex== 3)
        {
            
           
            [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ContactListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactListViewController"];
            set.eventidvalue=@"";
            set.invitetype=@"FRIEND";
            [self.navigationController pushViewController:set animated:YES];
        }
        else  if (buttonIndex== 4)
        {
           
            [self facebookPost];
        }
    }
}
-(void)InviteTextfield
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Invite Friends" message:Str_MessageAlert preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField1)
     {
         if ([Str_InviteSelect isEqualToString:@"email"])
         {
             textField1.keyboardType=UIKeyboardTypeEmailAddress;
         }
         else
         {
             textField1.keyboardType=UIKeyboardTypeNumberPad;
             NSString *countryIdentifier = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
             NSString * contrycodes=[NSString stringWithFormat:@"+%@",[dictonarCountrycode objectForKey:countryIdentifier]];
             if (contrycodes !=nil)
             {
                 textField1.text=contrycodes;
             }
             
             
         }
         textField1.placeholder = placeholder_Alert;
         textField1.delegate=self;
         textField1.tag=102;
         
     }];
    confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                     {
                         
                         
                         str_textfield=@"";
                         str_textfield=((UITextField *)[alertController.textFields objectAtIndex:0]).text;
                         if ([Str_InviteSelect isEqualToString:@"email"])
                         {
                             ((UITextField *)[alertController.textFields objectAtIndex:0]).text=@"";
                             str_EmailidText=@"";
                             [self sendEmail];
                         }
                         else
                         {
                             ((UITextField *)[alertController.textFields objectAtIndex:0]).text=@"";
                             Str_mobileNumberText=@"";
                             [self sendMessage];
                         }
                         
                     }];
    [confirmAction setEnabled:NO];
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       
                                       
                                       
                                       NSLog(@"Canelled");
                                   }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)sendEmail
{
    if (![MFMailComposeViewController canSendMail])
    {
        NSLog(@"Mail services are not available");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please configure your mailbox in order to invite a friend." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    else
    {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setToRecipients:[NSArray arrayWithObject:str_textfield]];
        
        str_EmailidText=@"";
        Str_mobileNumberText=@"";
        str_EmailidText=str_textfield;
        [mailCont setSubject:@"Download Play:Date"];
        [mailCont setMessageBody:@"Hey, \n\n Play:Date is a great app to start your child's social network. Join events and get access to exclusive deals for the whole family! \n\nI have been using it since a while, and it would be great if you could download it! \n\n Visit http://www.play-date.ae to download it on your mobile phone! \n\n Thanks!" isHTML:NO];
        [self presentViewController:mailCont animated:YES completion:nil];
        
    }
    
    
}
-(void)sendMessage
{
    if([MFMessageComposeViewController canSendText])
    {
     
        
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
        messageController.messageComposeDelegate = self; // Set delegate to current instance
        
        NSMutableArray *recipients = [[NSMutableArray alloc] init]; // Create an array to hold the recipients
        [recipients addObject:str_textfield];
        str_EmailidText=@"";
        Str_mobileNumberText=@"";// Append example phone number to array
        Str_mobileNumberText=str_textfield;
        messageController.recipients = recipients; // Set the recipients of the message to the created array
        [messageController setEditing:NO animated:YES];;
        messageController.body = @"Play:Date is a great app to start your child's social network. Join events and get access to exclusive deals for the whole family! \n\n Visit http://www.play-date.ae to start using the app today!"; // Set initial text to example message
        
        dispatch_async(dispatch_get_main_queue(), ^{ // Present VC when possible
            [self presentViewController:messageController animated:YES completion:NULL];
        });
    }
}
#pragma mark-Delegate of Message and Email

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultSent:
           
            [self communication_addplayerinvite];
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    NSLog( @"Message send ss==%@",controller.recipients);
    switch (result)
    {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            //            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            
            [self communication_addplayerinvite];
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField11 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *finalString = [textField11.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField11.tag==102)
    {
        str_textfield=textField11.text;
    }
    if (str_textfield.length !=0)
    {
        [confirmAction setEnabled:(finalString.length >= 1)];
    }
    
    
    
    
    return YES;
}
- (IBAction)Button_Chatscreen:(id)sender
{
    
   
    [HomechatTimerplaydate invalidate];
    HomechatTimerplaydate=nil;
     [Button_Create setTitle:@"ADD" forState:UIControlStateNormal];
      Button_Plustap.tag=1;
    Button_Create.tag=1;
       Str_ChangeScreen=@"chats";
     Label_HeadTop.text=@"Friends";
    
    Button_Join.hidden=YES;
    Button_JoinImage.hidden=YES;
     Button_Help.hidden = NO;
    
    
    [Button_chats setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    [Button_playdates setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    
    if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
        
        
        
        borderBottom_chat.backgroundColor =[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1].CGColor;
    }
    else
    {
        
        
        borderBottom_chat.backgroundColor =[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1].CGColor;
    }

   // borderBottom_chat.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
    borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-2.5, Button_chats.frame.size.width, 2.5);
    [Button_chats.layer addSublayer:borderBottom_chat];
    
        borderBottom_playdate.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-1, Button_playdates.frame.size.width, 1);
    [Button_playdates.layer addSublayer:borderBottom_playdate];
    
      [self NewMatchServerComm];
    [Table_Friend reloadData];
}
- (IBAction)Button_PlayDatescreen:(id)sender
{
    
    [HomechatTimer invalidate];
    HomechatTimer=nil;
    Button_Join.hidden=NO;
    Button_JoinImage.hidden=NO;
    Button_Help.hidden = YES;
    
      Button_Plustap.tag=2;
    Button_Create.tag=2;
       Str_ChangeScreen=@"playdate";
     Label_HeadTop.text=@"Play:Date";
     [Button_Create setTitle:@"CREATE" forState:UIControlStateNormal];
   [Button_chats setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [Button_playdates setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
//    borderBottom_playdate.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
    
    
    if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
        
        
        
        borderBottom_playdate.backgroundColor =[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1].CGColor;
    }
    else
    {
        
        
        borderBottom_playdate.backgroundColor =[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1].CGColor;
    }

    
    
    borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-2.5, Button_playdates.frame.size.width, 2.5);
    [Button_playdates.layer addSublayer:borderBottom_playdate];
    
    
    
    borderBottom_chat.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;    borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-1, Button_chats.frame.size.width, 1);
    [Button_chats.layer addSublayer:borderBottom_chat];
    [Table_Friend reloadData];
    [self communication_Eventsmeetups];
}
- (IBAction)Button_JoinImage_action:(id)sender
{
  [self JoinAction];
}
- (IBAction)Button_Join_action:(id)sender
{
    [self JoinAction];
}
- (IBAction)Button_Create_action:(id)sender
{
    senderTagPlus=[sender tag];
    [self Plus_Action];
}

- (IBAction)Button_Help_Action:(id)sender
{
    
    controllerpop = [[HelpPopViewController alloc] initWithNibName:@"HelpPopViewController"  bundle:nil];
    [controllerpop.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [controllerpop.Button_tour addTarget:self action:@selector(buttonTappedpop:) forControlEvents:UIControlEventTouchUpInside];
    [controllerpop.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9]];
    //        controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view  addSubview:controllerpop.view];
    
    
}
-(void)JoinAction
{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Event Code" message:@"Enter the event code of the event that you wish to join:" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
     {
//         textField.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        textField.placeholder = @"Event Code";
        
//        textField.secureTextEntry = YES;
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Join" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        NSLog(@"Current password %@", [[alertController textFields][0] text]);
        Str_TextfieldJoinText=[[alertController textFields][0] text];
            [self Join_Communication];
           
        
        
        
    }];
   
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Canelled");
    }];
      [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - Php Connection
-(void)communication_addplayerinvite
{
    [self.view showActivityViewWithLabel:@"Requesting..."];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        
        NSString *userid= @"fbid";
        NSString *useridVal= [defaults valueForKey:@"fid"];
        
        NSString *envitetype= @"invitetype";
        NSString *eventid= @"eventid";
        
        
        NSString *email= @"email";
        
        NSString *mobileno= @"mobileno";
        
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,email,str_EmailidText,mobileno,Str_mobileNumberText,envitetype,@"FRIEND",eventid,@""];
        
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"sendinvites"];;
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
                                                     
                                                     
                                                     
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     
                                                     NSLog(@"Array_PlayerReauest ResultString %@",ResultString);
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"done"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Request sent" message:@"Your request has been successfully sent. Once the user accepts, you will be notified." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account seems to have been deactivated or does not exist. Please contact support or create a new account." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"nullerror"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"All required details were not sent to the server. Please try again or contact app support." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"alreadyinvited"])
                                                     {
                                                         
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"This user has already been invited" preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"inserterror"])
                                                     {
                                                         
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Server encountered an error in sending your request. Please try again later or contact support." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
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
}
-(void)Join_Communication
{
    if (![Str_TextfieldJoinText isEqualToString:@""])
    {
         [self.view showActivityViewWithLabel:@"Loading"];
      Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
            
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
        exit(0);
          }];
            
            [alertController addAction:actionOk];
[self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        else
        {
            
            NSString *fbid1= @"fbid";
            NSString *fbid1Val=[defaults valueForKey:@"fid"];
            NSString *eventid= @"eventid";
          
            
            
            NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,eventid,Str_TextfieldJoinText];
            
            
            
#pragma mark - swipe sesion
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
            
            NSURL *url;
            NSString *  urlStrLivecount=[urlplist valueForKey:@"joinevent"];;
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
                                                         
                    
    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                         ;
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                         
   
                                                         
    NSLog(@"array_createEvent ResultString %@",ResultString);
    if ([ResultString isEqualToString:@"inserterror"])
    {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The server encountered an error and your Play:Date could not be created. Please try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
                                                             
    [self.view hideActivityViewWithAfterDelay:1];
    }
                    if ([ResultString isEqualToString:@"noeventid"])
                    {
                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"no event id." preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                [alertController addAction:actionOk];
                                [self presentViewController:alertController animated:YES completion:nil];
                                [self.view hideActivityViewWithAfterDelay:1];
                                
                            }
        if ([ResultString isEqualToString:@"done"])
                {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"no event id." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                [alertController addAction:actionOk];
                                [self presentViewController:alertController animated:YES completion:nil];
                                
                                [self.view hideActivityViewWithAfterDelay:1];
                            }
                            if ([ResultString isEqualToString:@"alreadyinvited"])
                            {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"alreadyinvited" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:actionOk];
                                [self presentViewController:alertController animated:YES completion:nil];
                               [self.view hideActivityViewWithAfterDelay:1];
                                
                            }
                            [self.view hideActivityViewWithAfterDelay:1];
 }
      else
            {
                [self.view hideActivityViewWithAfterDelay:1];
        NSLog(@" error login1 ---%ld",(long)statusCode);
                                                         
                                                         
                                }
                                                     
                                                     
                            }
                            else if(error)
                            {
                        [self.view hideActivityViewWithAfterDelay:1];
            NSLog(@"error login2.......%@",error.description);
                          }
                                                 
                                                 
                           }];
            [dataTask resume];
        }
    }
}
-(void)facebookPost

{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        
    {
        
        SLComposeViewController *  fbSLComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //   [fbSLComposeViewController addImage:[UIImage imageNamed:@"anytime.png"]];
        
        [fbSLComposeViewController setInitialText:@"Download Play:Date from the Appstore!"];
        
        [fbSLComposeViewController addURL:[NSURL URLWithString:@"http://www.play-date.ae/"]];
        
        
        
        [self presentViewController:fbSLComposeViewController animated:YES completion:nil];
        
        
        
        fbSLComposeViewController.completionHandler = ^(SLComposeViewControllerResult result)
        
        {
            
            switch(result) {
                    
                case SLComposeViewControllerResultCancelled:
                    
                    NSLog(@"facebook: CANCELLED");
                    
                    break;
                    
                case SLComposeViewControllerResultDone:
                    
                    NSLog(@"facebook: SHARED");
                    
                    break;
                    
            }
            
        };
        
    }
    
    else
        
    {
        
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Facebook Unavailable" message:@"Sorry, we're unable to find a Facebook account on your device.\nPlease setup an account in your devices settings and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:actionOk];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    
    
    
    
    
}
- (void)buttonTappedpop:(id)sender
{
    //[self.view removeFromSuperview];
    controllerpop.view.hidden=YES;
    controllerpopchat = [[HelpPopChatViewController alloc] initWithNibName:@"HelpPopChatViewController"  bundle:nil];
    [controllerpopchat.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [controllerpopchat.Button_Next addTarget:self action:@selector(buttonTappedpopnext:) forControlEvents:UIControlEventTouchUpInside];
    [controllerpopchat.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1]];
    //        controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if ([UIScreen mainScreen].bounds.size.width && [UIScreen mainScreen].bounds.size.height==812.00)
    {
  
        [controllerpopchat.Image_add setFrame:CGRectMake(controllerpopchat.Image_add.frame.origin.x+1, controllerpopchat.Image_add.frame.origin.y+10,26,27)];
        
        [controllerpopchat.Label_add setFrame:CGRectMake(controllerpopchat.Label_add.frame.origin.x, controllerpopchat.Label_add.frame.origin.y+11,53,19)];
        
    
    }
    
    [self.view  addSubview:controllerpopchat.view];
    


}
- (void)buttonTappedpopnext:(id)sender
{
    controllerpopchat.view.hidden=YES;
   controllerpopmeetups = [[HelpPopMeetupsViewController alloc] initWithNibName:@"HelpPopMeetupsViewController"  bundle:nil];
    [controllerpopmeetups.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [controllerpopmeetups.Button_Next addTarget:self action:@selector(buttonTappedpopGotit:) forControlEvents:UIControlEventTouchUpInside];
    [controllerpopmeetups.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1]];
    if ([UIScreen mainScreen].bounds.size.width && [UIScreen mainScreen].bounds.size.height==812.00)
    {
        
        [controllerpopmeetups.image_create setFrame:CGRectMake(controllerpopmeetups.image_create.frame.origin.x+1, controllerpopmeetups.image_create.frame.origin.y+10,26,27)];
        
        [controllerpopmeetups.Label_create setFrame:CGRectMake(controllerpopmeetups.Label_create.frame.origin.x, controllerpopmeetups.Label_create.frame.origin.y+11,53,19)];
        
        
        [controllerpopmeetups.Image_join setFrame:CGRectMake(controllerpopmeetups.Image_join.frame.origin.x+1, controllerpopmeetups.Image_join.frame.origin.y+10,26,29)];
        
        [controllerpopmeetups.Label_join setFrame:CGRectMake(controllerpopmeetups.Label_join.frame.origin.x, controllerpopmeetups.Label_join.frame.origin.y+11,38,19)];
        
     
       
        
    }
    [self.view  addSubview:controllerpopmeetups.view];
    [self Button_PlayDatescreen:nil];

}
- (void)buttonTappedpopGotit:(id)sender
{
     // [self.view removeFromSuperview];
    
    
    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * pathhelp = [documnetPath1 stringByAppendingPathComponent:@"HelpPopup.plist"];
    
    NSString * bundlePath = [[NSBundle mainBundle]pathForResource:@"HelpPopup" ofType:@"plist"];
    
    
    [[NSFileManager defaultManager]copyItemAtPath:bundlePath toPath:pathhelp error:nil]; //mohitcomment


    
    controllerpopmeetups.view.hidden=YES;
}
@end
