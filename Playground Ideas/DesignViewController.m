//
//  DesignViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/9/16.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "DesignViewController.h"
#import "DesignTableViewCell.h"
#import "DesignDetailViewController.h"

@interface DesignViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControl;
@end

@implementation DesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dataDicTest = @{@"title":@"DesignTitle",
                              @"isFavorite":@"NO",
                             @"pdfURL":@"https://playgroundideas.org/wp-content/uploads/design_step/Scoop%20and%20Shaft.PlaygroundIdeas.pdf",
                             @"picURL":@"http://ww1.prweb.com/prfiles/2012/09/05/9871481/gI_115718_2.jpg"};
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDicTest];
    
    _dataArr = [[NSMutableArray alloc]initWithObjects:dataDic,dataDic,dataDic,dataDic,dataDic,dataDic,dataDic, nil];
    _dataArrIndex = [[NSMutableArray alloc]init];
    
    SCREEN_WIDTH=UIScreen.mainScreen.bounds.size.width;
    SCREEN_HEIGHT=UIScreen.mainScreen.bounds.size.height;
    
    [self loadTableView];
    
    // Do any additional setup after loading the view.
    [_SegmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _SegmentedControl.selectedSegmentIndex = 0;
    
    [self segmentValueChanged:_SegmentedControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toDetail:) name:@"detailNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addToFavourite:) name:@"addToFavourite" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeFavourite) name:@"removeFavourite" object:nil];
    
}

- (void)removeFavourite {
    NSDictionary *dataDicTest = @{@"title":@"DesignTitle",
                                  @"isFavorite":@"NO",
                                  @"pdfURL":@"https://playgroundideas.org/wp-content/uploads/design_step/Scoop%20and%20Shaft.PlaygroundIdeas.pdf",
                                  @"picURL":@"http://ww1.prweb.com/prfiles/2012/09/05/9871481/gI_115718_2.jpg"};
    for (int i =0; i<_dataArr.count; i++) {
        if ([[_dataArr[i] objectForKey:@"isFavorite"] isEqualToString:@"YES"]){
            [_dataArr removeObjectAtIndex:i];
            [_dataArr addObject:dataDicTest];
            _SegmentedControl.selectedSegmentIndex = 0;
            [self segmentValueChanged:_SegmentedControl];

            return;
        }
    }
}

- (void)addToFavourite:(NSNotification *)notification {
    
    popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    [popView setCenter:CGPointMake(self.view.center.x, self.view.center.y-100)];
    [popView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:popView];
    UIButton *addToProjectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 300, 60)];
    [addToProjectBtn setTitle:@"Add to Marcus' Project" forState:UIControlStateNormal];
    [addToProjectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addToProjectBtn addTarget:self action:@selector(cancelPopView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addToFavoriteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 60, 300, 60)];
    [addToFavoriteBtn setTitle:@"Add to Dashboard Favourites" forState:UIControlStateNormal];
    [addToFavoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addToFavoriteBtn addTarget:self action:@selector(addFavourite) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(75, 145, 150, 30)];
    [cancelBtn setTitle:@"CANCELL" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithRed:221.0/255 green:45.0/255  blue:125.0/255 alpha:1.0f]];
    [cancelBtn addTarget:self action:@selector(cancelPopView) forControlEvents:UIControlEventTouchUpInside];
    
    //[cancelBtn setCenter:CGPointMake(popView.center.x, 160)];
    
    [popView addSubview:cancelBtn];
    
    [popView addSubview:addToFavoriteBtn];
    
    [popView addSubview:addToProjectBtn];
    
//    for(int i = 0; i < _dataArr.count; i++) {
//        //NSMutableDictionary *dictionary = _dataArr[i];
//        if ([[_dataArr[i] objectForKey:@"isFavorite"] isEqual:@"NO"]) {
//            [_dataArr[i] setValue:@"YES" forKey:@"isFavorite"];
//            [self loadTableView];
//            return;
//        }
//    }
}

- (void)addFavourite {
    NSDictionary *dataDicTest = @{@"title":@"DesignTitle",
                                  @"isFavorite":@"YES",
                                  @"pdfURL":@"https://playgroundideas.org/wp-content/uploads/design_step/Scoop%20and%20Shaft.PlaygroundIdeas.pdf",
                                  @"picURL":@"http://ww1.prweb.com/prfiles/2012/09/05/9871481/gI_115718_2.jpg"};
    [_dataArr removeObjectAtIndex:0];
    [_dataArr addObject:dataDicTest];
    _SegmentedControl.selectedSegmentIndex = 1;
    [self segmentValueChanged:_SegmentedControl];
    [popView removeFromSuperview];
    
}

- (void)cancelPopView {
    [popView removeFromSuperview];
}

- (void)toDetail:(NSNotification *)notification {
    DesignDetailViewController *detailController = [[DesignDetailViewController alloc]init];
    detailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)loadTableView {
    if (designTable == nil) {
        designTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        designTable.delegate = self;
        designTable.dataSource = self;
        designTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:designTable];
        designTable.rowHeight = SCREEN_WIDTH/15*8;
    }
    else {
        [designTable reloadData];
    }
}

-(void)segmentValueChanged:(UISegmentedControl *)seg {
    [_dataArrIndex removeAllObjects];
    [addBtn removeFromSuperview];
    [noTitle removeFromSuperview];
    switch (seg.selectedSegmentIndex) {
        case 0:
            for (int i = 0 ; i < _dataArr.count; i++) {
                NSDictionary *dictionary = _dataArr[i];
                if ([[dictionary objectForKey:@"isFavorite"] isEqualToString:@"YES"]) {
                    [_dataArrIndex addObject:dictionary];
                }
            }
            if ([_dataArrIndex count] == 0) {
                addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
                [addBtn setBackgroundColor:[UIColor colorWithRed:53.0/255 green:166.0/255  blue:201.0/255 alpha:1.0f]];
                [addBtn setTitle:@"ADD DESIGNS" forState:UIControlStateNormal];
                [addBtn setCenter:self.view.center];
                [addBtn.layer setCornerRadius:10.0];
                [addBtn addTarget:self action:@selector(addDesign) forControlEvents:UIControlEventTouchUpInside];
                [designTable addSubview:addBtn];
                
                noTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 170, 80)];
                [noTitle setText:@"Explore over 150 DIY playground designs"];
                [noTitle setCenter:CGPointMake(self.view.center.x, self.view.center.y-80)];
                noTitle.numberOfLines = 2;
                [designTable addSubview:noTitle];
            }
            [self loadTableView];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"goToFavourite" object:self userInfo:nil];
            break;
        case 1:
            _dataArrIndex = [NSMutableArray arrayWithArray:_dataArr];
            [self loadTableView];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"goToAll" object:self userInfo:nil];
        default:
            break;
    }
}

- (void)addDesign {
    _SegmentedControl.selectedSegmentIndex = 1;
    
    [self segmentValueChanged:_SegmentedControl];
}


//table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_dataArrIndex count]%2 == 1) {
        return [_dataArrIndex count]/2+1;
    }
    else {
        return [_dataArrIndex count]/2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"designCell";
    DesignTableViewCell *cell = [designTable dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DesignTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dictionary1 = [[NSDictionary alloc]init];
    NSDictionary *dictionary2 = [[NSDictionary alloc]init];
    if (_dataArrIndex.count%2 == 0) {
        dictionary1 = _dataArrIndex[indexPath.row*2];
        dictionary2 = _dataArrIndex[indexPath.row*2+1];
    }
    else {
        if (indexPath.row == _dataArrIndex.count/2) {
            dictionary1 = _dataArrIndex[indexPath.row*2];
        }
        else {
            dictionary1 = _dataArrIndex[indexPath.row*2];
            dictionary2 = _dataArrIndex[indexPath.row*2+1];
        }
    }
    
    [cell setData:dictionary1 dictionary2:dictionary2];
    
    return cell;
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
