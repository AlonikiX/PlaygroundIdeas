//
//  ProjectViewcontroller.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/14.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "ProjectViewcontroller.h"
#import "ProjectTableViewCell.h"
#import "ProjectDetailViewController.h"
#import "ProjectAddingViewController.h"

@interface ProjectViewcontroller ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControl;

@end

@implementation ProjectViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCREEN_WIDTH=UIScreen.mainScreen.bounds.size.width;
    SCREEN_HEIGHT=UIScreen.mainScreen.bounds.size.height;
    
    //fake data
    NSDictionary *dataDic = @{@"picURL":@"https://srpplayground.com/sites/default/files/styles/dynamic_tab/public/projects/20161024_Superior%20Recreational%20Products_0135_WEB.jpg?itok=tm3LgoV2",
                                 @"title":@"Discovery Playscape",
                                 @"location":@"Melbourne",
                                 @"funded":@"12.25",
                                 @"pledged":@"20000",
                                 @"daytogo":@"23",
                              @"isMine":@"NO"
                              };
    
    _dataArr = [[NSMutableArray alloc]initWithObjects:dataDic,dataDic,dataDic,dataDic,dataDic,dataDic,dataDic, nil];
    
    _dataArrIndex = [[NSMutableArray alloc]init];
    
    [_SegmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self loadTableView];
    
    _SegmentedControl.selectedSegmentIndex = 0;
    
    [self segmentValueChanged:_SegmentedControl];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewProject) name:@"addNewProject" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleProject) name:@"deleProject" object:nil];
}

- (void)addNewProject {
    NSDictionary *dataDic = @{@"picURL":@"https://srpplayground.com/sites/default/files/styles/dynamic_tab/public/projects/20161024_Superior%20Recreational%20Products_0135_WEB.jpg?itok=tm3LgoV2",
                              @"title":@"Discovery Playscape",
                              @"location":@"Melbourne",
                              @"funded":@"12.25",
                              @"pledged":@"20000",
                              @"daytogo":@"23",
                              @"isMine":@"YES"
                              };
    [_dataArr addObject:dataDic];
    _SegmentedControl.selectedSegmentIndex = 0;
    [self segmentValueChanged:_SegmentedControl];
}

- (void)loadTableView {
    if (projectTable == nil) {
        projectTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        [projectTable setBackgroundColor: [UIColor colorWithRed:241.0/255 green:241.0/255  blue:243.0/255 alpha:1.0f]];
        projectTable.delegate = self;
        projectTable.dataSource = self;
        projectTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:projectTable];
        projectTable.rowHeight = 1.2 * SCREEN_WIDTH;
    }
    else {
        [projectTable reloadData];
    }
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
                [addBtn setTitle:@"ADD PROJECT" forState:UIControlStateNormal];
                [addBtn setCenter:self.view.center];
                [addBtn.layer setCornerRadius:10.0];
                [addBtn addTarget:self action:@selector(addProject) forControlEvents:UIControlEventTouchUpInside];
                [projectTable addSubview:addBtn];
                
                noTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 170, 80)];
                [noTitle setText:@"Why not create your first project?"];
                [noTitle setCenter:CGPointMake(self.view.center.x, self.view.center.y-80)];
                noTitle.numberOfLines = 2;
                [projectTable addSubview:noTitle];
            }
            else {
                if (header == nil) {
                    header = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
                    projectTable.tableHeaderView = header;
                    [header setTitle:@"ADD PROJECT" forState:UIControlStateNormal];
                    [header setBackgroundColor:[UIColor colorWithRed:68/255.0 green:176/255.0 blue:206/255.0 alpha:1.0]];
                    [header addTarget:self action:@selector(addProject) forControlEvents:UIControlEventTouchUpInside];
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

//table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArrIndex count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"projectCell";
    ProjectTableViewCell *cell = [projectTable dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSDictionary *dic = _dataArrIndex[indexPath.row];
    
    [cell setData:[dic objectForKey:@"picURL"] title:[dic objectForKey:@"title"] location:[dic objectForKey:@"location"] funded:[dic objectForKey:@"funded"] pledged:[dic objectForKey:@"pledged"] daytogo:[dic objectForKey:@"daytogo"]];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _dataArrIndex[indexPath.row];
    ProjectDetailViewController *detailVC = [[ProjectDetailViewController alloc]init];
    detailVC.detailDic = dic;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)addProject {
    ProjectAddingViewController *addVC = [[ProjectAddingViewController alloc]init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)deleProject {
    NSDictionary *dataDic = @{@"picURL":@"https://srpplayground.com/sites/default/files/styles/dynamic_tab/public/projects/20161024_Superior%20Recreational%20Products_0135_WEB.jpg?itok=tm3LgoV2",
                              @"title":@"Discovery Playscape",
                              @"location":@"Melbourne",
                              @"funded":@"12.25",
                              @"pledged":@"20000",
                              @"daytogo":@"23",
                              @"isMine":@"YES"
                              };
    [_dataArr removeObject:dataDic];
    _SegmentedControl.selectedSegmentIndex = 0;
    [self segmentValueChanged:_SegmentedControl];
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
