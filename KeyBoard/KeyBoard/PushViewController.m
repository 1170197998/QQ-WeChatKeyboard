//
//  PushViewController.m
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/18.
//  Copyright © 2016年 Cocav. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "PushViewController.h"
#import "InputToolbar.h"
#import "UIView+Extension.h"

@interface PushViewController ()<MoreButtonViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong)InputToolbar *inputToolbar;
@property (nonatomic,assign)CGFloat inputToolbarY;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputToolbar = [InputToolbar shareInstance];
    [self.view addSubview:self.inputToolbar];
    self.inputToolbar.textViewMaxVisibleLine = 4;
    self.inputToolbar.width = self.view.width;
    self.inputToolbar.height = 49;
    self.inputToolbar.y = self.view.height - self.inputToolbar.height;
    [self.inputToolbar setMorebuttonViewDelegate:self];
    
    __weak typeof(self) weakSelf = self;
    self.inputToolbar.sendContent = ^(NSObject *content){
        NSLog(@"上传服务器内容☀️:---%@",(NSString *)content);
        weakSelf.textView.text = (NSString *)content;
    };
    
    self.inputToolbar.inputToolbarFrameChange = ^(CGFloat height,CGFloat orignY){
        _inputToolbarY = orignY;
        /*
         如果是当前界面是tableView可以直接使用以下代码调试位置
        if (weakSelf.tableView.contentSize.height > orignY) {
            [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
            [weakSelf.tableView setContentOffset:CGPointMake(0, weakSelf.tableView.contentSize.height - orignY) animated:YES];
        }
         */
    };
    [self.inputToolbar resetInputToolbar];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.inputToolbar.isBecomeFirstResponder = NO;
}

- (void)moreButtonView:(MoreButtonView *)moreButtonView didClickButton:(MoreButtonViewButtonType)buttonType
{
    switch (buttonType) {
        case MoreButtonViewButtonTypeImages:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        } break;
            
        case MoreButtonViewButtonTypeCamera:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        } break;
            
        default:
            break;
    }
}

- (void)inputToolbar:(InputToolbar *)inputToolbar orignY:(CGFloat)orignY
{
    _inputToolbarY = orignY;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //UIImage *image = info[UIImagePickerControllerOriginalImage];
    //图片选取成功
}

@end
