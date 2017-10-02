//
//  DesignTableViewCell.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/9/13.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "DesignTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "DesignDetailViewController.h"

@implementation DesignTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToFavorite) name:@"goToFavourite" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToAll) name:@"goToAll" object:nil];
    
    float SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width;
    //float SCREEN_HEIGHT = UIScreen.mainScreen.bounds.size.height;
    float picWidth = SCREEN_WIDTH/15*6;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/15, SCREEN_WIDTH/15, picWidth, picWidth)];
        [self.contentView addSubview:imageView1];
        imageView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [imageView1 addGestureRecognizer:firstTap];
        
        imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/15*8, SCREEN_WIDTH/15, picWidth, picWidth)];
        [self.contentView addSubview:imageView2];
        imageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *secondTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [imageView2 addGestureRecognizer:secondTap];
        
        btn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, picWidth-40, picWidth-40, 30)];
        btn1.backgroundColor = [UIColor colorWithRed:237.0/255 green:175.0/255  blue:79.0/255 alpha:1.0f];
        [btn1.layer setCornerRadius:10.0];
        [btn1 setTitle:@"+Add to favorite" forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        [btn1 addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [imageView1 addSubview:btn1];
        
        btn2 = [[UIButton alloc]initWithFrame:CGRectMake(20, picWidth-40, picWidth-40, 30)];
        btn2.backgroundColor = [UIColor colorWithRed:237.0/255 green:175.0/255  blue:79.0/255 alpha:1.0f];
        [btn2.layer setCornerRadius:10.0];
        [btn2 setTitle:@"+Add to favorite" forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        [btn2 addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [imageView2 addSubview:btn2];
        
        title1 = [[UILabel alloc]initWithFrame:CGRectMake(30, picWidth/2-60, picWidth-60, 40)];
         title1.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255  blue:243.0/255 alpha:0.8f];
        [title1.layer setCornerRadius:20.0];
        title1.layer.masksToBounds = YES;
        [title1 setText:@"TITLE"];
        title1.textAlignment = NSTextAlignmentCenter;
        [imageView1 addSubview:title1];
        
        title2 = [[UILabel alloc]initWithFrame:CGRectMake(30, picWidth/2-60, picWidth-60, 40)];
        title2.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255  blue:243.0/255 alpha:0.8f];
        [title2.layer setCornerRadius:20.0];
        title2.layer.masksToBounds = YES;
        [title2 setText:@"TITLE"];
        title2.textAlignment = NSTextAlignmentCenter;
        [imageView2 addSubview:title2];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setData:(NSDictionary *)dictionary1
    dictionary2:(NSDictionary *)dictionary2 {
    imageView1.hidden = NO;
    imageView2.hidden = NO;
    if ([dictionary2 objectForKey:@"title"] == nil){
        imageView2.hidden = YES;
    }
    else {
        [imageView2 setImageWithURL:[NSURL URLWithString:[dictionary2 objectForKey:@"picURL"]]];
        
        [title2 setText:[dictionary2 objectForKey:@"title"]];
        
        if ([[dictionary2 objectForKey:@"isFavorite"] isEqualToString:@"YES"]) {
            if ([btn2.currentTitle isEqualToString:@"+Add to favorite"]) {
                btn2.hidden = YES;
            }
            else {
                btn2.hidden = NO;
            }
        }
    }
    [imageView1 setImageWithURL:[NSURL URLWithString:[dictionary1 objectForKey:@"picURL"]]];
    
    [title1 setText:[dictionary1 objectForKey:@"title"]];
    
    if ([[dictionary1 objectForKey:@"isFavorite"] isEqualToString:@"YES"]) {
        if ([btn1.currentTitle isEqualToString:@"+Add to favorite"]) {
            btn1.hidden = YES;
        }
        else {
            btn1.hidden = NO;
        }
    }
}

- (void)goToFavorite {
    [btn1 setTitle:@"-Remove Design" forState:UIControlStateNormal];
    [btn2 setTitle:@"-Remove Design" forState:UIControlStateNormal];
}

- (void)goToAll {
    [btn1 setTitle:@"+Add to favorite" forState:UIControlStateNormal];
    [btn2 setTitle:@"+Add to favorite" forState:UIControlStateNormal];
}

- (void)addAction {
    if ([btn1.currentTitle isEqualToString:@"+Add to favorite"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addToFavourite" object:self userInfo:nil];
        
    }
    else {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"removeFavourite" object:self userInfo:nil];
    }
    
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"detailNotification" object:self userInfo:nil];
//    DesignDetailViewController *detailController = [[DesignDetailViewController alloc]init];
//    [self.navigationController pushViewController:detailController animated:YES];
    
    //do something....
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
