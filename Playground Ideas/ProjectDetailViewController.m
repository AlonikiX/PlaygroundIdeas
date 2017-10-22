//
//  ProjectDetailViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/14.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ProjectEditingViewController.h"

@interface ProjectDetailViewController () {
    NSString *projectName;
    NSString *projectDescription;
}

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width;
    SCREEN_HEIGHT = UIScreen.mainScreen.bounds.size.height;
    // Do any additional setup after loading the view.
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
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.75*SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH/8)];
        [title setText:[_detailDic objectForKey:@"title"]];
        projectName = [_detailDic objectForKey:@"title"];
        [mainView addSubview:title];
        
        UILabel *location = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.875*SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH/8)];
        [location setText:[_detailDic objectForKey:@"location"]];
        [mainView addSubview:location];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, location.frame.origin.y+location.frame.size.height, SCREEN_WIDTH, SCREEN_WIDTH/4)];
        [bgView setBackgroundColor:[UIColor colorWithRed:241.0/255 green:241.0/255  blue:243.0/255 alpha:1.0f]];
        [mainView addSubview:bgView];
        
        UILabel *funded = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-10)/3, SCREEN_WIDTH/8)];
        funded.textAlignment = UITextAlignmentCenter;
        [funded setText:[[_detailDic objectForKey:@"funded"] stringByAppendingString:@"%"]];
        [bgView addSubview:funded];
        
        UILabel *pledged = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3, 0, (SCREEN_WIDTH-10)/3, SCREEN_WIDTH/8)];
        pledged.textAlignment = UITextAlignmentCenter;
        [pledged setText:[_detailDic objectForKey:@"pledged"]];
        [bgView addSubview:pledged];
        
        UILabel *daytogo = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3*2, 0, (SCREEN_WIDTH-10)/3, SCREEN_WIDTH/8)];
        daytogo.textAlignment = UITextAlignmentCenter;
        [daytogo setText:[_detailDic objectForKey:@"daytogo"]];
        [bgView addSubview:daytogo];
        
        UILabel *fundedLb = [[UILabel alloc]initWithFrame:CGRectMake(0, funded.frame.origin.y+funded.frame.size.height, (SCREEN_WIDTH-10)/3, SCREEN_WIDTH/8)];
        [fundedLb setText:@"funded"];
        fundedLb.textAlignment = UITextAlignmentCenter;
        [bgView addSubview:fundedLb];
        
        UILabel *pledgedLb = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3, funded.frame.origin.y+funded.frame.size.height, (SCREEN_WIDTH-10)/3, SCREEN_WIDTH/8)];
        [pledgedLb setText:@"pledged"];
        pledgedLb.textAlignment = UITextAlignmentCenter;
        [bgView addSubview:pledgedLb];
        
        UILabel *daytogoLb = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-10)/3*2, funded.frame.origin.y+funded.frame.size.height, (SCREEN_WIDTH-10)/3, SCREEN_WIDTH/8)];
        daytogoLb.textAlignment = UITextAlignmentCenter;
        [daytogoLb setText:@"day to go"];
        [bgView addSubview:daytogoLb];
        
        UILabel *lookforFunding = [[UILabel alloc]initWithFrame:CGRectMake(0, bgView.frame.origin.y+bgView.frame.size.height, SCREEN_WIDTH/2, SCREEN_WIDTH/4)];
        [lookforFunding setText:@"Looking for funding"];
        [mainView addSubview:lookforFunding];
        
        UILabel *lookforFunding2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, bgView.frame.origin.y+bgView.frame.size.height, SCREEN_WIDTH/2, SCREEN_WIDTH/4)];
        [lookforFunding2 setText:@"Looking for volunteers"];
        [mainView addSubview:lookforFunding2];
        
        UILabel * descritionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lookforFunding.frame.origin.y+lookforFunding.frame.size.height, SCREEN_WIDTH, 300)];
        NSString * desText = @"This is a sanctuary for creative play, decorated with community art that will inspire and capture the imagination of people of all ages and all abilities. Children and people young at heart will love exploring Wombat Bend, with sensory play activities, accessible path networks, picnic area, maze, swings, slides, climbing cube, amphitheatre, flying fox, carousel and native forest walk.";
        projectDescription = desText;
        descritionLabel.text = desText;
        descritionLabel.font = [UIFont systemFontOfSize:20];
        descritionLabel.lineBreakMode = NSLineBreakByTruncatingHead;
        descritionLabel.numberOfLines = 0;
        CGSize contanSize = CGSizeMake(SCREEN_WIDTH, 400);
        CGRect autoRect = [desText boundingRectWithSize:contanSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:descritionLabel.font} context:nil];
        descritionLabel.frame = CGRectMake(0, lookforFunding.frame.origin.y+lookforFunding.frame.size.height, SCREEN_WIDTH, autoRect.size.height);
        [mainView addSubview:descritionLabel];
        
        UIButton *deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, descritionLabel.frame.origin.y+descritionLabel.frame.size.height, (SCREEN_WIDTH-30)/2, 40)];
        [deleBtn setTitle:@"DELETE" forState:UIControlStateNormal];
        [deleBtn setBackgroundColor:[UIColor colorWithRed:235/255.0 green:171/255.0 blue:92/255.0 alpha:1.0]];
        [deleBtn addTarget:self action:@selector(deleProject) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+(SCREEN_WIDTH-30)/2, descritionLabel.frame.origin.y+descritionLabel.frame.size.height, (SCREEN_WIDTH-30)/2, 40)];
        [editBtn setTitle:@"EDIT" forState:UIControlStateNormal];
        [editBtn setBackgroundColor:[UIColor colorWithRed:223/255.0 green:58/255.0 blue:136/255.0 alpha:1.0]];
        [editBtn addTarget:self action:@selector(editProject) forControlEvents:UIControlEventTouchUpInside];
        
        [mainView addSubview:deleBtn];
        [mainView addSubview:editBtn];
        
        mainView.contentSize = CGSizeMake(SCREEN_WIDTH,deleBtn.frame.origin.y+deleBtn.frame.size.height+20);
    }
    
}

- (void)editProject {
    ProjectEditingViewController *editVC = [[ProjectEditingViewController alloc]init];
    editVC.projectName = projectName;
    editVC.projectDescription = projectDescription;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)deleProject {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"deleProject" object:self];
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
