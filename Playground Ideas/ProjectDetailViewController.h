//
//  ProjectDetailViewController.h
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/14.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDetailViewController : UIViewController {
    float SCREEN_WIDTH;
    float SCREEN_HEIGHT;
    UIScrollView *mainView;
}
@property NSDictionary *detailDic;

@end
