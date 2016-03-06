//
//  XTTouchView.h
//  星星点着玩
//
//  Created by 叶慧伟 on 16/3/5.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTTouchView : UIView

@property (nonatomic, copy)void(^menuViewBlock)();
@property (nonatomic, copy)void(^removeMenuViewBlock)();
@property (nonatomic, strong)UIImageView *backGroundImageView;

@end
