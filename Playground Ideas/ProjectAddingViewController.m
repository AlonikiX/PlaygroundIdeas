//
//  ProjectAddingViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/18.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "ProjectAddingViewController.h"

@interface ProjectAddingViewController ()<UIPickerViewDataSource,UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>{
    NSArray *countries;
    UIImageView *showimg;
}

@end

@implementation ProjectAddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width;
    SCREEN_HEIGHT = UIScreen.mainScreen.bounds.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIScrollView *scollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [scollview setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:scollview];
    
    scollview.contentSize = CGSizeMake(SCREEN_WIDTH,1500);
    scollview.showsVerticalScrollIndicator = NO;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [title setText:@"Project Title"];
    [scollview addSubview:title];
    [title sizeToFit];
    title.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *titletext = [[UITextField alloc]initWithFrame:CGRectMake(20, title.frame.origin.y+title.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    titletext.layer.borderColor = [[UIColor blackColor]CGColor];
    titletext.layer.borderWidth= 1.0f;
    [scollview addSubview:titletext];
    
    UILabel *contry = [[UILabel alloc]initWithFrame:CGRectMake(20, titletext.frame.origin.y+titletext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [contry setText:@"Country"];
    [scollview addSubview:contry];
    [contry sizeToFit];
    contry.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UIPickerView *countrylist = [[UIPickerView alloc]initWithFrame:CGRectMake(20, contry.frame.origin.y+contry.frame.size.height+10, SCREEN_WIDTH-40, 100)];
    countrylist.delegate = self;
    countrylist.dataSource = self;
    //countrylist.backgroundColor = [UIColor grayColor];
    countries = [NSArray arrayWithObjects:@"Australia",@"Canada",@"China",@"India",@"Japan",@"Korea",@"U.K.",@"U.S.A",nil];
    [countrylist reloadAllComponents];
    
    [scollview addSubview:countrylist];
    
    UILabel *descrip = [[UILabel alloc]initWithFrame:CGRectMake(20, countrylist.frame.origin.y+countrylist.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [descrip setText:@"Description"];
    [scollview addSubview:descrip];
    [descrip sizeToFit];
    descrip.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextView *projectdes = [[UITextView alloc]initWithFrame:CGRectMake(20, descrip.frame.origin.y+descrip.frame.size.height+10, SCREEN_WIDTH-40, 100)];
    projectdes.layer.borderColor = [[UIColor blackColor]CGColor];
    projectdes.layer.borderWidth= 1.0f;
    [scollview addSubview:projectdes];
    
    UILabel *stdate = [[UILabel alloc]initWithFrame:CGRectMake(20, projectdes.frame.origin.y+projectdes.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [stdate setText:@"Start Date"];
    [scollview addSubview:stdate];
    [stdate sizeToFit];
    stdate.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UIDatePicker *startdata = [[UIDatePicker alloc]initWithFrame:CGRectMake(20, stdate.frame.origin.y+stdate.frame.size.height+10, SCREEN_WIDTH-40, 100)];
    startdata.datePickerMode = UIDatePickerModeDate;
    [scollview addSubview:startdata];
    
    UILabel *endate = [[UILabel alloc]initWithFrame:CGRectMake(20, startdata.frame.origin.y+startdata.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [endate setText:@"End Date"];
    [scollview addSubview:endate];
    [endate sizeToFit];
    endate.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UIDatePicker *enddata = [[UIDatePicker alloc]initWithFrame:CGRectMake(20, endate.frame.origin.y+endate.frame.size.height+10, SCREEN_WIDTH-40, 100)];
    enddata.datePickerMode = UIDatePickerModeDate;
    [scollview addSubview:enddata];
    
    UILabel *youvideo = [[UILabel alloc]initWithFrame:CGRectMake(20, enddata.frame.origin.y+enddata.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [youvideo setText:@"Featured Youtube Video"];
    [scollview addSubview:youvideo];
    [youvideo sizeToFit];
    youvideo.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *videotext = [[UITextField alloc]initWithFrame:CGRectMake(20, youvideo.frame.origin.y+youvideo.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    videotext.layer.borderColor = [[UIColor blackColor]CGColor];
    videotext.layer.borderWidth= 1.0f;
    [scollview addSubview:videotext];
    
    UILabel *loadimg = [[UILabel alloc]initWithFrame:CGRectMake(20, videotext.frame.origin.y+videotext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [loadimg setText:@"Featured Image"];
    [scollview addSubview:loadimg];
    [loadimg sizeToFit];
    loadimg.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    /* [showimg setFrame:CGRectMake(20,loadimg.frame.origin.y+loadimg.frame.size.height+10, SCREEN_WIDTH-40, 40)];
     
     [scollview addSubview:showimg];
     */
    UILabel *loadgly = [[UILabel alloc]initWithFrame:CGRectMake(20, loadimg.frame.origin.y+loadimg.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [loadgly setText:@"Project Image Gallery"];
    [scollview addSubview:loadgly];
    [loadgly sizeToFit];
    loadgly.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UILabel *fb = [[UILabel alloc]initWithFrame:CGRectMake(20, loadgly.frame.origin.y+loadgly.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [fb setText:@"Facebook"];
    [scollview addSubview:fb];
    [fb sizeToFit];
    fb.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *fbtext = [[UITextField alloc]initWithFrame:CGRectMake(20, fb.frame.origin.y+fb.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    fbtext.layer.borderColor = [[UIColor blackColor]CGColor];
    fbtext.layer.borderWidth= 1.0f;
    [scollview addSubview:fbtext];
    
    UILabel *twitter = [[UILabel alloc]initWithFrame:CGRectMake(20, fbtext.frame.origin.y+fbtext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [twitter setText:@"Twitter"];
    [scollview addSubview:twitter];
    [twitter sizeToFit];
    twitter.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *tweettext = [[UITextField alloc]initWithFrame:CGRectMake(20, twitter.frame.origin.y+twitter.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    tweettext.layer.borderColor = [[UIColor blackColor]CGColor];
    tweettext.layer.borderWidth= 1.0f;
    [scollview addSubview:tweettext];
    
    UILabel *google = [[UILabel alloc]initWithFrame:CGRectMake(20, tweettext.frame.origin.y+tweettext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [google setText:@"Google+"];
    [scollview addSubview:google];
    [google sizeToFit];
    google.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *googletext = [[UITextField alloc]initWithFrame:CGRectMake(20, google.frame.origin.y+google.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    googletext.layer.borderColor = [[UIColor blackColor]CGColor];
    googletext.layer.borderWidth= 1.0f;
    [scollview addSubview:googletext];
    
    UILabel *pinter = [[UILabel alloc]initWithFrame:CGRectMake(20, googletext.frame.origin.y+googletext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [pinter setText:@"Pinterest"];
    [scollview addSubview:pinter];
    [pinter sizeToFit];
    pinter.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *pintertext = [[UITextField alloc]initWithFrame:CGRectMake(20, pinter.frame.origin.y+pinter.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    pintertext.layer.borderColor = [[UIColor blackColor]CGColor];
    pintertext.layer.borderWidth= 1.0f;
    [scollview addSubview:pintertext];
    
    UILabel *linkein = [[UILabel alloc]initWithFrame:CGRectMake(20, pintertext.frame.origin.y+pintertext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [linkein setText:@"Linkedlin"];
    [scollview addSubview:linkein];
    [linkein sizeToFit];
    linkein.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *linkdntext = [[UITextField alloc]initWithFrame:CGRectMake(20, linkein.frame.origin.y+linkein.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    linkdntext.layer.borderColor = [[UIColor blackColor]CGColor];
    linkdntext.layer.borderWidth= 1.0f;
    [scollview addSubview:linkdntext];
    
    UILabel *youtube = [[UILabel alloc]initWithFrame:CGRectMake(20, linkdntext.frame.origin.y+linkdntext.frame.size.height+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [youtube setText:@"Youtube"];
    [scollview addSubview:youtube];
    [youtube sizeToFit];
    youtube.font = [UIFont fontWithName:@"Sinibold" size:17.0f];
    
    UITextField *yoututext = [[UITextField alloc]initWithFrame:CGRectMake(20, youtube.frame.origin.y+youtube.frame.size.height+10, SCREEN_WIDTH-40, 40)];
    yoututext.layer.borderColor = [[UIColor blackColor]CGColor];
    yoututext.layer.borderWidth= 1.0f;
    [scollview addSubview:yoututext];
    
    UIButton *draft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    draft.frame = CGRectMake(20,yoututext.frame.origin.y+yoututext.frame.size.height+20, SCREEN_WIDTH/2-30, 40);
    draft.backgroundColor = [UIColor colorWithRed:37/255.0 green:192/255.0 blue:23/255.0 alpha:1.0];
    [draft setTitle:@"SAVE DRAFT" forState:UIControlStateNormal];
    [draft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    draft.titleLabel.font = [UIFont systemFontOfSize:20];
    [scollview addSubview:draft];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame = CGRectMake(20+draft.frame.size.width+20,yoututext.frame.origin.y+yoututext.frame.size.height+20, SCREEN_WIDTH/2-30, 40);
    submit.backgroundColor = [UIColor colorWithRed:37/255.0 green:192/255.0 blue:23/255.0 alpha:1.0];
    [submit setTitle:@"SAVE & SUBMIT" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont systemFontOfSize:20];
    [scollview addSubview:submit];
    [submit addTarget:self action:@selector(addProject) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addProject {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addNewProject" object:self];
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return countries.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [countries objectAtIndex:row];
}


@end
