//
//  InputToolbar.h
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/18.
//  Copyright © 2016年 Cocav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreButtonView.h"
#import "VoiceButtonView.h"
#import "EmojiButtonView.h"
@class InputToolbar;
@protocol InputToolbarDelegate <NSObject>
- (void)inputToolbar:(InputToolbar *)inputToolbar orignY:(CGFloat )orignY;
@end

@interface InputToolbar : UIView

@property (nonatomic,weak) id<InputToolbarDelegate>delegate;
+(instancetype) shareInstance;

/**
 *  当前键盘是否可见
 */
@property (nonatomic,assign)BOOL keyboardIsVisiable;

/**
 *  设置第一响应
 */
@property (nonatomic,assign)BOOL isBecomeFirstResponder;

/**
 *  设置输入框最多可见行数
 */
@property (nonatomic,assign)NSInteger textViewMaxVisibleLine;

/**
 *  点击发送后要发送的文本
 */
@property (nonatomic,strong)void(^sendContent)(NSObject *content);

/**
 *  InputToolbar所占高度
 */
@property (nonatomic,strong)void(^inputToolbarFrameChange)(CGFloat height,CGFloat orignY);

/**
 *  添加moreButtonView代理
 */
- (void)setMorebuttonViewDelegate:(id)delegate;

/**
 *  清空inputToolbar内容
 */
- (void)clearInputToolbarContent;

/**
 *  重置inputToolbar
 */
- (void)resetInputToolbar;
@end
