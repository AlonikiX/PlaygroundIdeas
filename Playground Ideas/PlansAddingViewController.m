//
//  PlansAddingViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/18.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "PlansAddingViewController.h"

@interface PlansAddingViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray *pubselect;}

@end

@implementation PlansAddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width;
    SCREEN_HEIGHT = UIScreen.mainScreen.bounds.size.height;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:view];
    
    UILabel *plantitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [plantitle setText:@"Plan Title"];
    [view addSubview:plantitle];
    [plantitle sizeToFit];
    plantitle.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *titletext = [[UITextField alloc]initWithFrame:CGRectMake(20, plantitle.frame.origin.y+plantitle.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    titletext.layer.borderColor = [[UIColor blackColor]CGColor];
    titletext.layer.borderWidth= 1.0f;
    [view addSubview:titletext];
    
    UILabel *pubprv = [[UILabel alloc]initWithFrame:CGRectMake(20, titletext.frame.origin.y+titletext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [pubprv setText:@"Public/Private"];
    [view addSubview:pubprv];
    [pubprv sizeToFit];
    pubprv.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UIPickerView *publist = [[UIPickerView alloc]initWithFrame:CGRectMake(20, pubprv.frame.origin.y+pubprv.frame.size.height+10, SCREEN_WIDTH-40, 100)];
    publist.delegate = self;
    publist.dataSource = self;
    
    pubselect = [NSArray arrayWithObjects:@"Private",@"Public",nil];
    [publist reloadAllComponents];
    
    [view addSubview:publist];
    
    UILabel *descrip = [[UILabel alloc]initWithFrame:CGRectMake(20, publist.frame.origin.y+publist.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [descrip setText:@"Description"];
    [view addSubview:descrip];
    [descrip sizeToFit];
    descrip.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextView *projectdes = [[UITextView alloc]initWithFrame:CGRectMake(20, descrip.frame.origin.y+descrip.frame.size.height+10, SCREEN_WIDTH-40, 100)];
    projectdes.layer.borderColor = [[UIColor blackColor]CGColor];
    projectdes.layer.borderWidth= 1.0f;
    [view addSubview:projectdes];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame = CGRectMake(20,SCREEN_HEIGHT-200, SCREEN_WIDTH-40, 40);
    submit.backgroundColor =  [UIColor colorWithRed:250/255.0 green:173/255.0 blue:51/255.0 alpha:1];
    [submit setTitle:@"CREATE PLAN" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont systemFontOfSize:20];
    [submit addTarget:self action:@selector(addPlans) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:submit];
    
}

- (void) addPlans {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addNewPlans" object:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    return pubselect.count;
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return [pubselect objectAtIndex:row];
}

@end
