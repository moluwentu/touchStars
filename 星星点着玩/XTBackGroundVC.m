//
//  XTBackGroundVC.m
//  星星点着玩
//
//  Created by 叶慧伟 on 16/3/5.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTBackGroundVC.h"

@interface XTBackGroundVC ()

@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, assign)NSInteger imageNum;
@property (nonatomic, strong)UIImageView *backgroundImage;

@end

@implementation XTBackGroundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backgroundImage];
    
    [self.view addSubview:self.sureBtn];
}

- (void)swipeGestSlide:(UISwipeGestureRecognizer *)sender{
    
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        self.imageNum++;
        
        if (self.imageNum == 6) {
            
            self.imageNum = 0;
        }

        NSString *imageName = [NSString stringWithFormat:@"Taikongzhi%ld",self.imageNum + 1];
        
        self.backgroundImage.image = [UIImage imageNamed:imageName];
    }else{
        
        self.imageNum--;
        
        if (self.imageNum == -1) {
            
            self.imageNum = 5;
        }
        
        NSString *imageName = [NSString stringWithFormat:@"Taikongzhi%ld",self.imageNum + 1];
        
        self.backgroundImage.image = [UIImage imageNamed:imageName];
    };
    
    CATransition *anim = [[CATransition alloc]init];
    
    anim.type = @"rippleEffect";
    
    [self.backgroundImage.layer addAnimation:anim forKey:nil];
}

- (void)sureBtnClick{
    if (self.seletedBackGroundBlock) {
        
        self.seletedBackGroundBlock(self.backgroundImage.image);
    }
    
    [self dismissViewControllerAnimated:0 completion:nil];
}


#pragma mark lazyload
- (UIButton *)sureBtn{
    
    if (_sureBtn == nil) {
        
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 80, self.view.bounds.size.height - 50, 65, 30)];
        
        _sureBtn.backgroundColor = [UIColor clearColor];
        
        _sureBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        _sureBtn.layer.borderWidth = 1;
        
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [_sureBtn setTitle:@"就是你了!" forState:UIControlStateNormal];
        
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIImageView *)backgroundImage{
    if (_backgroundImage == nil) {
        
        _backgroundImage = [[UIImageView alloc]init];
        
        _backgroundImage.userInteractionEnabled = YES;
        
        _backgroundImage.frame = self.view.bounds;
        
        _backgroundImage.image = [UIImage imageNamed:@"Taikongzhi1"];
        
        UISwipeGestureRecognizer *leftswipeGest = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestSlide:)];
        
        UISwipeGestureRecognizer *rightswipeGest = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestSlide:)];
        
        [_backgroundImage addGestureRecognizer:leftswipeGest];
        
        leftswipeGest.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [_backgroundImage addGestureRecognizer:rightswipeGest];
        
        rightswipeGest.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _backgroundImage;
}

@end
