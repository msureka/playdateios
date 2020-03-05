//
//  ContactAddTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 5/19/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ContactAddTableViewCell.h"

@implementation ContactAddTableViewCell
@synthesize image_profile_img;
- (void)awakeFromNib {
    [super awakeFromNib];
    image_profile_img.clipsToBounds=YES;
    image_profile_img.layer.cornerRadius=image_profile_img.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
