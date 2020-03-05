//
//  FriendCahtingViewControlleroneViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 6/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FriendCahtingViewControlleroneViewController.h"
#import "UIViewController+KeyboardAnimation.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "DiscoverUserProfileinfoViewController.h"
#import "Base64.h"
#import "AdProfileViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "MeetupDetailsViewController.h"
#import <EventKit/EventKit.h>
#import "ZooomImageView.h"
@import EventKit;
@import EventKitUI;

static NSString* const CellIdentifier = @"DynamicTableViewCell";
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH self.view.frame.size.width-138
#define CELL_CONTENT_MARGIN 0.0f
@interface FriendCahtingViewControlleroneViewController ()
{
    UIScrollView *scrollviews;
    UIImageView *attachmentImageNew;
    ZooomImageView *zoomImageview;
    
    NSTimer *HomeTimer;
    NSURL *url_Vedio,* movieURLmain ;
    UIPinchGestureRecognizer *twoFingerPinch;
    UIImageView *Image_Amount,*Image_Date;
    UILabel * Label_paid_Unpaid,*Label_TitleTag,*Label_TitleTag1,*DateLabelHeder;
    UIImage *chosenImage;
    NSData *imageData,*ImageDataHeder,*newVedioData;
    NSDictionary *urlplist;
    NSURLConnection *Connection_Comment,*Connection_Comment_send,*Connection_Like;
    NSMutableData * webData_Comment,*webData_Comment_send,*webData_Like;
    NSMutableArray *Array_Comment,*Array_Like;
    NSString *ResultString,*String_Comment,*ResultString_sendComment,*ResultString_Like,*encodedImage,*chattype;
    UIGestureRecognizer *TabGestureDetailViewLikes,*TapGest_LabelHedingTap;
    NSUserDefaults * defaults;
    
    UIImageView * image_Desc,*ImageViews;
    UIView *headerView2,*headerView1,*PopUpImageVIew;
    UIButton *headerLabel1,* headerLabel2;
    NSArray * images_Array;
    NSString *   ImageNSdata,*Str_StatusAChecked,*Str_TextfieldflagText;
    CGFloat HeightText0;
    CGRect TextViewCord,BackTextViewCord;
    UIButton * tapHederImage_Button;
    CGFloat lastScale;
    NSString *subImgname,* TagId_plist,*imageUserheight,*imageUserWidth,*Flag_TimeOneUser,*Flag_Timeseconduser;
    NSMutableArray * newCommentsArray_plist,*Array_Comment1;
    
    NSArray *previousArray;
    
    CGFloat hh,ww,xx,yy,th,tw,xt,yt,bty,btw,bth,btx,Bluesch,Bluescw,Bluescy,Bluescx,textBluex,textBluey,textBluew,textBlueh,hhone,wwone,xxone,yyone,Button_width,keyboradHeight;
    NSString * flag1,*flag2,*flag3,*eventidval,*statusval;
    BOOL statusTextView;
    CGRect previousRect;
    NSInteger * senderTag_Addcalender;
    UIView *sectionView;
    NSMutableArray * arracal;
    UIFont * Font_AddCalender;
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;
@end
static const CGFloat kButtonSpaceShowed = 90.0f;
static const CGFloat kButtonSpaceHided = 24.0f;
#define kBackgroundColorShowed [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
#define kBackgroundColorHided [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];
@implementation FriendCahtingViewControlleroneViewController
@synthesize HeadTopView,Table_Friend_chat,Label_UserName,Image_UserProfile;
@synthesize AllDataArray,TextViews,BackTextViews;
@synthesize textOne,tableOne,ViewTextViewOne,Cell_one1;
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    if ([UIScreen mainScreen].bounds.size.width==375.00 && [UIScreen mainScreen].bounds.size.height==812.00)
    {
        [_Button_Flag_Button setFrame:CGRectMake(_Button_Flag_Button.frame.origin.x-4, _Button_Flag_Button.frame.origin.y+2, _Button_Flag_Button.frame.size.width+2, _Button_Flag_Button.frame.size.height-4)];
         [_Button_back setFrame:CGRectMake(_Button_back.frame.origin.x, _Button_back.frame.origin.y+2, 17, 26)];
    }
    defaults=[[NSUserDefaults alloc]init];
    previousArray  = [[NSArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"UpdatenotificationChat" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TappedImage) name:@"TappedImage" object:nil];
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"] )
    {
//        CGRect tableViewFrame = self.Table_Friend_chat.frame;
//        tableViewFrame.origin.y = 56;
//        self.Table_Friend_chat.frame = tableViewFrame;
    }
    CGRect tableViewFrame = self.Table_Friend_chat.frame;
    tableViewFrame.size.height = self.Table_Friend_chat.frame.size.height-8;
    self.Table_Friend_chat.frame = tableViewFrame;

    Table_Friend_chat.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureTablviewTuch =[[UITapGestureRecognizer alloc] initWithTarget:self
     action:@selector(Tablview_Tuched:)];
    
    
    [Table_Friend_chat addGestureRecognizer:TabGestureTablviewTuch];
    
    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatTextPlayDate.plist"];
    
    NSString * bundlePath = [[NSBundle mainBundle]pathForResource:@"ChatTextPlayDate" ofType:@"plist"];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        NSLog(@"File alredy exists");
    }
    else
    {
        [[NSFileManager defaultManager]copyItemAtPath:bundlePath toPath:path error:nil];
    }
    
    
    // [self Image_UserProfileTapped:nil];
    
    //    Image_UserProfile.clipsToBounds = YES;
    //    Image_UserProfile.layer.cornerRadius = Image_UserProfile.frame.size.height / 2;
    
//    NSURL * url=[NSURL URLWithString:[[AllDataArray objectAtIndex:0] valueForKey:@"profilepic"]];
//    [Image_UserProfile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
//    Label_UserName.text=[[AllDataArray objectAtIndex:0] valueForKey:@"fname"];
    
    //     [Image_UserProfile setFrame:CGRectMake(HeadTopView.center.x-64,  Image_UserProfile.frame.origin.y, Image_UserProfile.frame.size.width, Image_UserProfile.frame.size.height)];
    //
    
    
    NSString *text=Label_UserName.text;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGFloat  widthCal=(size.width+Image_UserProfile.frame.size.width);
    CGFloat  ToatalWidth=((self.view.frame.size.width-widthCal)/2);
    
    NSLog(@"Length Of textttt==%f",size.width);
    NSLog(@"Length Of textttt==%f",widthCal);
    NSLog(@"Length Of textttt==%f",ToatalWidth);
    
    [Image_UserProfile setFrame:CGRectMake(ToatalWidth,Image_UserProfile.frame.origin.y, Image_UserProfile.frame.size.width, Image_UserProfile.frame.size.height)];
    [Label_UserName setFrame:CGRectMake(Image_UserProfile.frame.origin.x+Image_UserProfile.frame.size.width+10,Label_UserName.frame.origin.y, Label_UserName.frame.size.width, Label_UserName.frame.size.height)];
    _BlackViewOne.backgroundColor=[UIColor whiteColor];
    CALayer *borderTop = [CALayer layer];
    borderTop.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderTop.frame = CGRectMake(0, 0,self.view.frame.size.width, 1);
    [_BlackViewOne.layer addSublayer:borderTop];
    
    self.sendButton.userInteractionEnabled = NO;
    self.sendButton.hidden=NO;
    self.sendButton.enabled=NO;
    self.placeholderLabel.hidden=NO;
    [self.sendButton setBackgroundColor:[UIColor lightGrayColor]];//colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]];
    self.sendButton.layer.cornerRadius=self.sendButton.frame.size.height/2;
    self.sendButton.frame=CGRectMake((self.view.frame.size.width-self.sendButton.frame.size.width)-4, self.sendButton.frame.origin.y,self.sendButton.frame.size.width, self.sendButton.frame.size.height);
    
    self.BlackViewOne.frame=CGRectMake(self.view.frame.size.width,self.BlackViewOne.frame.origin.y,self.view.frame.size.width, self.BlackViewOne.frame.size.height);
    
    
    
    
    
    self.ImageGalButton.userInteractionEnabled = YES;
    _ImageGalButton.hidden=NO;
    _ImageGalButton.enabled=YES;
    [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.height);
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.width);
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.origin.y);
    
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.height);
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.width);
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.y);
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.x);
    
    
    textOne.clipsToBounds=YES;
    textOne.layer.cornerRadius=7.0f;
    
    ViewTextViewOne.clipsToBounds=YES;
    ViewTextViewOne.layer.cornerRadius=9.0f;
    
    
    
    
    
    hh=textOne.frame.size.height+5;
    ww=textOne.frame.size.width;
    xx=textOne.frame.origin.x;
    yy=textOne.frame.origin.y;
    
    
    
    if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
    {
        
        ww=194.0;
        Button_width=77.0;
       Font_AddCalender=[UIFont fontWithName:@"Helvetica-Bold" size:12];
        
    }
    else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
    {
        
        ww=249.0;
        Button_width=100.0;
         Font_AddCalender=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    }
    
    else  if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
    {
        
        ww=288.0;
        Button_width=114.0;
         Font_AddCalender=[UIFont fontWithName:@"Helvetica-Bold" size:16];
        
    }
    else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==812.00)
    {
        
        ww=249.0;
        Button_width=100.0;
        Font_AddCalender=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    }
    
    
    th=Table_Friend_chat.frame.size.height;
    tw=Table_Friend_chat.frame.size.width;
    xt=Table_Friend_chat.frame.origin.x;
    yt=Table_Friend_chat.frame.origin.y;
    
    bth=_BlackViewOne.frame.size.height;
    btw=_BlackViewOne.frame.size.width;
    btx=_BlackViewOne.frame.origin.x;
    bty=_BlackViewOne.frame.origin.y;
    
    Bluesch=_BlackViewOne.frame.size.height;
    Bluescw=_BlackViewOne.frame.size.width;
    Bluescx=_BlackViewOne.frame.origin.x;
    Bluescy=_BlackViewOne.frame.origin.y;
    
    
    flag1=@"yes";
    
    //    CGRect previousRect = CGRectZero;
    self.BlackViewOne.frame = CGRectMake(0, 55, btw,87);
    self.textOne.frame = CGRectMake(xx, yy,ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    
    
    
    //  Table_Friend_chat.frame = CGRectMake(0,-1, tw, th);
    //     Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-10);
    // Table_Friend_chat.backgroundColor=[UIColor greenColor];
    
    
//    subImgname =[[[AllDataArray objectAtIndex:0]valueForKey:@"tagpic"]lastPathComponent];
//    NSLog(@"subImgname=%@",subImgname);
    
    
    
    //   [self.view addSubview:self.ewenTextView];
    //     _ewenTextView.backgroundColor = [UIColor clearColor];
    
    
    
    [TextViews becomeFirstResponder];
    
    TextViewCord=TextViews.frame;
    BackTextViewCord=BackTextViews.frame;
    HeightText0=TextViews.frame.size.height;
    TextViews.layer.cornerRadius=8.0f;
    //    SendButton.hidden=YES;
    //    SendButton.layer.cornerRadius=8.0f;
    
    
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"data pay view profile=%@",AllDataArray);
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    
    Array_Comment = [[NSMutableArray alloc] init];
    Array_Like = [[NSMutableArray alloc] init];
  //  NSLog(@"paid data====%@",[[AllDataArray objectAtIndex:0]valueForKey:@"tagtype"] );
    
    
    Array_Comment1=[[NSMutableArray alloc]init];
    
    
    //    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //
    //    NSLog(@"%@",NSHomeDirectory());
    //
    //    NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
    
    [defaults setObject:[[AllDataArray valueForKey:@"eventid"]objectAtIndex:0] forKey:@"neweventid"];
    [defaults synchronize];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    NSLog(@"dictionary setValue:=%@",dictionary );
    if (AllDataArray.count==0)
    {
       
        TagId_plist=[defaults valueForKey:@"eventid"];
    }
    else
    {
        
        
        TagId_plist=[[AllDataArray valueForKey:@"eventid"]objectAtIndex:0];
        
    }
    
    
    
    BOOL contains = [[dictionary allKeys] containsObject:TagId_plist];
    if(contains==YES)
    {
        NSLog(@"YEsssssssssssss");
        Array_Comment1=[dictionary valueForKey:TagId_plist];
        [Table_Friend_chat reloadData];
        if(Array_Comment1.count>=1)
        {
            
            
            [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            
        }
        NSLog(@"data plist path array==%@",Array_Comment1);
    }
    
    NSLog(@"Arrraararara:=%@",AllDataArray );
    Image_UserProfile.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureDetailView =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(Image_UserProfileTapped:)];
    
    
    [Image_UserProfile addGestureRecognizer:TabGestureDetailView];
    
    Label_UserName.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureDetailView2 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(Image_UserProfileTapped:)];
    
    [Label_UserName addGestureRecognizer:TabGestureDetailView2];
    
    
    
    if ([[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"] isEqualToString:@"play-date"])
    {
        _Button_Flag_Button.hidden=YES;
        
    }
    else
    {
        _Button_Flag_Button.hidden=NO;
    }
    
    
    
    
    [Table_Friend_chat reloadData];
    
    [defaults setObject:@"yes" forKey:@"notification"];
    [defaults synchronize];
     Str_StatusAChecked=@"yes";
    Flag_TimeOneUser=@"yes";
    Flag_Timeseconduser=@"yes";
    [self CommentCommmunication];
    
#pragma mark - timer
    
    //  HomeTimer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(CommentCommmunication) userInfo:nil  repeats:YES];
    
    
    
}
-(void)viewDidLayoutSubviews
{
    if (Array_Comment1.count>=1)
    {
        [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)chatTimer
{
    HomeTimer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(CommentCommmunication) userInfo:nil  repeats:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self chatTimer];
    
    //    HomeTimer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(CommentCommmunication) userInfo:nil  repeats:YES];
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        CGRect tableViewFrame = self.Table_Friend_chat.frame;
        tableViewFrame.origin.y = 56;
        self.Table_Friend_chat.frame = tableViewFrame;
    }
    
    Image_UserProfile.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureDetailView =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(Image_UserProfileTapped:)];
    
    
    [Image_UserProfile addGestureRecognizer:TabGestureDetailView];
    
    
    [self subscribeToKeyboard];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [HomeTimer invalidate];
    HomeTimer=nil;
    [self an_unsubscribeKeyboard];
}


- (void)subscribeToKeyboard {
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing)
     {
         
         
        if (isShowing) {
            
            if ([UIScreen mainScreen].bounds.size.width==375.00 && [UIScreen mainScreen].bounds.size.height==812.00)
            {
                [_textOneBlue setFrame:CGRectMake(0,self.view.frame.size.height-_textOneBlue.frame.size.height-keyboardRect.size.height, _textOneBlue.frame.size.width, _textOneBlue.frame.size.height)];
                
                Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textBlueh+CGRectGetHeight(keyboardRect)));
                keyboradHeight=(textBlueh+CGRectGetHeight(keyboardRect));
            }
            else
            {
                self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
            }
            Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textBlueh+CGRectGetHeight(keyboardRect)));
            //keyboradHeight=(textBlueh+CGRectGetHeight(keyboardRect));
            keyboradHeight=(textBlueh+CGRectGetHeight(keyboardRect));
            if(Array_Comment1.count>=1)
            {
                if([subImgname isEqualToString:@"defaultimg.jpg"])
                {
                    
                    [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }
                else
                {
                    [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }
            }
            
            
            
            
        } else {
            
            if ([UIScreen mainScreen].bounds.size.width==375.00 && [UIScreen mainScreen].bounds.size.height==812.00)
            {
                [_textOneBlue setFrame:CGRectMake(0,(self.view.frame.size.height-_textOneBlue.frame.size.height)-34, _textOneBlue.frame.size.width, _textOneBlue.frame.size.height)];
            }
            else
            {
                self.tabBarBottomSpace.constant = 0.0f;
            }
            Table_Friend_chat.frame = CGRectMake(0,yt, tw, th);
              keyboradHeight=0.0f;
            
        }
        [self.view layoutIfNeeded];
    } completion:nil];}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (Array_Comment1.count !=0)
    {
        return Array_Comment1.count+1;
    }
    return 0;
    
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return 0;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"CellOnes";
    
    
    
    UILabel *label = nil;
    UILabel *label1 = nil;
    UILabel *label_time = nil;
    UIImageView * desc_Imagepro=nil;
    UIView * calnderView=nil;
    //    UIImageView * Chat_ImageRight=nil;
    UIImageView * Chat_UserImage=nil;
    
    UIImageView * Image_calnder=nil;
    UIButton * Button_AddCalnder=nil;
    UIButton * Button_IM=nil;
    UIButton * Button_cantgo=nil;
    UILabel *label_caltitle = nil;
    UILabel *label_callocation = nil;
    UILabel *label_caltime = nil;
    
    NSLog(@"Indexpath===%d",indexPath.row);
    Cell_one1 = [Table_Friend_chat dequeueReusableCellWithIdentifier:@"Cell"];
    Cell_one1.selectionStyle=UITableViewCellSelectionStyleNone;
    if (Cell_one1 == nil)
    {
        
        Cell_one1 = [[CustomTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:Cellid1] ;
        label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        [label1 setLineBreakMode:UILineBreakModeWordWrap];
        [label1 setNumberOfLines:0];
        [label1 setTag:1];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [[Cell_one1 contentView] addSubview:label1];
        
       
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setNumberOfLines:0];
        [label setFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE]];
        [label setTag:5];
        [label setBackgroundColor:[UIColor clearColor]];
        [[Cell_one1 contentView] addSubview:label];
        
        
        
        label_time = [[UILabel alloc] initWithFrame:CGRectZero];
        [label_time setLineBreakMode:UILineBreakModeWordWrap];
        [label_time setNumberOfLines:0];
        [label_time setFont:[UIFont fontWithName:@"Helvetica-Light" size:12]];
        
        [label_time setBackgroundColor:[UIColor clearColor]];
        [[Cell_one1 contentView] addSubview:label_time];
        
        
        desc_Imagepro = [[UIImageView alloc] initWithFrame:CGRectZero];
        [desc_Imagepro setTag:4];
        [desc_Imagepro setBackgroundColor:[UIColor lightGrayColor]];
        [[Cell_one1 contentView] addSubview:desc_Imagepro];
        
        
        //        Chat_ImageRight = [[UIImageView alloc] initWithFrame:CGRectZero];
        //        [Chat_ImageRight setTag:4];
        //        [Chat_ImageRight setBackgroundColor:[UIColor lightGrayColor]];
        //        [[Cell_one1 contentView] addSubview:Chat_ImageRight];
        
        Chat_UserImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [Chat_UserImage setTag:5];
        [Chat_UserImage setBackgroundColor:[UIColor lightGrayColor]];
        [[Cell_one1 contentView] addSubview:Chat_UserImage];
        
        Chat_UserImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *TabGestureDetailView =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_upload_image:)];
        [Chat_UserImage addGestureRecognizer:TabGestureDetailView];
        
        calnderView = [[UIView alloc] initWithFrame:CGRectZero];
        calnderView.clipsToBounds=YES;
        calnderView.layer.cornerRadius=15.0f;
        [calnderView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:0.7]];
        [[Cell_one1 contentView] addSubview:calnderView];
        
        
        
        Image_calnder = [[UIImageView alloc] initWithFrame:CGRectZero];
        [Image_calnder setBackgroundColor:[UIColor clearColor]];
        [calnderView  addSubview:Image_calnder];
        
        [Image_calnder setImage:[UIImage imageNamed:@"calendar"]];

        Button_AddCalnder = [[UIButton alloc] initWithFrame:CGRectZero];
        [Button_AddCalnder setBackgroundColor:[UIColor clearColor]];
        [calnderView  addSubview:Button_AddCalnder];
        [Button_AddCalnder setFont:Font_AddCalender];
        [Button_AddCalnder setTitle:@"ADD TO MY CALENDAR" forState:UIControlStateNormal];
        
        Button_AddCalnder.titleLabel.minimumScaleFactor = 0.5f;
        Button_AddCalnder.titleLabel.numberOfLines = 1;
        Button_AddCalnder.titleLabel.adjustsFontSizeToFitWidth = YES;
        
//        Button_AddCalnder.titleLabel.numberOfLines = 1;
//        Button_AddCalnder.titleLabel.adjustsFontSizeToFitWidth = YES;
//        Button_AddCalnder.titleLabel.lineBreakMode = NSLineBreakByClipping;
//        
        
        [Button_AddCalnder setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
        Button_IM = [[UIButton alloc] initWithFrame:CGRectZero];
        [Button_IM setBackgroundColor:[UIColor clearColor]];
        [calnderView  addSubview:Button_IM];
        [Button_IM setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [Button_IM setTitle:@"I'M IN" forState:UIControlStateNormal];
        [Button_IM setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
        
        Button_cantgo = [[UIButton alloc] initWithFrame:CGRectZero];
        [Button_cantgo setBackgroundColor:[UIColor clearColor]];
        [calnderView  addSubview:Button_cantgo];
        [Button_cantgo setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [Button_cantgo setTitle:@"CAN'T GO" forState:UIControlStateNormal];
        [Button_cantgo setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
        
        label_caltitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [label_caltitle setBackgroundColor:[UIColor clearColor]];
        [calnderView  addSubview:label_caltitle];
        label_caltitle.textAlignment=NSTextAlignmentCenter;
        label_caltitle.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
        label_caltitle.text=@"Let's to the beach!";
        label_caltitle.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
        
        label_callocation = [[UILabel alloc] initWithFrame:CGRectZero];
        [label_callocation setBackgroundColor:[UIColor clearColor]];
        [calnderView  addSubview:label_callocation];
        label_callocation.textAlignment=NSTextAlignmentCenter;
        label_callocation.font=[UIFont fontWithName:@"Helvetica" size:13];
        label_callocation.text=@"Let's to the beach!";
          label_callocation.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
        
        label_caltime = [[UILabel alloc] initWithFrame:CGRectZero];
        [label_caltime setBackgroundColor:[UIColor clearColor]];
        [calnderView  addSubview:label_caltime];
        label_caltime.font=[UIFont fontWithName:@"Helvetica" size:13];
        label_caltime.textAlignment=NSTextAlignmentCenter;
        label_caltime.text=@"Let's to the beach!";
        label_time.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
        
        
        
        
       
       
    }
    
    
    Cell_one1.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if (!label)
        label = (UILabel*)[Cell_one1 viewWithTag:1];
    
    if (!label1)
        label1 = (UILabel*)[Cell_one1 viewWithTag:2];
    
    if (!desc_Imagepro)
        desc_Imagepro = (UIImageView*)[Cell_one1 viewWithTag:4];
    
   
    
    [label setBackgroundColor:[UIColor clearColor]];
   
    
    label.textColor=[UIColor blackColor];
    
    
    if (indexPath.row==0)
    {
        
       
   if ([[defaults valueForKey:@"fid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"creatorfbid"]])
        {
        [label setText:[NSString stringWithFormat:@"%@%@",@"You have created this meetup on ",[[AllDataArray objectAtIndex:0] valueForKey:@"createdate"]]];
        }
        else
        {
           [label setText:[NSString stringWithFormat:@"%@%@",@"You have joined this meetup on ",[[AllDataArray objectAtIndex:0] valueForKey:@"invitedate"]]];
        }
        [label setFrame:CGRectMake(0,label_time.frame.size.height,self.view.frame.size.width, Cell_one1.frame.size.height)];
        label.textColor=[UIColor lightGrayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label_time.hidden=YES;
        
       
    }
    else
    {
        
        
        if (![[defaults valueForKey:@"fid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"senderfbid"]])
        {
            
            
          
            
            
            NSURL * url2=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"profilepic"];
            if ([[[Array_Comment1 objectAtIndex:indexPath.row-1] valueForKey:@"gender"] isEqualToString:@"Boy"])
            {
                [desc_Imagepro setBackgroundColor:[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1]];
               [desc_Imagepro sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"boypictureframe 1.png"]options:SDWebImageRefreshCached];
            
            }
            else
            {
                 [desc_Imagepro setBackgroundColor:[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1]];
                [desc_Imagepro sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"girlpictureframe 1.png"]options:SDWebImageRefreshCached];
             
            }
            
            
            
        }
        else
            
        {
            NSURL * url=[defaults valueForKey:@"profilepic"];
            [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
            
            
        }
        
        label_time.tag=indexPath.row-1;
        
        label_time.textColor=[UIColor lightGrayColor];
        label_time.textAlignment=NSTextAlignmentCenter;
        label_time.hidden=NO;
        Chat_UserImage.hidden=NO;
        
        NSString *str = [[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"msgdate"];;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *dte = [dateFormat dateFromString:str];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        
        NSLog(@"Date format saecond %@",[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte]]);
        NSString *str_Date=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte]];
        
        label_time.text=str_Date;
        label_time.hidden=NO;
    
        if (indexPath.row==1)
        {
            
            Flag_TimeOneUser=@"no";
            label_time.hidden=NO;
             desc_Imagepro.hidden=YES;
            [label_time setFrame:CGRectMake(0,0,self.view.frame.size.width, 20)];
            NSLog(@"Date format row11 %d",indexPath.row-1);
        }
        else
        {
            label_time.hidden=NO;
                desc_Imagepro.hidden=NO;
            if (indexPath.row >=2)
            {
                NSString *str1 = [[Array_Comment1 objectAtIndex:indexPath.row-2]valueForKey:@"msgdate"];;         NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                [dateFormat1 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSDate *dte1 = [dateFormat1 dateFromString:str1];
                [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
                label_time.text=[NSString stringWithFormat:@"%@",[dateFormat1 stringFromDate:dte1]];
                NSLog(@"Date format saecond1111 %@",[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte1]]);
                NSString *str_Date1=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte1]];
                if ([str_Date isEqualToString:str_Date1])
                {
                    [label_time setFrame:CGRectMake(0,0,0,0)];
                    label_time.text=@"";;
                }
                else
                {
                    [label_time setFrame:CGRectMake(0,0,self.view.frame.size.width, 20)];
                    label_time.text=str_Date;
                }
                
            }
            
            
        }
        
        
        
        
        
        if ([[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
        {
            
            
            
            NSString *text =[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"message"];
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
            
            CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            
            int lines = size.height/16;
            
            NSLog(@"lines count : %i \n\n",lines);
            
            
            
            [label setFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE]];
            
            NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = NSTextAlignmentLeft;
            style.firstLineHeadIndent = 10.0f;
            style.headIndent = 10.0f;
            style.tailIndent = -10.0f;
            
            NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : style}];
            
            label.numberOfLines = 0;
            label.attributedText = attrText;
            
            //   [label setText:text];
            
            label.clipsToBounds=YES;
            label.layer.cornerRadius=9.0f;
            label1.backgroundColor=[UIColor colorWithRed:13/255.0 green:146/255.0 blue:220/255.0 alpha:0.8];
            
            NSLog(@"Comment Width==%f",size.width);
            NSLog(@"Comment Height==%f",size.height);
            NSLog(@"Comment StringLength==%lu",(unsigned long)text.length);
            
            if (![[defaults valueForKey:@"fid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"senderfbid"]])
            {
                
                
                
//                NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"profilepic"];
//                [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                
                
                label.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:0.7];
                //        label.textColor=[UIColor colorWithRed:124/255.0 green:111/255.0 blue:164/255.0 alpha:0.7];
                label.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                if (size.width <=self.view.frame.size.width-132)
                {
                    
                    //            [label1 setFrame:CGRectMake(50,0, size.width+34, MAX(size.height, 30.0f)+4)];
                    [label setFrame:CGRectMake(50,label_time.frame.size.height, size.width+22, MAX(size.height, 30.0f)+8)];
                    
                    
                }
                
                else
                {
                    //            [label1 setFrame:CGRectMake(50,0, self.view.frame.size.width-132, MAX(size.height, 30.0f)+4)];
                    [label setFrame:CGRectMake(50,label_time.frame.size.height, self.view.frame.size.width-140,MAX(size.height, 30.0f)+8)];
                    
                    
                }
                
             
                [desc_Imagepro setFrame:CGRectMake(8,label.frame.origin.y+(label.frame.size.height-32),32,32)];
                desc_Imagepro.clipsToBounds=YES;
                desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
            }
            else
            {
//                NSURL * url=[defaults valueForKey:@"profilepic"];
//                [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    label.backgroundColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1];
                    label.layer.borderColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1].CGColor;
                    label.layer.borderWidth=1.0f;
                    
                }
                else
                {
                    label.backgroundColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1];
                    label.layer.borderColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1].CGColor;
                    label.layer.borderWidth=1.0f;
                }
                
                //        label.textColor=[UIColor colorWithRed:108/255.0 green:157/255.0 blue:180/255.0 alpha:1];
                label.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                
                if (size.width <=self.view.frame.size.width-132)
                {
                    
                    //            [label1 setFrame:CGRectMake(self.view.frame.size.width-(size.width+89),0, size.width+30, MAX(size.height, 30.0f)+8)];
                    [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+83),label_time.frame.size.height, size.width+22, MAX(size.height, 30.0f)+8)];
                }
                
                else
                {
                    
                    
                    //            [label1 setFrame:CGRectMake(self.view.frame.size.width-(size.width+81),0, self.view.frame.size.width-132, MAX(size.height, 30.0f)+8)];
                    [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+83),label_time.frame.size.height, self.view.frame.size.width-140, MAX(size.height, 30.0f)+8)];
                    
                    
                    
                }
                //        Chat_ImageRight.backgroundColor=[UIColor clearColor];
                //        [Chat_ImageRight setFrame:CGRectMake(label.frame.size.width+label.frame.origin.x-2,label1.frame.size.height-27, 16,16)];
                
                
                //        [Chat_ImageRight setImage:[UIImage imageNamed:@"Chat_arrow_right.png"]];
                
                
                [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,label.frame.origin.y+(label.frame.size.height-32),32,32)];
                desc_Imagepro.clipsToBounds=YES;
                desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
            }
            
         
          label.hidden=NO;
            
        }
       else if ([[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"chattype"] isEqualToString:@"EVENT"])
        {
            if ([Str_StatusAChecked isEqualToString:@"yes"])
            {
                 statusval=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"attendingstatus"];
                Str_StatusAChecked=@"no";
            }
           
            
            desc_Imagepro.hidden=NO;
          [calnderView setFrame:CGRectMake(55,25,self.view.frame.size.width-110, 236)];
            
            [Image_calnder setFrame:CGRectMake((calnderView.frame.size.width/2)-13,20,26,26)];
            
            label_caltitle.numberOfLines = 1;
            label_caltitle.minimumFontSize = 10;
            label_caltitle.adjustsFontSizeToFitWidth = YES;
            
            [label_caltitle setFrame:CGRectMake(12,Image_calnder.frame.size.height+Image_calnder.frame.origin.y+10,calnderView.frame.size.width-24,20)];
            
            
            
            
            
            [label_callocation setFrame:CGRectMake(12,label_caltitle.frame.size.height+label_caltitle.frame.origin.y+5,calnderView.frame.size.width-24, 20)];
            
            label_callocation.numberOfLines = 1;
            label_callocation.minimumFontSize = 10;
            label_callocation.adjustsFontSizeToFitWidth = YES;
            
            [label_caltime setFrame:CGRectMake(24,label_callocation.frame.size.height+label_callocation.frame.origin.y,calnderView.frame.size.width-48, 20)];
            
            [Button_IM setFrame:CGRectMake(label_caltime.frame.origin.x,label_caltime.frame.size.height+label_caltime.frame.origin.y+15,Button_width,34)];
            [Button_cantgo setFrame:CGRectMake((label_caltime.frame.origin.x+label_caltime.frame.size.width)-Button_width,label_caltime.frame.size.height+label_caltime.frame.origin.y+15,Button_width, 34)];
            
            [Button_AddCalnder setFrame:CGRectMake(24,Button_IM.frame.size.height+Button_IM.frame.origin.y+15,calnderView.frame.size.width-48, 34)];
            
            [Button_IM setTag:indexPath.row-1];
            [Button_cantgo setTag:indexPath.row-1];
            [Button_AddCalnder setTag:indexPath.row-1];
            
            
            [Button_IM addTarget:self action:@selector(Button_calIM_Action:) forControlEvents:UIControlEventTouchUpInside];
            [Button_cantgo addTarget:self action:@selector(Button_calcantgo_Action:) forControlEvents:UIControlEventTouchUpInside];
            [Button_AddCalnder addTarget:self action:@selector(Button_Addcalender_Action:) forControlEvents:UIControlEventTouchUpInside];
            
            Button_AddCalnder.clipsToBounds=YES;
            Button_AddCalnder.layer.cornerRadius=Button_AddCalnder.frame.size.height/2;
            Button_AddCalnder.layer.borderColor=[UIColor blackColor].CGColor;
            Button_AddCalnder.layer.borderWidth=1.0f;
            
            Button_cantgo.clipsToBounds=YES;
            Button_cantgo.layer.cornerRadius=Button_AddCalnder.frame.size.height/2;
            
            Button_IM.clipsToBounds=YES;
            Button_IM.layer.cornerRadius=Button_AddCalnder.frame.size.height/2;
            
            label_caltitle.text=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"eventtitle"];
            label_callocation.text=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"eventlocation"];
             label_caltime.text=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"eventdateformat"];
            if ([statusval isEqualToString:@"ATTENDING"])
            {
                
                Button_IM.selected=YES;
                Button_cantgo.selected=NO;
                Button_IM.layer.borderColor=[UIColor clearColor].CGColor;
                Button_IM.layer.borderWidth=1.0f;
                
         
                [Button_IM setBackgroundColor:[UIColor whiteColor]];
                
                Button_cantgo.layer.borderColor=[UIColor blackColor].CGColor;
                Button_cantgo.layer.borderWidth=1.0f;
                
             
                [Button_cantgo setBackgroundColor:[UIColor clearColor]];
                 

            }
//            else
//            {
//              Button_IM.selected=NO;
//            }
            if ([statusval isEqualToString:@"NOTATTENDING"])
            {
               
                Button_cantgo.selected=YES;
                Button_IM.selected=NO;
                Button_IM.layer.borderColor=[UIColor blackColor].CGColor;
                Button_IM.layer.borderWidth=1.0f;
                
                
                [Button_IM setBackgroundColor:[UIColor clearColor]];
                
                Button_cantgo.layer.borderColor=[UIColor clearColor].CGColor;
                Button_cantgo.layer.borderWidth=1.0f;
                
                [Button_cantgo setBackgroundColor:[UIColor whiteColor]];
                
            }
//            else
//            {
//              Button_cantgo.selected=NO;
//            }
            if ([statusval isEqualToString:@"UNKNOWN"])
            {
                Button_IM.selected=NO;
                Button_cantgo.selected=NO;
                Button_IM.layer.borderColor=[UIColor blackColor].CGColor;
                Button_IM.layer.borderWidth=1.0f;
                
               
                [Button_IM setBackgroundColor:[UIColor clearColor]];
                
                Button_cantgo.layer.borderColor=[UIColor blackColor].CGColor;
                Button_cantgo.layer.borderWidth=1.0f;
                
               
                [Button_cantgo setBackgroundColor:[UIColor clearColor]];
            }
            
            
            
             if (![[defaults valueForKey:@"fid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"senderfbid"]])
            {
                label.hidden=YES;
                
//                NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"profilepic"];
//                [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
//                
                
                [desc_Imagepro setFrame:CGRectMake(8,calnderView.frame.origin.y+(calnderView.frame.size.height-32),32,32)];
                desc_Imagepro.clipsToBounds=YES;
                desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
            }
            else
                
            {
                label.hidden=YES;
//                NSURL * url=[defaults valueForKey:@"profilepic"];
//                [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
               
                [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,calnderView.frame.origin.y+(calnderView.frame.size.height-32),32,32)];
                desc_Imagepro.clipsToBounds=YES;
                desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
            }
            
      
            
        }
        else
        {
            
            
            CGFloat imgwidth=[[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imagewidth"] floatValue];
            CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imageheight"] floatValue];
            
            //Chat_UserImage.backgroundColor=[UIColor clearColor];
            NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imageurl"];
            [Chat_UserImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
            Chat_UserImage.clipsToBounds=YES;
            Chat_UserImage.layer.cornerRadius=9.0f;
            Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
            
            
            
            
            
            
            if ([[defaults valueForKey:@"fid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"senderfbid"]])
            {
                
//                NSURL * url=[[AllDataArray objectAtIndex:0]valueForKey:@"profilepic"];
//                [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                
                [Chat_UserImage setFrame:CGRectMake(52,4+label_time.frame.size.height,imgwidth,imgheight)];
                Chat_UserImage.clipsToBounds=YES;
                Chat_UserImage.layer.cornerRadius=9.0f;
                Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                
               
                
                [desc_Imagepro setFrame:CGRectMake(8,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
                desc_Imagepro.clipsToBounds=YES;
                desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                
            }
            else
            {
                
                
//                NSURL * url=[defaults valueForKey:@"profilepic"];
//                [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                
                
                [Chat_UserImage setFrame:CGRectMake((self.view.frame.size.width-64)-imgwidth,4+label_time.frame.size.height,imgwidth,imgheight)];
                Chat_UserImage.clipsToBounds=YES;
                Chat_UserImage.layer.cornerRadius=9.0f;
                Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                
                [self displayImage:Chat_UserImage withImage:Chat_UserImage.image];
                
                [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
                desc_Imagepro.clipsToBounds=YES;
                desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
            }
            
            
        }
        
        
        
        
    }
    return Cell_one1;
    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
////    if (section==0)
////    {
//        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
//        [sectionView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
//        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
//        Label1.backgroundColor=[UIColor clearColor];
//        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
//        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
//        Label1.text=@"New matches";
//
//
//        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(130,6,24,24)];
//        Label2.backgroundColor=[UIColor lightGrayColor];
//        Label2.clipsToBounds=YES;
//        Label2.layer.cornerRadius=Label2.frame.size.height/2;
//        Label2.textColor=[UIColor groupTableViewBackgroundColor];
//        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
//        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Comment.count];
//        Label2.textAlignment=NSTextAlignmentCenter;
//        [sectionView addSubview:Label2];
//
//
//
//        [sectionView addSubview:Label1];
//        sectionView.tag=section;
//    return sectionView;
//    }


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==0)
    {
        return 50;
    }
    else
    {
        CGFloat heightAdd = 0;
        NSString *str = [[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"msgdate"];;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *dte = [dateFormat dateFromString:str];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        
        NSLog(@"Date format saecond %@",[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte]]);
        NSString *str_Date=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte]];
        
        if (indexPath.row==1)
        {
            heightAdd=20;
            
        }
        else
        {
            
            if (indexPath.row >=2)
            {
                NSString *str1 = [[Array_Comment1 objectAtIndex:indexPath.row-2]valueForKey:@"msgdate"];;         NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                [dateFormat1 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSDate *dte1 = [dateFormat1 dateFromString:str1];
                [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
                
                NSLog(@"Date format saecond1111 %@",[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte1]]);
                NSString *str_Date1=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte1]];
                if ([str_Date isEqualToString:str_Date1])
                {
                    
                    heightAdd=0;
                }
                else
                {
                    
                    heightAdd=20;
                }
                
            }
           
            
        }
        
        if ([[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
        {
            NSString *text = [[Array_Comment1 objectAtIndex:indexPath.row-1] valueForKey:@"message"];
            
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
            
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            CGFloat height = MAX(size.height, 30.0f);
            return height + (CELL_CONTENT_MARGIN * 2)+15+heightAdd;
        }
        else if ([[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"chattype"] isEqualToString:@"EVENT"])
        {
            return 271;
        }
        else
        {
            CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imageheight"] floatValue];
            return imgheight+15+heightAdd;
        }
        
        
    }
    return 0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0;
//
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==1)
//    {
//
//    }
//
//}
-(IBAction)BackView:(id)sender
{
    
    
  
    if ([[defaults valueForKey:@"letsmeet"] isEqualToString:@"yes"])
    {
        
        
        [self performSegueWithIdentifier:@"back" sender:self];
        
        [defaults setObject:@"no" forKey:@"letsmeet"];
        [defaults synchronize];
    }
    else
    {
        [defaults setObject:@"no" forKey:@"letsmeet"];
        [defaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
      
        
    }
    
    
    
    [HomeTimer invalidate];
    HomeTimer=nil;
}

-(IBAction)Send_Comments:(id)sender
{
    String_Comment=textOne.text;
    [self sendComment];
    textOne.text=nil;
    _ImageGalButton.enabled=YES;
    _placeholderLabel.hidden=NO;
    self.BlackViewOne.frame = CGRectMake(0, 55, btw,87);
    self.textOne.frame = CGRectMake(xx, yy, ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    self.sendButton.enabled=NO;
    self.sendButton.backgroundColor=[UIColor lightGrayColor];
    Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-keyboradHeight);
    self.ImageGalButton.userInteractionEnabled = YES;  
    
}
-(IBAction)CameraButtonAct:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take from camera",@"Choose from gallery",nil];
    popup.tag = 3;
    [popup showInView:self.view];
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  
        if (buttonIndex== 0)
        {
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            //  [self.navigationController pushViewController:picker animated:YES];
            // [self.navigationController presentModalViewController:picker animated:YES];
        }
        if (buttonIndex== 1)
        {
            
            
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
            
            
            
        }
    
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    chattype=@"IMAGE";
    chosenImage = info[UIImagePickerControllerOriginalImage];
    
    UIImageView *attachmentImageNew = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width-120, self.view.frame.size.height-127)];
    attachmentImageNew.image = chosenImage;
    attachmentImageNew.backgroundColor = [UIColor redColor];
    attachmentImageNew.contentMode = UIViewContentModeScaleAspectFit;
    
    
    float widthRatio = attachmentImageNew.bounds.size.width / attachmentImageNew.image.size.width;
    float heightRatio = attachmentImageNew.bounds.size.height / attachmentImageNew.image.size.height;
    float scale = MIN(widthRatio, heightRatio);
    float imageWidth = scale * attachmentImageNew.image.size.width;
    float imageHeight = scale * attachmentImageNew.image.size.height;
    
    NSLog(@"Size of pic is %f",imageWidth);
    NSLog(@"Size of pic is %f",imageHeight);
    if (imageWidth>=254)
    {
        imageUserWidth=[NSString stringWithFormat:@"%f",254.0];
    }
    else
    {
        imageUserWidth=[NSString stringWithFormat:@"%f",imageWidth];
    }
    
    imageUserheight=[NSString stringWithFormat:@"%f",imageHeight];
    
    UIImage *image =  [self scaleImage:chosenImage  toSize:CGSizeMake([imageUserWidth floatValue]*2,[imageUserheight floatValue]*2)];
    
    
    imageData = UIImageJPEGRepresentation(image,0.5);
    
    // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    ImageNSdata = [Base64 encode:imageData];
    
    
    encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
    else
    {
        [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self sendComment];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    chattype=@"";
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void)sendComment
{
    
    NSLog(@"sachin %@",String_Comment);
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"addeventchat"];
    url =[NSURL URLWithString:urlStrLivecount];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //    NSString *receiverfbid=@"fbid2";
    NSString *receiverfbidVal=[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"];
    
    //    NSString *senderfbid=@"fbid1";
    NSString *senderfbidVal=[defaults valueForKey:@"fid"];
    
    //    NSString *chatcount=@"chatcount";
    NSString *chatcountVal=@"";
    
    //    NSString *message=@"message";
    NSString *messageVal = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textOne.text,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
    
    //    NSString *Chattypee=@"chattype"; 
    NSString *ChattypeeVal=chattype;
    
    
    //    NSString *ChatImage=@"chatimage";
    NSString *ChatImageVal=encodedImage;
    
    //    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",receiverfbid,receiverfbidVal,senderfbid,senderfbidVal,chatcount,chatcountVal,message,messageVal];
    //
    //
    //    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    //    [request setHTTPBody: requestData];
    
    
    
    
    NSString *parameter = [NSString stringWithFormat:@"fbid=%@&eventid=%@&chatcount=%@&message=%@&chattype=%@&chatimage=%@&imagewidth=%@&imageheight=%@",senderfbidVal,receiverfbidVal,chatcountVal,messageVal,ChattypeeVal,ChatImageVal,imageUserWidth,imageUserheight];
    //    NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //    ;
    
    //
    //
    NSData * requestData = [NSData dataWithBytes:[parameter UTF8String] length: [parameter length]];
    
    
    
    [request setHTTPBody:requestData];
    
    
    Connection_Comment_send = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    {
        if( Connection_Comment_send)
        {
            webData_Comment_send=[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
    
}
-(void)CommentCommmunication
{
    
    NSLog(@"comment communication");
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"eventchat"];
    url =[NSURL URLWithString:urlStrLivecount];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *fbid1=@"fbid";
    NSString *fbid1Val=[defaults valueForKey:@"fid"];
    
    NSString *fbid2;
    NSString *fbid2val;
    
    
    if (AllDataArray.count==0)
    {
        fbid2=@"eventid";
        fbid2val=[defaults valueForKey:@"eventid"];
    }
    else
    {
        fbid2=@"eventid";
        fbid2val=[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"];
        [defaults setObject:[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"] forKey:@"eventid"];
        [defaults synchronize];
    }
    NSString *InviteDate=@"invitedate";
    NSString *InviteDateval=[[AllDataArray objectAtIndex:0]valueForKey:@"invitedate"];
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,fbid2,fbid2val,InviteDate,InviteDateval];
    
    
    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    [request setHTTPBody: requestData];
    
    Connection_Comment = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    {
        if( Connection_Comment)
        {
            webData_Comment =[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSLog(@"connnnnnnnnnnnnnn=%@",connection);
    if(connection==Connection_Comment)
    {
        [webData_Comment setLength:0];
        
        
    }
    if(connection==Connection_Comment_send)
    {
        [webData_Comment_send setLength:0];
        
        
    }
    if(connection==Connection_Like)
    {
        [webData_Like setLength:0];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_Comment)
    {
        [webData_Comment appendData:data];
    }
    if(connection==Connection_Comment_send)
    {
        [webData_Comment_send appendData:data];
    }
    if(connection==Connection_Like)
    {
        [webData_Like appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (connection==Connection_Comment)
    {
        
        
        
        
        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        ResultString=[[NSString alloc]initWithData:webData_Comment encoding:NSUTF8StringEncoding];
        Array_Comment= [objSBJsonParser objectWithData:webData_Comment];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSLog(@"Array_Comment %@",Array_Comment);
        NSLog(@"Array_Comment_ResultString%@",ResultString);
        if ([ResultString isEqualToString:@"NullError"])
        {
            
        }
        
        NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSLog(@"%@",NSHomeDirectory());
        
        NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatTextPlayDate.plist"];
        
        
        if(Array_Comment.count!=0)
        {
            
            NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
            
            NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
            
            
            
            if(Array_Comment1.count==0 || savedValue1==nil)
            {
                if (savedValue1==nil)
                {
                    NSMutableDictionary *data;
                    
                    data = [[NSMutableDictionary alloc] init];
                    
                    [data setObject:Array_Comment forKey:TagId_plist];
                    [data writeToFile:path atomically:YES];
                }
                
            }
            
            
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            NSLog(@"dictionary setValue:=%@",dictionary );
            
            if (Array_Comment.count!=0)
            {
                Array_Comment1=Array_Comment;
                [dictionary setObject:Array_Comment forKey:TagId_plist];
                [dictionary writeToFile:path atomically:YES];
            }
            
            
            
            if (previousArray.count == Array_Comment.count)
            {
              [Table_Friend_chat reloadData];
            }
            else
            {
                [Table_Friend_chat reloadData];
            }
            
            
            
            
            
            
            
            if(Array_Comment.count>=1 && previousArray.count != Array_Comment.count )
            {
                
                
                [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                
            }
            
            previousArray = Array_Comment;
            
            
            
        }
        
        
        
    }
    if (connection==Connection_Comment_send)
    {
        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        ResultString_sendComment=[[NSString alloc]initWithData:webData_Comment_send encoding:NSUTF8StringEncoding];
        Array_Comment=[objSBJsonParser objectWithData:webData_Comment_send];
        
        ResultString_sendComment = [ResultString_sendComment stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString_sendComment = [ResultString_sendComment stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSLog(@"Array_Commentsens %@",Array_Comment);
        NSLog(@"ResultString_sendComment%@",ResultString_sendComment);
        
        
        if ([ResultString isEqualToString:@"nullerror"])
        {
            //            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            //            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        if ([ResultString isEqualToString:@"nofbid"])
        {
            //            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            //            [message show];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
            
        }
        if ([ResultString isEqualToString:@"inserterror"])
        {
            //            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error in sending message. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            //            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in sending message. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        if ([ResultString isEqualToString:@"messagenull"])
        {
            //            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your message text seems to be empty. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            //            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your message text seems to be empty. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        if ([ResultString isEqualToString:@"imagenull"])
        {
            //            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You seem to have not selected an image to send. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            //            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have not selected an image to send. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        if ([ResultString isEqualToString:@"imageerror"])
        {
            //            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not upload the image you have selected. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            //            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not upload the image you have selected. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        
        if(Array_Comment.count !=0)
        {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatTextPlayDate.plist"];
            
            
            
            NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
            
            
            NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
            
            if(Array_Comment1.count==0 || savedValue1==nil)
            {
                if (savedValue1==nil)
                {
                    NSMutableDictionary *data;
                    
                    data = [[NSMutableDictionary alloc] init];
                    
                    [data setObject:Array_Comment forKey:TagId_plist];
                    [data writeToFile:path atomically:YES];
                }
                
            }
            
            
            
            
            
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            NSLog(@"dictionary setValue:=%@",dictionary);
            if(Array_Comment.count !=0)
            {
                NSLog(@"NO11111");
                Array_Comment1=Array_Comment;
                [dictionary setObject:Array_Comment forKey:TagId_plist];
                [dictionary writeToFile:path atomically:YES];
            }
            
            
             [Table_Friend_chat reloadData];
            if(Array_Comment.count>=1)
            {
                
                
                [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                
            }

        }
        
        
    }
    if (connection==Connection_Like)
    {
        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        ResultString_Like=[[NSString alloc]initWithData:webData_Like encoding:NSUTF8StringEncoding];
        Array_Like= [objSBJsonParser objectWithData:webData_Like];
        
        ResultString_Like = [ResultString_Like stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString_Like = [ResultString_Like stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSLog(@"ResultString_Like %@",Array_Like);
        NSLog(@"ResultString_Like%@",ResultString_Like);
        if ([ResultString_Like isEqualToString:@"NoLikes"])
        {
            [Table_Friend_chat reloadData];
        }
        
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    //    [tableView_Pay scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    if(Array_Comment1.count>=1)
    {
        
        
        [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    }
    
    if (textView.text.length == 0)
    {
        self.sendButton.hidden=NO;
        self.sendButton.enabled=NO;
        self.placeholderLabel.hidden=NO;
        [self.sendButton setBackgroundColor:[UIColor lightGrayColor]];
        self.sendButton.userInteractionEnabled = NO;
        
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=YES;
        [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
        self.ImageGalButton.userInteractionEnabled = YES;
        
        
        
        
    }
    else
    {
        
        chattype=@"TEXT";
        
        
        self.placeholderLabel.hidden=YES;
        self.sendButton.hidden=NO;
        self.sendButton.enabled=YES;
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        self.sendButton.userInteractionEnabled = YES;
        
        
        
        _ImageGalButton.userInteractionEnabled = NO;
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=NO;
        
    }
    
    
    CGFloat y = CGRectGetMaxY(self.textOne.frame);
    
    UITextPosition* pos = textOne.endOfDocument;
    
    CGRect currentRect = [textOne caretRectForPosition:pos];
    
    NSLog(@"dsdssdfds %f",currentRect.origin.y);
    
    if (currentRect.origin.y >65)
    {
        if ( [flag1 isEqualToString:@"yes" ])
        {
            
            self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+36, btw,bth+textView.contentSize.height);
            ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textOne.frame.size.height+2);
            // tableView_Pay.frame = CGRectMake(0, yt - textView.contentSize.height+38, tw, th);
            Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+(keyboradHeight-hh)));            flag1=@"no";
        }
        else
        {
            flag1=@"no";
        }
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        if(currentRect.origin.y <=64)
        {
            flag1=@"yes";
        }
        
        
        
        self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+33, btw,bth+textView.contentSize.height);
        
        self.textOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height+10);
        ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height);
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+(keyboradHeight-hh)));
        
        [self.textOne layoutIfNeeded];
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.height);
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.width);
        NSLog(@"BlueViewx==%f",_textOneBlue.frame.origin.x);
        NSLog(@"BlueViewy==%f",_textOneBlue.frame.origin.y);
        
        
        
        NSLog(@"tableView_Pay==%f",Table_Friend_chat.frame.size.height);
        NSLog(@"tableView_Payyy==%f",Table_Friend_chat.frame.origin.y);
        
        NSLog(@"ViewTextViewOne==%f",ViewTextViewOne.frame.size.height);
        
        NSLog(@"self.textOne.frame==%f",self.textOne.frame.size.height);
        
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.height);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.width);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.origin.y);
        
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.height);
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.width);
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.y);
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.x);
    }
}
-(void)Tablview_Tuched:(UIGestureRecognizer *)reconizer
{
    [self.view endEditing:YES];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
////    if (_BlackViewOne.frame.size.height > bth)
////    {
////        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
////    }
////    else
////    {
////        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th);
////        
////    }
//   // [self.view endEditing:YES];
//    
//    
//}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [textOne becomeFirstResponder];
    
//    if (textView.text.length!=0)
//    {
//        Table_Friend_chat.frame = CGRectMake(0,yt, self.view.frame.size.width, th-_BlackViewOne.frame.size.height-125);
//        
//    }
//    else
//    {
//        
//        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+190));
//    }
    
    if(Array_Comment1.count>=1)
    {
        
        
        [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
        
        
    }
    
}

- (void)Image_upload_image:(UITapGestureRecognizer *)recognizer
{
    UIImageView *imgView = (UIImageView *)[(UITapGestureRecognizer*)recognizer view];
    //  [EXPhotoViewer showImageFrom:imgView];
    
    
    
    zoomImageview = [[[NSBundle mainBundle] loadNibNamed:@"ZooomImageView" owner:self options:nil] objectAtIndex:0];
    [zoomImageview setFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height)];
    
    
    
    attachmentImageNew = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [attachmentImageNew setImage:imgView.image];
    attachmentImageNew.backgroundColor = [UIColor redColor];
    attachmentImageNew.contentMode = UIViewContentModeScaleAspectFill;
    
    
    float widthRatio = attachmentImageNew.bounds.size.width / attachmentImageNew.image.size.width;
    float heightRatio = attachmentImageNew.bounds.size.height / attachmentImageNew.image.size.height;
    float scale = MIN(widthRatio, heightRatio);
    float imageWidth = scale * attachmentImageNew.image.size.width;
    float imageHeight = scale * attachmentImageNew.image.size.height;
    
    if (imageHeight>=self.view.frame.size.height)
    {
        imageHeight=imageHeight-60;
    }
    [attachmentImageNew setFrame:CGRectMake(0,60, self.view.frame.size.width, imageHeight)];
    scrollviews=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollviews.clipsToBounds=YES;
    scrollviews.delegate=self;
    attachmentImageNew.center=scrollviews.center;
    [scrollviews setMaximumZoomScale:5.0f];
    [scrollviews setMinimumZoomScale:1.0f];
    [zoomImageview addSubview:scrollviews];
    [scrollviews addSubview:attachmentImageNew];
    attachmentImageNew.center=scrollviews.center;
    scrollviews.bounces=NO;
    scrollviews.center=self.view.center;
    [scrollviews setBackgroundColor:[UIColor blackColor]];
    attachmentImageNew.userInteractionEnabled=YES;
    scrollviews.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    
    
    
    UIButton * button_closed=[[UIButton alloc]initWithFrame:CGRectMake(0, 35, 80,40)];
    [button_closed setImage:[UIImage imageNamed:@"Done.png"] forState:UIControlStateNormal];
    [button_closed addTarget:self action:@selector(button_closeview:) forControlEvents:UIControlEventTouchUpInside];
    [zoomImageview addSubview:button_closed];
    
    [self.view addSubview:zoomImageview];
    
}

- (void)Image_UserProfileTapped:(UITapGestureRecognizer *)recognizer
{
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"])
    {
        [self performSegueWithIdentifier:@"next" sender:self];
    }
    else if ([[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        [self performSegueWithIdentifier:@"nextAd" sender:self];
    }
    else
    {
        if ([[[AllDataArray objectAtIndex:0] valueForKey:@"profiletype"] isEqualToString:@"PROFILE"])
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DiscoverUserProfileinfoViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"DiscoverUserProfileinfoViewController"];
            set.Array_UserInfo=AllDataArray;
            [self.navigationController pushViewController:set animated:YES];
        }
        else
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            AdProfileViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"AdProfileViewController"];
            set.Array_LodingPro=AllDataArray;
            [self.navigationController pushViewController:set animated:YES];
            
        }
        
        
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"next"]) {
        
        DiscoverUserProfileinfoViewController * destViewController= segue.destinationViewController;
        destViewController.Array_UserInfo=AllDataArray ;
        
        
        
        
    }
    else if ([segue.identifier isEqualToString:@"nextAd"])
    {
        AdProfileViewController * destViewController= segue.destinationViewController;
        destViewController.Array_LodingPro=AllDataArray ;
    }
}


- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    
    
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
  //  [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}

-(void)updateLabel
{
    [self CommentCommmunication];
}
-(void)TappedImage
{
    if (_BlackViewOne.frame.size.height > bth)
    {
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
    }
    else
    {
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th);
        
    }
    [self.view endEditing:YES];
}
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(IBAction)FlagButton_Acion:(id)sender
{
    
   
    
//    label_caltitle.text=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"eventtitle"];
//    label_callocation.text=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"eventlocation"];
//    label_caltime.text=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"eventdateformat"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MeetupDetailsViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"MeetupDetailsViewController"];
    set.eventidvalue=[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"];
    
    
//    set.Str_Title=[[AllDataArray objectAtIndex:0]valueForKey:@"eventtitle"];
//    set.Str_Location=[[AllDataArray objectAtIndex:0]valueForKey:@"eventlocation"];
//    set.Str_Datetime=[[AllDataArray objectAtIndex:0]valueForKey:@"eventdateformat"];
    
    
    [self.navigationController pushViewController:set animated:YES];
    
}




-(void)Button_calIM_Action:(UIButton *)sender

{
     eventidval=[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"];
    UIButton * button=(UIButton *)sender;
    if(button.isSelected==NO)
    {
    statusval=@"ATTENDING";
 
    }
    else
    {
        statusval=@"UNKNOWN";
  
    }

    
    [self CalenderEvents];
    NSLog(@"Button_calIM_Action calenser button tag==%d",[sender tag]);
    
}
-(void)Button_calcantgo_Action:(UIButton *)sender

{
    
   
     eventidval=[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"];
    
    UIButton * button=(UIButton *)sender;
    if(button.isSelected==NO)
    {
         statusval=@"NOTATTENDING";
        
    }
    else
    {
        statusval=@"UNKNOWN";
    }
    NSLog(@"Button_calcantgo_Action calenser button tag==%d",[sender tag]);
    
   [self CalenderEvents];
}
-(void)Button_Addcalender_Action:(UIButton *)sender

{
    senderTag_Addcalender=[sender tag];
    //NSLog(@"Add my calnder data==%@",[Array_Comment1 objectAtIndex:[sender tag]]);
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError* error){
//            if(!granted)
//            {
//               //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                
//                
//            }
//            else
//            {
    
                EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
                addController.event = [self createEvent:eventStore];
                addController.eventStore = eventStore;
                
                [self presentViewController:addController animated:YES completion:nil];
               addController.editViewDelegate = self;
            //}
        }];
    }
  
    
}
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action{
    if (action ==EKEventEditViewActionCanceled)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (action==EKEventEditViewActionSaved) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(EKEvent*)createEvent:(EKEventStore*)eventStore
{
//    chattype = EVENT;
//    createdate = "2017-06-21 05:58:10";
//    creatorfbid = 1224819434269672;
//    creatorprofilepic = "http://play-date.ae/app/profileimages/defaultboy.jpg";
//    eventdate = "2017-06-23 05:57:58";
//    eventdateformat = "23rd June 2017, 5:57am";
//    eventdescription = Xcgh;
//    eventlocation = Tgc;
//    eventtitle = Ddddf;
//    gender = Boy;
//    imageheight = "";
//    imageurl = "";
//    imagewidth = "";
//    message = Ddddf;
//    msgdate = "2017-06-21 05:58:10";
//    profilepic = "http://play-date.ae/app/profileimages/defaultboy.jpg";
//    senderfbid = 1224819434269672;
//    senderfname = test;
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title =[[Array_Comment1 objectAtIndex:senderTag_Addcalender]valueForKey:@"eventtitle"];
    
//    event.startDate = [[NSDate date] dateByAddingTimeInterval:86400];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currDate1=[df1 dateFromString:[[Array_Comment1 objectAtIndex:senderTag_Addcalender]valueForKey:@"eventdate"]];
   
    
    event.startDate = currDate1;//[[NSDate date] dateByAddingTimeInterval:86400];
    
    // duration = 1 h
    event.endDate = [currDate1 dateByAddingTimeInterval:3600];
    
    event.location=[[Array_Comment1 objectAtIndex:senderTag_Addcalender]valueForKey:@"eventlocation"];;
    event.allDay = NO;
    event.notes =[[Array_Comment1 objectAtIndex:senderTag_Addcalender]valueForKey:@"eventdescription"];;
    
    NSString* calendarName = @"Calendar";
    EKCalendar* calendar;
    EKSource* localSource;
    for (EKSource *source in eventStore.sources){
        if (source.sourceType == EKSourceTypeCalDAV &&
            [source.title isEqualToString:@"iCloud"]){
            localSource = source;
            break;
        }
    }
    if (localSource == nil){
        for (EKSource *source in eventStore.sources){
            if (source.sourceType == EKSourceTypeLocal){
                localSource = source;
                break;
            }
        }
    }
    calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
    calendar.source = localSource;
    calendar.title = calendarName;
    NSError* error;
    [eventStore saveCalendar:calendar commit:YES error:&error];
    return event;
}

-(void)CalenderEvents
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        //        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Please Note" message:@"Internet Connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
        NSString *fbid1Val = [defaults valueForKey:@"fid"];;
        
        NSString *eventid= @"eventid";
        
        
        NSString *status= @"status";
       
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidval,status,statusval];
        
        
        
        
        
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"eventattending"];
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
                                                     
        NSMutableArray * Array_status=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                    
                Array_status= [objSBJsonParser objectWithData:data];
                                
                        NSString * ResultString1=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     ResultString1 = [ResultString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString1 = [ResultString1 stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                            if ([ResultString1 isEqualToString:@"updateerror"])
                                {
                       
                                    
                                  
                            }
                 if (Array_status !=0)
                 {
                                                         
        statusval=[[Array_status objectAtIndex:0]valueForKey:@"attendingstatus"];
        [Table_Friend_chat reloadData];
                     
                }
                                                     
                                                     
//
                            }
                                                 else
                                                 {
                                                     NSLog(@"Error...   %ld",(long)statusCode);
                                                 }
                                                 
                                             }
                                             else if (error)
                                             {
                                                 NSLog(@"flag error=%@",error.description);
                                             }
                                             
                                             
                                             
                                         }];
        
        [dataTask resume];
        
        
        
        
        
    }
    
    
}
-(IBAction)Button_share:(id)sender
{
    
    NSString * texttoshare=[NSString stringWithFormat:@"%@%@%@",@"You have been invited to a Play:Date meet-up!\n\nEnter the event code:\n",[[AllDataArray objectAtIndex:0]valueForKey:@"eventid"],@" to join the meet-up.\n\nDownload Play:Date on your iPhone from http://www.play-date.ae and find new friends for your children!"];
    
    
    NSArray *activityItems1=@[texttoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    [self presentViewController:activityViewControntroller animated:YES completion:nil];
}
#pragma imagezoom...
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return attachmentImageNew;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize imgViewSize = attachmentImageNew.frame.size;
    CGSize imageSize = attachmentImageNew.image.size;
    
    CGSize realImgSize;
    if(imageSize.width / imageSize.height > imgViewSize.width / imgViewSize.height) {
        realImgSize = CGSizeMake(imgViewSize.width, imgViewSize.width / imageSize.width * imageSize.height);
    }
    else {
        realImgSize = CGSizeMake(imgViewSize.height / imageSize.height * imageSize.width, imgViewSize.height);
    }
    
    CGRect fr = CGRectMake(0, 0, 0, 0);
    fr.size = realImgSize;
    attachmentImageNew.frame = fr;
    
    CGSize scrSize = scrollView.frame.size;
    float offx = (scrSize.width > realImgSize.width ? (scrSize.width - realImgSize.width) / 2 : 0);
    float offy = (scrSize.height > realImgSize.height ? (scrSize.height - realImgSize.height) / 2 : 0);
    
    // don't animate the change.
    scrollView.contentInset = UIEdgeInsetsMake(offy, offx, offy, offx);
}
-(void)button_closeview:(UIButton *)sender {
    
    zoomImageview.hidden=YES;
    [zoomImageview removeFromSuperview];
}
/*
 chattype = EVENT;
 createdate = "2017-06-17 05:37:21";
 creatorfbid = 1224819434269672;
 eventdate =     {
 date = "2017-06-25 10:26:00.000000";
 timezone = UTC;
 "timezone_type" = 3;
 };
 eventdateformat = "25th June 2017, 10:26am";
 eventdescription = "Nznznzznbbz bznznsnsn znsnsnnsn nznsnznzn bznznznznnznznznnznz znznsnsnssbnsna snnanananansnannans snsnsnsnsnannana sns nsnsnajsjsjs snansnbsnabsnsnsn sbsnjwjwjwjw snakssnsb snansjjs snanjajanas sbbananab snajs";
 eventid = 8FF6P;
 eventtitle = ZnznB;
 fname = test;
 gender = Boy;
 invitedate = "2017-06-17 05:37:21";
 location = Nznznz;
 message = ZnznB;
 msgdate = "2017-06-17 05:37:21";
 msgread = self;
 profilepic = "http://play-date.ae/app/profileimages/defaultboy.jpg";
 */

@end
