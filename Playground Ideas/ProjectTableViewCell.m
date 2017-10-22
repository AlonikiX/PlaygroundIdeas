//
//  ProjectTableViewCell.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/14.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "ProjectTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation ProjectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    float SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(5, 2.5, SCREEN_WIDTH-10, 1.2*SCREEN_WIDTH-5)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:backView];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 0.75*(SCREEN_WIDTH-10))];
        [backView addSubview:imageView];
        
        title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.75*(SCREEN_WIDTH-10), SCREEN_WIDTH-10, 0.3*(0.45*SCREEN_WIDTH-12.5))];
        [backView addSubview:title];
        
        location = [[UILabel alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height, SCREEN_WIDTH-10, 0.2*(0.45*SCREEN_WIDTH-12.5))];
        [backView addSubview:location];
        
        funded = [[UILabel alloc]initWithFrame:CGRectMake(0, location.frame.origin.y+location.frame.size.height, (SCREEN_WIDTH-10)/3, 0.3*(0.45*SCREEN_WIDTH-12.5))];
        funded.textAlignment = UITextAlignmentCenter;
        [backView addSubview:funded];
        
        pledged = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3, location.frame.origin.y+location.frame.size.height, (SCREEN_WIDTH-10)/3, 0.3*(0.45*SCREEN_WIDTH-12.5))];
        pledged.textAlignment = UITextAlignmentCenter;
        [backView addSubview:pledged];
        
        daytogo = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3*2, location.frame.origin.y+location.frame.size.height, (SCREEN_WIDTH-10)/3, 0.3*(0.45*SCREEN_WIDTH-12.5))];
        daytogo.textAlignment = UITextAlignmentCenter;
        [backView addSubview:daytogo];
        
        UILabel *fundedLb = [[UILabel alloc]initWithFrame:CGRectMake(0, funded.frame.origin.y+funded.frame.size.height, (SCREEN_WIDTH-10)/3, 0.2*(0.45*SCREEN_WIDTH-12.5))];
        [fundedLb setText:@"funded"];
        fundedLb.textAlignment = UITextAlignmentCenter;
        [backView addSubview:fundedLb];
        
        UILabel *pledgedLb = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3, funded.frame.origin.y+funded.frame.size.height, (SCREEN_WIDTH-10)/3, 0.2*(0.45*SCREEN_WIDTH-12.5))];
        [pledgedLb setText:@"pledged"];
        pledgedLb.textAlignment = UITextAlignmentCenter;
        [backView addSubview:pledgedLb];
        
        UILabel *daytogoLb = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3*2, funded.frame.origin.y+funded.frame.size.height, (SCREEN_WIDTH-10)/3, 0.2*(0.45*SCREEN_WIDTH-12.5))];
        daytogoLb.textAlignment = UITextAlignmentCenter;
        [daytogoLb setText:@"day to go"];
        [backView addSubview:daytogoLb];
        
    }
    return self;
}

- (void)setData:(NSString *)picURL
          title:(NSString *)titleStr
       location:(NSString *)locationStr
         funded:(NSString *)fundedStr
        pledged:(NSString *)pledgedStr
        daytogo:(NSString *)daytogoStr{
    [imageView setImageWithURL:[NSURL URLWithString:picURL]];
    [title setText:titleStr];
    [location setText:locationStr];
    [funded setText:[fundedStr stringByAppendingString:@"%"]];
    [pledged setText:pledgedStr];
    [daytogo setText:daytogoStr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
