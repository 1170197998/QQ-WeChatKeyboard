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

@interface InputToolbar : UIView

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
@property (nonatomic,copy)void(^sendContent)(NSObject *content);

/**
 *  InputToolbar所占高度
 */
@property (nonatomic,copy)void(^inputToolbarFrameChange)(CGFloat height,CGFloat orignY);

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
