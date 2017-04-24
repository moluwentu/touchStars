//
//  XTTouchView.m
//  星星点着玩
//
//  Created by 叶慧伟 on 16/3/5.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTTouchView.h"
#import "XTMenuView.h"

@interface XTTouchView ()

@property (nonatomic, strong)NSArray *images;

@end

@implementation XTTouchView

- (instancetype)init{
    
    if (self == [super init]) {
        
        self.multipleTouchEnabled = YES;
        
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.backGroundImageView];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *doubleGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClick)];
        
        [doubleGes setNumberOfTapsRequired:2];
        
        [self addGestureRecognizer:doubleGes];
    }
    
    return self;
}

- (void)doubleClick{
    if (self.menuViewBlock) {
        self.menuViewBlock();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[XTMenuView class]]) {
            
            if (self.removeMenuViewBlock) {
                
                self.removeMenuViewBlock();
                
            }
        }
    }
    [self touchAnimationWithTouches:touches];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self touchAnimationWithTouches:touches];
    
}

- (void)touchAnimationWithTouches:(NSSet *)touches{
    
    int i = 0;
    
    for (UITouch *touch in touches) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.images[i]];
        
        imageView.center = [touch locationInView:self];
        
        [self addSubview:imageView];
        
        [UIView animateWithDuration:3 animations:^{
            
            imageView.alpha = 0;
            
        }completion:^(BOOL finished) {
            
            [imageView removeFromSuperview];
            
        }];
        
        i++;
    }

}

#pragma mark --lazyload

- (NSArray *)images{
    
    if (_images == nil) {
        
        _images = @[ [UIImage imageNamed:@"spark_cyan"],
                     [UIImage imageNamed:@"spark_red"],
                     [UIImage imageNamed:@"spark_green"],
                     [UIImage imageNamed:@"spark_magenta"],
                     [UIImage imageNamed:@"spark_red"],
                     [UIImage imageNamed:@"spark_yellow"]];
        
    }
    
    return _images;
}

- (UIImageView *)backGroundImageView{
    
    if (_backGroundImageView == nil) {
        
        _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    }
    
    return _backGroundImageView;
}

@end
