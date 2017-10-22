//
//  PlansTableViewCell.h
//  Playground Ideas
//
//  Created by 孙士博 on 2017/10/15.
//  Copyright © 2017年 PlaygroundIdeasQuoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlansTableViewCell : UITableViewCell {
    UIImageView *imageView;
    UILabel *title;
    UILabel *creator;
}

- (void)setData:(NSString *)picURL
          title:(NSString *)titleStr
        creator:(NSString *)creatorStr;

@end
