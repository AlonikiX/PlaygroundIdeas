//
//  PlansDetailViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/15.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "PlansDetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "PlansEditViewController.h"

@interface PlansDetailViewController ()

@end

@implementation PlansDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width;
    SCREEN_HEIGHT = UIScreen.mainScreen.bounds.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self loadScrollView];
    
}

- (void)loadScrollView {
    if (mainView == nil) {
        mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:mainView];
        mainView.showsHorizontalScrollIndicator = NO;
        mainView.showsVerticalScrollIndicator = NO;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.75*SCREEN_WIDTH)];
        [imageView setImageWithURL:[NSURL URLWithString:[_detailDic objectForKey:@"picURL"]]];
        [mainView addSubview:imageView];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, SCREEN_WIDTH, SCREEN_WIDTH/6)];
        [title setText:[_detailDic objectForKey:@"title"]];
        [mainView addSubview:title];
        
        UILabel *creator = [[UILabel alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height, SCREEN_WIDTH, SCREEN_WIDTH/7)];
        [creator setText:[@"Creator:  " stringByAppendingString:[_detailDic objectForKey:@"creator"]]];
        [mainView addSubview:creator];
        
        UILabel *descritionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, creator.frame.origin.y+creator.frame.size.height, SCREEN_WIDTH, 300)];
        NSString * desText = @"This is a sanctuary for creative play, decorated with community art that will inspire and capture the imagination of people of all ages and all abilities. Children and people young at heart will love exploring Wombat Bend, with sensory play activities, accessible path networks, picnic area, maze, swings, slides, climbing cube, amphitheatre, flying fox, carousel and native forest walk.";
        descritionLabel.text = desText;
        descritionLabel.font = [UIFont systemFontOfSize:20];
        descritionLabel.lineBreakMode = NSLineBreakByTruncatingHead;
        descritionLabel.numberOfLines = 0;
        CGSize contanSize = CGSizeMake(SCREEN_WIDTH, 400);
        CGRect autoRect = [desText boundingRectWithSize:contanSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:descritionLabel.font} context:nil];
        descritionLabel.frame = CGRectMake(0, creator.frame.origin.y+creator.frame.size.height, SCREEN_WIDTH, autoRect.size.height);
        [mainView addSubview:descritionLabel];
        
        UIButton *deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, descritionLabel.frame.origin.y+descritionLabel.frame.size.height, (SCREEN_WIDTH-30)/2, 40)];
        [deleBtn setTitle:@"DELETE" forState:UIControlStateNormal];
        [deleBtn setBackgroundColor:[UIColor colorWithRed:235/255.0 green:171/255.0 blue:92/255.0 alpha:1.0]];
        [deleBtn addTarget:self action:@selector(delePlan) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+(SCREEN_WIDTH-30)/2, descritionLabel.frame.origin.y+descritionLabel.frame.size.height, (SCREEN_WIDTH-30)/2, 40)];
        [editBtn setTitle:@"EDIT" forState:UIControlStateNormal];
        [editBtn setBackgroundColor:[UIColor colorWithRed:223/255.0 green:58/255.0 blue:136/255.0 alpha:1.0]];
        [editBtn addTarget:self action:@selector(editPlans) forControlEvents:UIControlEventTouchUpInside];
        
        [mainView addSubview:deleBtn];
        [mainView addSubview:editBtn];
        
         mainView.contentSize = CGSizeMake(SCREEN_WIDTH,deleBtn.frame.origin.y+deleBtn.frame.size.height+100);
        
    }
}

- (void)editPlans {
    PlansEditViewController *editVC = [[PlansEditViewController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)delePlan {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"delePlan" object:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
