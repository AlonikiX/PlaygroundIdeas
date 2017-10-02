//
//  DesignViewController.h
//  Playground Ideas
//
//  Created by 孙士博 on 2017/9/16.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesignViewController : UIViewController {
    float SCREEN_WIDTH;
    float SCREEN_HEIGHT;
    UITableView *designTable;
    UILabel *noTitle;
    UIButton *addBtn;
    UIView *popView;
    
}

@property NSMutableArray *dataArr;
@property NSMutableArray *dataArrIndex;


@end
