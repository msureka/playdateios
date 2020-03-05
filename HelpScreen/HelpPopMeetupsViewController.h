//
//  HelpPopMeetupsViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 7/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpPopMeetupsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *Image_join;
@property (weak, nonatomic) IBOutlet UILabel *Label_join;
@property (weak, nonatomic) IBOutlet UILabel *Label_create;
@property (weak, nonatomic) IBOutlet UIImageView *image_create;
@property(nonatomic,strong)IBOutlet UIButton * Button_Next;
@property(nonatomic,strong)IBOutlet UILabel * Label_title;
@property(nonatomic,strong)IBOutlet UILabel * Label_Description;
@property(nonatomic,strong)IBOutlet UIView * View_Frame;
@end
