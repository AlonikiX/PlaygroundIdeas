//
//  PlansEditViewController.m
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/18.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import "PlansEditViewController.h"

@interface PlansEditViewController ()

@end

@implementation PlansEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect bounds = [[UIScreen mainScreen]applicationFrame];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:bounds];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSURL* url = [NSURL URLWithString:@"https://playgroundideas.org/designer/app.php?userId=108597"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
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
