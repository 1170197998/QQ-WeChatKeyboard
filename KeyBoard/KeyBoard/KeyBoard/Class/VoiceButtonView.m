
//
//  VoiceButtonView.m
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/18.
//  Copyright © 2016年 Cocav. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "VoiceButtonView.h"
#import "UIView+Extension.h"
#import <AVFoundation/AVFoundation.h>
@interface VoiceButtonView ()<AVAudioRecorderDelegate>
{
    AVAudioRecorder *audioRecorder;
}
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIImageView *mainView;
@property (nonatomic,strong)UIView *rightView;
@end

@implementation VoiceButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI
{
    self.mainView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mianView"]];
    self.mainView.x = SCREEN_WIDTH / 2 - 40;
    self.mainView.y = 60;
    self.mainView.width = self.mainView.height = 80;
    [self addSubview:self.mainView];
    self.mainView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self.mainView addGestureRecognizer:swipe];
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
    [self.mainView addGestureRecognizer:longpress];
}

- (void)swipe:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
    }
}

- (void)longpress:(UILongPressGestureRecognizer *)recognizer
{
    NSString *name = [NSString stringWithFormat:@"%d.aiff",(int)[NSDate date].timeIntervalSince1970];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:name];
    NSError *error;
    //  录音机 初始化
    audioRecorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:path] settings:@{AVNumberOfChannelsKey:@2,AVSampleRateKey:@44100,AVLinearPCMBitDepthKey:@32,AVEncoderAudioQualityKey:@(AVAudioQualityMax),AVEncoderBitRateKey:@128000} error:&error];
    [audioRecorder prepareToRecord];
    [audioRecorder record];
    audioRecorder.delegate = self;
    /*
        1.AVNumberOfChannelsKey 通道数 通常为双声道 值2
        2.AVSampleRateKey 采样率 单位HZ 通常设置成44100 也就是44.1k
        3.AVLinearPCMBitDepthKey 比特率 8 16 24 32
        4.AVEncoderAudioQualityKey 声音质量
            ① AVAudioQualityMin  = 0, 最小的质量
            ② AVAudioQualityLow  = 0x20, 比较低的质量
            ③ AVAudioQualityMedium = 0x40, 中间的质量
            ④ AVAudioQualityHigh  = 0x60,高的质量
            ⑤ AVAudioQualityMax  = 0x7F 最好的质量
        5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps
         
        */
    
//    NSLog(@"%@",path);
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"录音结束");
    //  文件操作的类
    NSFileManager *manger = [NSFileManager defaultManager];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //  获得当前文件的所有子文件subpathsAtPath
    NSArray *pathlList = [manger subpathsAtPath:path];
    
    //  需要只获得录音文件
    NSMutableArray *audioPathList = [NSMutableArray array];
    //  遍历所有这个文件夹下的子文件
    for (NSString *audioPath in pathlList) {
        //    通过对比文件的延展名（扩展名 尾缀） 来区分是不是录音文件
        if ([audioPath.pathExtension isEqualToString:@"aiff"]) {
            //      把筛选出来的文件放到数组中
            [audioPathList addObject:audioPath];
        }
    }
//    NSLog(@"%@",audioPathList);
}

@end
