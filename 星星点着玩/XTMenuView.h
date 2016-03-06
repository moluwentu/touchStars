//
//  XTMenuView.h
//  星星点着玩
//
//  Created by 叶慧伟 on 16/3/5.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTMenuView : UIView

@property (nonatomic, copy)void(^changBackGroundBlock)();
@property (nonatomic, copy)void(^saveBlock)();

@end
