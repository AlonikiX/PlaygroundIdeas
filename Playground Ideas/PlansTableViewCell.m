//
//  PlansTableViewCell.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/15.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "PlansTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation PlansTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    float SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(5, 2.5, SCREEN_WIDTH-10, SCREEN_WIDTH-5)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:backView];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 0.75*(SCREEN_WIDTH-10))];
        [backView addSubview:imageView];
        
        title = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, SCREEN_WIDTH, 0.125*SCREEN_WIDTH)];
        title.textAlignment = UITextAlignmentCenter;
        [backView addSubview:title];
        
        creator = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.825*SCREEN_WIDTH, SCREEN_WIDTH, 0.125*SCREEN_WIDTH)];
        creator.textAlignment = UITextAlignmentCenter;
        [backView addSubview:creator];
    }
    return self;
}

- (void)setData:(NSString *)picURL
          title:(NSString *)titleStr
        creator:(NSString *)creatorStr {
    [imageView setImageWithURL:[NSURL URLWithString:picURL]];
    [title setText:titleStr];
    [creator setText:[@"Creator: " stringByAppendingString:creatorStr]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
