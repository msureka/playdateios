//
//  MeetupDetailsViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 6/19/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "MeetupDetailsViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "MainProfilenavigationController.h"
#import "NavigationNewPlayDateViewController.h"
#import "InviteSprintTagUserViewController.h"
#import "ContactListViewController.h"
#import <MessageUI/MessageUI.h>
#import "UIView+RNActivityView.h"
@interface MeetupDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     CGFloat Xpostion, Ypostion, Xwidth, Yheight, ScrollContentSize,Xpostion_label, Ypostion_label, Xwidth_label, Yheight_label;
    UIView *sectionView;
    NSArray * Array_title;
    NSDictionary *urlplist;
    NSMutableArray * Array_AllMeetupData,*Array_InvitesData,*Array_AttendingData,*Array_Date;
      NSUserDefaults *defaults;
    
    NSString * Str_MessageAlert,* Str_mobileNumberText,*str_textfield,*str_EmailidText,*placeholder_Alert,*Str_InviteSelect;
    NSDictionary * dictonarCountrycode;
}
@property(nonatomic, strong)UIAlertAction *confirmAction;
@end

@implementation MeetupDetailsViewController
@synthesize Cell_One,Cell_OneOne,HeadTopView,Cell_three,indicator,eventidvalue,cell_Details,confirmAction;
- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
   
    if ([UIScreen mainScreen].bounds.size.width==375.00 && [UIScreen mainScreen].bounds.size.height==812.00)
    {
       [_Button_Back setFrame:CGRectMake(_Button_Back.frame.origin.x, _Button_Back.frame.origin.y+4, 17, 26)];
    }
  
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
   
    
    Xpostion=12;
    Ypostion=16;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=80;
    Xwidth_label=60;
    Yheight_label=22;
    [indicator startAnimating];
    indicator.hidden=YES;
    _Table_Friend.hidden=YES;
    
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
    
    [self communication_invitemeetups];
     //[_Table_Friend reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self communication_invitemeetups];
}
-(void)communication_invitemeetups
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
        
        NSString *eventid= @"eventid";
     
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidvalue];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"eventdetails"];;
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
                                                     
                                Array_AllMeetupData=[[NSMutableArray alloc]init];
                            Array_InvitesData=[[NSMutableArray alloc]init];
                            Array_AttendingData=[[NSMutableArray alloc]init];
                            Array_Date=[[NSMutableArray alloc]init];
                            SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                        Array_AllMeetupData=[objSBJsonParser objectWithData:data];
                                    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ;
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                    NSLog(@"array_createEvent %@",Array_AllMeetupData);
                                                     
                                                     NSLog(@"array_createEvent ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"noeventid"])
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The event could not be found as it seems to have been expired or deleted by the creator." preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action)
                                                                                    {
                                [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];

                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                    if (Array_AllMeetupData.count !=0)
                                {
                                    
                                    
                                    
                                    if(![[defaults valueForKey:@"fid"] isEqualToString:[[Array_AllMeetupData objectAtIndex:0]valueForKey:@"creatorfbid"]])
                                    {
                        Array_title=[[NSArray alloc]initWithObjects:@"Remove this meetup", nil];
                                    }
                                    else
                                    {
                    Array_title=[[NSArray alloc]initWithObjects:@"Invite Play:Date friends",@"Invite other friends",@"Edit this meetup",@"Delete this meetup", nil];
                                     
                                    }
                                    
                            
                                    
                                    
    _Table_Friend.hidden=NO;
    for (int i=0; i<Array_AllMeetupData.count; i++)
            {
if ([[[Array_AllMeetupData objectAtIndex:i]valueForKey:@"invitedstatus"] isEqualToString:@"INVITED"])
                {
        [Array_InvitesData addObject:[Array_AllMeetupData objectAtIndex:i]];
                                                                 
                    }
              if ([[[Array_AllMeetupData objectAtIndex:i]valueForKey:@"attendingstatus"] isEqualToString:@"ATTENDING"])
                    {
            [Array_AttendingData addObject:[Array_AllMeetupData objectAtIndex:i]];
                    }

                                           
                                    }
                                    
                    [Array_Date addObject:[Array_AllMeetupData objectAtIndex:0]];
                    [_Table_Friend reloadData];
                                                 
                                                 [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                     }
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     if ((long)statusCode ==500)
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Check php file" preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                                                     
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
     if (section==0)
        {
            return 1;
        }
        if (section==1)
        {
            if (Array_InvitesData.count !=0)
            {
                return 1;
            }
            
        }
        if (section==2)
        {
            if (Array_AttendingData.count !=0)
            {
                return 1;
            }
        }
    if (section==3)
    {
   
        return Array_title.count;
       
    }

    
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        if (indexPath.section==0)
        {
            return 225;
        }
        
        if (indexPath.section==1)
        {
           
                return 160;
            
            
            
        }
        if (indexPath.section==2)
        {
            
                return 147;
          
            
        }
    if (indexPath.section==3)
    {
        
        return 54;
        
        
    }
    
    
    return 0;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid=@"Celldetail";
    static NSString *Cellid1=@"Cellone";
    static NSString *cellId2=@"Celltwo";
    static NSString *cellId3=@"Cellthree";
   
        switch (indexPath.section)
        {
                
            case 0:
            {
                
                cell_Details = (MeetupDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid forIndexPath:indexPath];
                
                
                
                
                
                
                cell_Details.label_title.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventtitle"];
                cell_Details.label_location.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventlocation"];
                cell_Details.label_datetime.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventdateformat"];
                cell_Details.label_eventcode.text=[NSString stringWithFormat:@"%@%@%@",@"(Event Code: ",eventidvalue,@")"];
                
                cell_Details.label_createdname.text=[NSString stringWithFormat:@"%@%@",@"Created by ",[[Array_Date objectAtIndex:0]valueForKey:@"fname"]];
                
                
                [cell_Details.Image_CreatedProfilepic setFrame:CGRectMake(cell_Details.Image_CreatedProfilepic.frame.origin.x, cell_Details.Image_CreatedProfilepic.frame.origin.y, cell_Details.Image_CreatedProfilepic.frame.size.height, cell_Details.Image_CreatedProfilepic.frame.size.height)];
                NSURL * url1=[[Array_Date objectAtIndex:0]valueForKey:@"profilepic"];
                
                if ([[[Array_Date objectAtIndex:0]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    
                    
                    [cell_Details.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                    
                }
                else
                {
                    [cell_Details.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]options:SDWebImageRefreshCached];
                }
                
                
                
                
                return cell_Details;
                
                
            }
                break;
            case 1:
            {
                
                Cell_One = (InvitemeetupsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
                
                for(UIImageView* view in Cell_One.myscrollView.subviews)
                {
                    
                    [view removeFromSuperview];
                    
                }
                
                
                
                
                CALayer *borderBottomViewTap6 = [CALayer layer];
                borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
                borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
                [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
                
                
              
                
                NSString *text =[NSString stringWithFormat:@"%d",Array_InvitesData.count];// @"300";
               
                CGSize constraint = CGSizeMake(296,9999);
                CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]
                               constrainedToSize:constraint
                                   lineBreakMode:UILineBreakModeWordWrap];
                [Cell_One.label_Invitecount setFrame:CGRectMake(Cell_One.label_Invitecount.frame.origin.x, Cell_One.label_Invitecount.frame.origin.y, size.width+16, Cell_One.label_Invitecount.frame.size.height)];
                
                 Cell_One.label_Invitecount.text=text;
                Cell_One.label_Invitecount.clipsToBounds=YES;
                Cell_One.label_Invitecount.layer.cornerRadius= Cell_One.label_Invitecount.frame.size.height/2;;
                
                Cell_One.label_title.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventtitle"];
                Cell_One.label_location.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventlocation"];
                Cell_One.label_datetime.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventdateformat"];
                
                
                Cell_One.label_createdname.text=[NSString stringWithFormat:@"%@%@",@"Created by ",[[Array_Date objectAtIndex:0]valueForKey:@"fname"]];
                
                
                [Cell_One.Image_CreatedProfilepic setFrame:CGRectMake(Cell_One.Image_CreatedProfilepic.frame.origin.x, Cell_One.Image_CreatedProfilepic.frame.origin.y, Cell_One.Image_CreatedProfilepic.frame.size.height, Cell_One.Image_CreatedProfilepic.frame.size.height)];
                NSURL * url1=[[Array_Date objectAtIndex:0]valueForKey:@"profilepic"];
                
                if ([[[Array_InvitesData objectAtIndex:0]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    
                    
                    [Cell_One.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                    
                }
                else
                {
                    [Cell_One.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]options:SDWebImageRefreshCached];
                }
                
                
                
                for (int i=0; i<Array_InvitesData.count; i++)
                {
                    
                    UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                    UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                    
                    
                    Imagepro.userInteractionEnabled=YES;
                    
                    [Imagepro setTag:i];
                    Imagepro.backgroundColor=[UIColor redColor];
                    
                    UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(ImageTapped_profile1:)];
                    [Imagepro addGestureRecognizer:ImageTap];
                    
                    
                    Imagepro.clipsToBounds=YES;
                    Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                    [Imagepro setBackgroundColor:[UIColor redColor]];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                     // [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                    
                    Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                    Label_name.numberOfLines = 1;
                    Label_name.adjustsFontSizeToFitWidth=YES;
                    Label_name.minimumScaleFactor=0.5;
                 
                    
                    Label_name.textAlignment=NSTextAlignmentCenter;
                    
                   
                        Label_name.text=[[Array_InvitesData objectAtIndex:i]valueForKey:@"fname"];
                        Label_name.backgroundColor=[UIColor clearColor];
                        Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                        
                    
                    
                    [Cell_One.myscrollView addSubview:Label_name];
                    [Cell_One.myscrollView addSubview:Imagepro];
                    
                    
                    
                    NSURL * url=[[Array_InvitesData objectAtIndex:i]valueForKey:@"profilepic"];
                    
                    if ([[[Array_InvitesData objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
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
                    Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 115);
                    
                    
                    
                    
                    
                }
                
                
                
                Xpostion=12;
                Ypostion=16;
                Xwidth=60;
                Yheight=60;
                ScrollContentSize=0;
                Xpostion_label=12;
                Ypostion_label=80;
                Xwidth_label=60;
                Yheight_label=22;
                        return Cell_One;
                
                
            }
                break;
              
                
            case 2:
            {
                
                Cell_OneOne = (AttendingMeetupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                
                for(UIImageView* view in Cell_OneOne.myscrollView.subviews)
                {
                    
                    [view removeFromSuperview];
                    
                }
                
                
                 NSString *text =[NSString stringWithFormat:@"%d",Array_AttendingData.count];
                CGSize constraint = CGSizeMake(296,9999);
                CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]
                               constrainedToSize:constraint
                                   lineBreakMode:UILineBreakModeWordWrap];
                [Cell_OneOne.label_AttendingCount setFrame:CGRectMake(Cell_OneOne.label_AttendingCount.frame.origin.x, Cell_OneOne.label_AttendingCount.frame.origin.y, size.width+16,Cell_OneOne.label_AttendingCount.frame.size.height)];
                Cell_OneOne.label_AttendingCount.text=text;
                Cell_OneOne.label_AttendingCount.clipsToBounds=YES;
                Cell_OneOne.label_AttendingCount.layer.cornerRadius= Cell_OneOne.label_AttendingCount.frame.size.height/2;;
//                CALayer *borderBottomViewTap6 = [CALayer layer];
//                borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
//                borderBottomViewTap6.frame = CGRectMake(0, Cell_OneOne.myscrollView.frame.size.height - 1, Cell_OneOne.myscrollView.frame.size.width, 1);
//                [Cell_OneOne.myscrollView.layer addSublayer:borderBottomViewTap6];
                
                for (int i=0; i<Array_AttendingData.count; i++)
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
                    [Imagepro setBackgroundColor:[UIColor redColor]];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                        Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                    Label_name.numberOfLines = 1;
                    Label_name.adjustsFontSizeToFitWidth=YES;
                    Label_name.minimumScaleFactor=0.5;
                 
                    Label_name.textAlignment=NSTextAlignmentCenter;
                    
                 
                    
                    
                        
                        Label_name.text=[[Array_AttendingData objectAtIndex:i]valueForKey:@"fname"];
                        Label_name.backgroundColor=[UIColor clearColor];
                        Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                        
                
                    
                
                    
                    [Cell_OneOne.myscrollView addSubview:Label_name];
                    [Cell_OneOne.myscrollView addSubview:Imagepro];
                    
                    
                    
                    NSURL * url=[[Array_AttendingData objectAtIndex:i]valueForKey:@"profilepic"];
                    
                    if ([[[Array_AttendingData objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
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
                    Cell_OneOne.myscrollView.contentSize=CGSizeMake(Xpostion, 115);
                }
                
                
                
                Xpostion=12;
                Ypostion=16;
                Xwidth=60;
                Yheight=60;
                ScrollContentSize=0;
                Xpostion_label=12;
                Ypostion_label=80;
                Xwidth_label=60;
                Yheight_label=22;
               
             
                return Cell_OneOne;
                
     
}
 break;
  case 3:
            {
                
                Cell_three = (InvitemoremeetupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
                
                Cell_three.label_invitemoresroes.text=[Array_title objectAtIndex:indexPath.row];
              
               
                CALayer *borderBottom = [CALayer layer];
                borderBottom.backgroundColor = [UIColor whiteColor].CGColor;
                
                borderBottom.frame = CGRectMake(0, Cell_three.frame.size.height - 5, Cell_three.frame.size.width, 6);
                [Cell_three.layer addSublayer:borderBottom];
                
                return Cell_three;
                
                
            }
                break;
                
        }
    
    return nil;


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 4;
   
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    
        if (section==2)//1
        {
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,45)];
            [sectionView setBackgroundColor:[UIColor lightGrayColor]];
            UIButton * Label1=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
            Label1.backgroundColor=[UIColor clearColor];
         
            Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
           [Label1 setTitle:@"Invite more friends" forState:UIControlStateNormal];
            [Label1 setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
            [Label1 setTitle:@"Invite more friends" forState:UIControlStateNormal];
            [Label1 addTarget:self action:@selector(Invitemorefriend_Acttion:) forControlEvents:UIControlEventTouchUpInside];
            
            [sectionView addSubview:Label1];
            sectionView.tag=section;
            
        }
    
        return  sectionView;
        
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
//        if (section==2)
//        {
//           
//          return 45;
//            
//        }
    
    
    return 0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section==3)
    {
        if (indexPath.row==0)
        {
    if(![[defaults valueForKey:@"fid"] isEqualToString:[[Array_AllMeetupData objectAtIndex:0]valueForKey:@"creatorfbid"]])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Remove Meetup" message:@"Are you sure you want to remove yourself from this meetup?" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Yes"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                           [self DeleteEventCreatedIndexZero];
                                       }];
            UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"No"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            
                                        }];
            
            [alertController addAction:actionOk];
            [alertController addAction:actionOk1];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            
            [self invitemoreIndexZero];
   
       
        }
        }
        if (indexPath.row==1)
        {
            UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Invite by email address",@"Invite by mobile number",@"Invite contacts",nil];
            popup.tag = 777;
            [popup showInView:self.view];
        }
       
        if (indexPath.row==2)
        {
            [self EditmeetupIndexone];
        }

        if (indexPath.row==3)
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want to delete this meetup?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionYES = [UIAlertAction actionWithTitle:@"Yes"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                            [self DeleteeventIndexTwo];
                                       }];
            UIAlertAction *actionNO = [UIAlertAction actionWithTitle:@"No"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                          
                                       }];

            [alertController addAction:actionYES];
            [alertController addAction:actionNO];
            [self presentViewController:alertController animated:YES completion:nil];
            
          
        }

        
    }
    
   
}
-(IBAction)Button_BackView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Invitemorefriend_Acttion:(UIButton *)sender
{
    
}

-(IBAction)Button_share:(id)sender
{

NSString * texttoshare=[NSString stringWithFormat:@"%@%@%@",@"You have been invited to a Play:Date meet-up!\n\nEnter the event code:\n",eventidvalue,@" to join the meet-up.\n\nDownload Play:Date on your iPhone from http://www.play-date.ae and find new friends for your children!"];
    

    NSArray *activityItems1=@[texttoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    [self presentViewController:activityViewControntroller animated:YES completion:nil];
}
-(void)ImageTapped_profile1:(UIGestureRecognizer*)reconizer
{
    
}
-(void)ImageTapped_profile:(UIGestureRecognizer*)reconizer
{
    
}

-(void)invitemoreIndexZero
{
    InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
    
    set.str_checkmorefriends=@"morefriend";
    [self.navigationController pushViewController:set animated:YES];
}
-(void)EditmeetupIndexone
{
//    createdate = "2017-06-20 08:57:42";
//    creatorfbid = 1224819434269672;
//    eventdate =     {
//        date = "2017-06-24 08:58:48.000000";
//        timezone = UTC;
//        "timezone_type" = 3;

  
    [defaults setObject:@"edit" forKey:@"checkview"];
    
    [defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventtitle"] forKey:@"textfield_title"];
    
    [defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventlocation"] forKey:@"textfield_location"];
    
[defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventdate"] forKey:@"eventdateformat"];
    
    [defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventdescription"] forKey:@"textview_disc"];
    [defaults synchronize];
    
    NavigationNewPlayDateViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationNewPlayDateViewController"];
    
    [self.navigationController presentModalViewController:tvc animated:YES];
   
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((long)actionSheet.tag == 777)
    {
        NSLog(@"INDEXAcrtionShhet==%ld",(long)buttonIndex);
        
        
        if (buttonIndex== 0)
        {
            
            
            Str_InviteSelect=@"email";
            placeholder_Alert=@"Enter email address";
            Str_MessageAlert=@"Enter the email address of the user you wish to invite.";
            [self InviteTextfield];
            
        }
        if (buttonIndex== 1)
        {
            
            Str_InviteSelect=@"mobileno";
            placeholder_Alert=@"Enter mobile number";
            Str_MessageAlert=@"Enter the mobile number with country code of the user you wish to invite.";
            
            [self InviteTextfield];
        }
        else  if (buttonIndex== 2)
        {
            
            
            [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ContactListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactListViewController"];
            set.invitetype=@"MEETUP";
            set.eventidvalue=eventidvalue;
            [self.navigationController pushViewController:set animated:YES];
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
        
        NSString * texttoshare=[NSString stringWithFormat:@"%@%@%@",@"You have been invited to a Play:Date meet-up!\n\nEnter the event code:\n",eventidvalue,@" to join the meet-up.\n\nDownload Play:Date on your iPhone from http://www.play-date.ae and find new friends for your children!"];
        
        [mailCont setMessageBody:texttoshare isHTML:NO];
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
         NSString * texttoshare=[NSString stringWithFormat:@"%@%@%@",@"You have been invited to a Play:Date meet-up!\n\nEnter the event code:\n",eventidvalue,@" to join the meet-up.\n\nDownload Play:Date on your iPhone from http://www.play-date.ae and find new friends for your children!"];
        messageController.body = texttoshare; // Set initial text to example message
        
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
        
        
        
        
        NSString *email= @"email";
        
        NSString *mobileno= @"mobileno";
        
         NSString *envitetype= @"invitetype";
        NSString *eventid= @"eventid";
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,email,str_EmailidText,mobileno,Str_mobileNumberText,envitetype,@"MEETUP",eventid,eventidvalue];
        
        
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
                                                         
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"This user has already been invited!" preferredStyle:UIAlertControllerStyleAlert];
                                                         
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
-(void)DeleteeventIndexTwo
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
        
        NSString *eventid= @"eventid";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidvalue];
        
        

        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"deleteevent"];;
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
                                                     
                                                     Array_AllMeetupData=[[NSMutableArray alloc]init];
                                                     Array_InvitesData=[[NSMutableArray alloc]init];
                                                     Array_AttendingData=[[NSMutableArray alloc]init];
                                                     Array_Date=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_AllMeetupData=[objSBJsonParser objectWithData:data];
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ;
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"array_createEvent %@",Array_AllMeetupData);
                                                     
                                                     NSLog(@"array_createEvent ResultString %@",ResultString);
                                                if ([ResultString isEqualToString:@"noeventid"])
                                                {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The event could not be found as it seems to have been expired or deleted by the creator." preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                            style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                    
                                                         
                                                     }
                                if ([ResultString isEqualToString:@"done"])
                                {
                                    
                                    [defaults setObject:@"yes" forKey:@"tapindex"];
                                    [defaults synchronize];
                            MainProfilenavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
                                      [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
                                    
                                   
                                    
                                }
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     if ((long)statusCode ==500)
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Check php file" preferredStyle:UIAlertControllerStyleAlert];
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                                                     
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
-(void)DeleteEventCreatedIndexZero
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
        
        NSString *eventid= @"eventid";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidvalue];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"removeevent"];
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
                                                     
                                                     Array_AllMeetupData=[[NSMutableArray alloc]init];
                                                     Array_InvitesData=[[NSMutableArray alloc]init];
                                                     Array_AttendingData=[[NSMutableArray alloc]init];
                                                     Array_Date=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_AllMeetupData=[objSBJsonParser objectWithData:data];
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ;
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"array_createEvent %@",Array_AllMeetupData);
                                                     
                                                     NSLog(@"array_createEvent ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"noeventid"])
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The event could not be found as it seems to have been expired or deleted by the creator." preferredStyle:UIAlertControllerStyleAlert];
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"done"])
                                                     {
                                                         
                                                         [defaults setObject:@"yes" forKey:@"tapindex"];
                                                         [defaults synchronize];
                                                         MainProfilenavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
                                                         [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
                                                         
                                                         
                                                         
                                                     }
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     if ((long)statusCode ==500)
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Check php file" preferredStyle:UIAlertControllerStyleAlert];
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                                                     
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

@end
