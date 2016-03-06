//
//  ViewController.m
//  星星点着玩
//
//  Created by 叶慧伟 on 16/3/5.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "ViewController.h"
#import "XTTouchView.h"
#import "XTMenuView.h"
#import "XTBackGroundVC.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)XTMenuView *XTMenuView;
@property(nonatomic, strong)XTTouchView *XTTouchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)beginBtnClick:(id)sender {
    
    self.view = self.XTTouchView;
    
    __weak typeof(self) weakself = self;
    
    self.XTTouchView.menuViewBlock = ^(){
        
        [weakself.view addSubview:weakself.XTMenuView];
    };
    
    self.XTTouchView.removeMenuViewBlock = ^(){
        
        [weakself.XTMenuView removeFromSuperview];
    };
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(id)contextInfo{
    
    NSString *message = error == nil ? @"保存成功" : @"保存失败";
    
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alerVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alerVC addAction:action];
    
    [self presentViewController:alerVC animated:YES completion:nil];
}

#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self.XTTouchView.backGroundImageView setImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark lazyload
- (XTMenuView *)XTMenuView{
    
    if (_XTMenuView == nil) {
        
        _XTMenuView = [[XTMenuView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width, 30)];
        
        __weak typeof(self) weakself = self;
        _XTMenuView.changBackGroundBlock = ^{
            
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"保存成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"APP提供" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                XTBackGroundVC *XTBackVC = [XTBackGroundVC new];
                [weakself presentViewController:XTBackVC animated:1 completion:nil];
                XTBackVC.seletedBackGroundBlock = ^(UIImage *img){
                    [weakself.XTTouchView.backGroundImageView setImage:img];
                };
            }];
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIImagePickerControllerSourceType sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
                    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                        return;
                    }
                    UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
                    pickVC.delegate = weakself;
                    pickVC.allowsEditing = YES;
                    pickVC.sourceType = sourceType;
                    [weakself presentViewController:pickVC animated:YES completion:nil];

            }];
            
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alerVC dismissViewControllerAnimated:YES completion:nil];
            }];
            
            [alerVC addAction:action1];
            [alerVC addAction:action2];
            [alerVC addAction:action3];
            
            [weakself presentViewController:alerVC animated:YES completion:nil];
        };
        
        _XTMenuView.saveBlock = ^{
            [weakself.XTMenuView removeFromSuperview];
            //保存图像
            UIGraphicsBeginImageContextWithOptions(weakself.view.bounds.size, NO, 0);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            [weakself.view.layer renderInContext:ctx];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            UIImageWriteToSavedPhotosAlbum(image, weakself, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            };
    }
    return _XTMenuView;
}

- (XTTouchView *)XTTouchView{
    
    if (_XTTouchView == nil) {
        
        _XTTouchView = [[XTTouchView alloc]init];
    }
    return _XTTouchView;
}


@end
