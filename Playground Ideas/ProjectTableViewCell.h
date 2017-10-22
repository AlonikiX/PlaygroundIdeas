//
//  ProjectTableViewCell.h
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/14.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectTableViewCell : UITableViewCell {
    UIImageView *imageView;
    UILabel *title;
    UILabel *location;
    UILabel *funded;
    UILabel *pledged;
    UILabel *daytogo;
}

- (void)setData:(NSString *)picURL
          title:(NSString *)titleStr
       location:(NSString *)locationStr
         funded:(NSString *)fundedStr
        pledged:(NSString *)pledgedStr
        daytogo:(NSString *)daytogoStr;

@end
