//
//  PlansViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/15.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "PlansViewController.h"
#import "PlansTableViewCell.h"
#import "PlansDetailViewController.h"
#import "PlansEditViewController.h"
#import "PlansAddingViewController.h"

@interface PlansViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControl;

@end

@implementation PlansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCREEN_WIDTH=UIScreen.mainScreen.bounds.size.width;
    SCREEN_HEIGHT=UIScreen.mainScreen.bounds.size.height;
    
    NSDictionary *dataDic = @{@"picURL":@"http://www.cgrealm.org/u/img/model/2008-11-04_093009.jpg",
                              @"title":@"Magical Land",
                              @"creator":@"Lee Jones",
                              @"isMine":@"NO"
                              };
    _dataArr = [[NSMutableArray alloc]initWithObjects:dataDic,dataDic,dataDic,dataDic,dataDic,dataDic,dataDic, nil];
    _dataArrIndex = [[NSMutableArray alloc]init];
    [_SegmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    [self loadTableView];
    
    _SegmentedControl.selectedSegmentIndex = 0;
    
    [self segmentValueChanged:_SegmentedControl];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewPlans) name:@"addNewPlans" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delePlan) name:@"deleProject" object:nil];
}

- (void)delePlan {
    NSDictionary *dataDic = @{@"picURL":@"http://www.cgrealm.org/u/img/model/2008-11-04_093009.jpg",
                              @"title":@"New Plan",
                              @"creator":@"Eric",
                              @"isMine":@"YES"
                              };
    [_dataArr removeObject:dataDic];
    _SegmentedControl.selectedSegmentIndex = 0;
    
    [self segmentValueChanged:_SegmentedControl];
}

- (void)addNewPlans {
    NSDictionary *dataDic = @{@"picURL":@"http://www.cgrealm.org/u/img/model/2008-11-04_093009.jpg",
                              @"title":@"New Plan",
                              @"creator":@"Eric",
                              @"isMine":@"YES"
                              };
    [_dataArr addObject:dataDic];
    _SegmentedControl.selectedSegmentIndex = 0;
    
    [self segmentValueChanged:_SegmentedControl];
}

- (void)segmentValueChanged:(UISegmentedControl *)seg {
    [header removeFromSuperview];
    header = nil;
    [_dataArrIndex removeAllObjects];
    [addBtn removeFromSuperview];
    [noTitle removeFromSuperview];
    
    switch (seg.selectedSegmentIndex) {
        case 0:
            for (int i = 0; i < _dataArr.count; i++) {
                NSDictionary *dictionary = _dataArr[i];
                if ([[dictionary objectForKey:@"isMine"] isEqualToString:@"YES"]) {
                    [_dataArrIndex addObject:dictionary];
                }
            }
            if ([_dataArrIndex count] == 0) {
                addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
                [addBtn setBackgroundColor:[UIColor colorWithRed:53.0/255 green:166.0/255  blue:201.0/255 alpha:1.0f]];
                [addBtn setTitle:@"ADD PLANS" forState:UIControlStateNormal];
                [addBtn setCenter:self.view.center];
                [addBtn.layer setCornerRadius:10.0];
                [addBtn addTarget:self action:@selector(addPlan) forControlEvents:UIControlEventTouchUpInside];
                [plansTable addSubview:addBtn];
                
                noTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 170, 80)];
                [noTitle setText:@"Why not create your first plans?"];
                [noTitle setCenter:CGPointMake(self.view.center.x, self.view.center.y-80)];
                noTitle.numberOfLines = 2;
                [plansTable addSubview:noTitle];
            }
            else {
                if (header == nil) {
                    header = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
                    plansTable.tableHeaderView = header;
                    [header setTitle:@"ADD PLANS" forState:UIControlStateNormal];
                    [header setBackgroundColor:[UIColor colorWithRed:68/255.0 green:176/255.0 blue:206/255.0 alpha:1.0]];
                    [header addTarget:self action:@selector(addPlan) forControlEvents:UIControlEventTouchUpInside];
                }
            }
            [self loadTableView];
            break;
            
        case 1:
            _dataArrIndex = [NSMutableArray arrayWithArray:_dataArr];
            [self loadTableView];
            break;
            
        default:
            break;
    }
}

- (void)loadTableView {
    if (plansTable == nil) {
        plansTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStylePlain];
        [plansTable setBackgroundColor: [UIColor colorWithRed:241.0/255 green:241.0/255  blue:243.0/255 alpha:1.0f]];
        plansTable.delegate = self;
        plansTable.dataSource = self;
        plansTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:plansTable];
        plansTable.rowHeight = SCREEN_WIDTH;
    }
    else {
        [plansTable reloadData];
    }
}

//table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArrIndex count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"plansCell";
    PlansTableViewCell *cell = [plansTable dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PlansTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSDictionary *dic = _dataArrIndex[indexPath.row];
    
    [cell setData:[dic objectForKey:@"picURL"] title:[dic objectForKey:@"title"] creator:[dic objectForKey:@"creator"]];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _dataArr[indexPath.row];
    PlansDetailViewController *detailVC = [[PlansDetailViewController alloc]init];
    detailVC.detailDic = dic;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
//    PlansEditViewController *editVC = [[PlansEditViewController alloc]init];
//    editVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:editVC animated:YES];
    
}

- (void)addPlan {
    PlansAddingViewController *addVC = [[PlansAddingViewController alloc]init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
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
