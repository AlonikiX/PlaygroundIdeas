//
//  DesignDetailViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/9/14.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "DesignDetailViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface DesignDetailViewController ()

@end

@implementation DesignDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.frame];
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://playgroundideas.org/wp-content/uploads/design_step/Scoop%20and%20Shaft.PlaygroundIdeas.pdf"]]];
    [self.view addSubview:view];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"Download" forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 100, 100);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark   下载报告

////     第一步

//是否下载还是打开文件

- (void)downloadPDF:(NSString *)downloadUrl{
    
    NSArray *array = [downloadUrl componentsSeparatedByString:@"/"]; //从字符/中分隔成多个元素的数组
    
    NSString *file = [array lastObject];
    
    
    
    if ([self isFileExist:file]) {
        
        
        
        //获取Documents 下的文件路径
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *path = [paths objectAtIndex:0];
        
        NSString *pathString = [path stringByAppendingFormat:@"/%@",file];
        
        NSLog(@"path:%@", pathString);
        
        [self loadDocument:pathString];
        
    }else{
        
        //从新下载
        
        [self downloadFile:downloadUrl];
        
    }
    
    
    
}



#pragma mark      第二步    判断沙盒中是否存在此文件



-(BOOL) isFileExist:(NSString *)fileName

{
    
    //获取Documents 下的文件路径
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL result = [fileManager fileExistsAtPath:filePath];
    
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    
    return result;
    
}





//////////    第三步

//下载PDF

- (void)downloadFile:(NSString *)downLoadUrl{
    
    
    
    //__weak typeof(self)weakSelf = self;
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    [DataService downloadTaskWithURL:downLoadUrl completion:^(id result) {
//        
//        NSLog(@"%@",result);
//        
//        
//        
//        NSProgress *downloadProgress = result;
//        
//        
//        
//        if (weakSelf.HUD) {
//            
//            
//            
//            weakSelf.HUD.progress = downloadProgress.fractionCompleted;
//            
//            
//            
//            _HUD.labelText = [NSString stringWithFormat:@"%2.f%%",downloadProgress.fractionCompleted*100];
//            
//            
//            
//        }
//        
//        
//        
//    } filesPath:^(id filesPath) {
//        
//        
//        
//        [_rePortDwn setBackgroundImage:[UIImage imageNamed:@"downLoad"] forState:UIControlStateNormal];
//        
//        //        NSLog(@"%@",filesPath);
//        
//        NSURL*urlString = filesPath;
//        
//        NSString *string = [urlString absoluteString];
//        
//        NSArray *array = [string componentsSeparatedByString:@"/"]; //从字符A中分隔成2个元素的数组
//        
//        NSString *file = [array lastObject];
//        
//        NSLog(@"filePathName = :%@",file);
//        
//        [weakSelf hudTipWillShow:NO];
//        
//        
//        
//    }];
    
    
    
}





///////       第四步

//已经下载了的文件用webview显示

-(void)loadDocument:(NSString *)documentName

{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL fileURLWithPath:documentName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    
    
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
