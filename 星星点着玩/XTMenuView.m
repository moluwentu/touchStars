//
//  XTMenuView.m
//  星星点着玩
//
//  Created by 叶慧伟 on 16/3/5.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTMenuView.h"

@interface XTMenuView ()

@property (nonatomic, strong)UIButton *changBackGroundBtn;
@property (nonatomic, strong)UIButton *savaBtn;

@end

@implementation XTMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.changBackGroundBtn];
    
    [self addSubview:self.savaBtn];
}

- (void)changBackGroundBtnClick{
    
    if (self.changBackGroundBlock) {
        
        self.changBackGroundBlock();
    }
}

- (void)savaBtnClick{
    
    if (self.saveBlock) {
        
        self.saveBlock();
    }
}

- (UIButton *)changBackGroundBtn{
    
    if (_changBackGroundBtn == nil) {
        
        _changBackGroundBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height)];
        
        _changBackGroundBtn.backgroundColor = [UIColor darkGrayColor];
        
        [_changBackGroundBtn setTitle:@"更换背景" forState:UIControlStateNormal];
        
        [_changBackGroundBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [_changBackGroundBtn addTarget:self action:@selector(changBackGroundBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changBackGroundBtn;
}

- (UIButton *)savaBtn{
    
    if (_savaBtn == nil) {
        
        _savaBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height)];
        
        _savaBtn.backgroundColor = [UIColor darkGrayColor];
        
        [_savaBtn setTitle:@"保存图像" forState:UIControlStateNormal];
        
        [_savaBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [_savaBtn addTarget:self action:@selector(savaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _savaBtn;
}

@end
