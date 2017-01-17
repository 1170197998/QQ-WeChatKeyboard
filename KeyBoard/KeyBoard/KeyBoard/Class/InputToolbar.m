//
//  InputToolbar.m
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/18.
//  Copyright © 2016年 Cocav. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define customKeyboardHeight 200
#define InputToolbarHeight 49
#define NavigationHeight 64

#import "InputToolbar.h"
#import "UIView+Extension.h"

@interface InputToolbar ()<UITextViewDelegate,EmojiButtonViewDelegate>
@property (nonatomic, assign)CGFloat textInputHeight;
@property (nonatomic, assign)NSInteger TextInputMaxHeight;
@property (nonatomic, assign)NSInteger keyboardHeight;
@property (nonatomic, assign)BOOL showKeyboardButton;

@property (nonatomic,strong)UIButton *voiceButton;
@property (nonatomic,strong)UITextView *textInput;
@property (nonatomic,strong)UIButton *emojiButton;
@property (nonatomic,strong)UIButton *moreButton;

@property (nonatomic,strong)VoiceButtonView *voiceButtonView;
@property (nonatomic,strong)EmojiButtonView *emojiButtonView;
@property (nonatomic,strong)MoreButtonView *moreButtonView;

@end

@implementation InputToolbar

- (VoiceButtonView *)leftButtonView
{
    if (!_voiceButtonView) {
        _voiceButtonView = [[VoiceButtonView alloc] init];
        _voiceButtonView.width = self.width;
        _voiceButtonView.height = customKeyboardHeight;
        _keyboardHeight = customKeyboardHeight;
    }
    return _voiceButtonView;
}

- (EmojiButtonView *)emojiButtonView
{
    if (!_emojiButtonView) {
        _emojiButtonView = [[EmojiButtonView alloc] init];
        _emojiButtonView.delegate = self;
        _emojiButtonView.width = self.width;
        _emojiButtonView.height = customKeyboardHeight;
        _keyboardHeight = customKeyboardHeight;
    }
    return _emojiButtonView;
}

- (MoreButtonView *)moreButtonView
{
    if (!_moreButtonView) {
        _moreButtonView = [[MoreButtonView alloc] init];
        _moreButtonView.width = self.width;
        _moreButtonView.height = customKeyboardHeight;
        _keyboardHeight = customKeyboardHeight;
    }
    return _moreButtonView;
}

static InputToolbar* _instance = nil;
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[InputToolbar alloc] init] ;
    });
    return _instance ;
}

+ (instancetype)alloc
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super alloc] init] ;
    });
    return _instance ;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        [self layoutUI];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = keyboardFrame.size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:7];
    self.y = keyboardFrame.origin.y - self.height;
    [UIView commitAnimations];
    _inputToolbarFrameChange(self.height,self.y);
    self.keyboardIsVisiable = YES;
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.y = keyboardFrame.origin.y - self.height;
    }];
    _inputToolbarFrameChange(self.height,self.y);
    self.keyboardIsVisiable = NO;
    [self setShowKeyboardButton:NO];
}

- (void)layoutUI
{
    self.voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 9, 30, 30)];
    [self.voiceButton setImage:[UIImage imageNamed:@"liaotian_ic_yuyin_nor"] forState:UIControlStateNormal];
    [self.voiceButton setImage:[UIImage imageNamed:@"liaotian_ic_press"] forState:UIControlStateHighlighted];
    [self.voiceButton addTarget:self action:@selector(clickVoiceButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.voiceButton];
    
    self.textInput = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.voiceButton.frame) + 5, 5, SCREEN_WIDTH - 115, 36)];
    self.textInput.font = [UIFont systemFontOfSize:18];
    self.textInput.layer.cornerRadius = 3;
    self.textInput.layer.masksToBounds = YES;
    self.textInput.returnKeyType = UIReturnKeySend;
    self.textInput.enablesReturnKeyAutomatically = YES;
    self.textInput.delegate = self;
    [self addSubview:self.textInput];
    
    self.emojiButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textInput.frame) + 5, 9, 30, 30)];
    [self.emojiButton setImage:[UIImage imageNamed:@"liaotian_ic_biaoqing_nor"] forState:UIControlStateNormal];
    [self.emojiButton setImage:[UIImage imageNamed:@"liaotian_ic_biaoqing_press"] forState:UIControlStateHighlighted];
    [self.emojiButton addTarget:self action:@selector(clickEmojiButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.emojiButton];
    
    self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.emojiButton.frame) + 5, 9, 30, 30)];
    [self.moreButton setImage:[UIImage imageNamed:@"liaotian_ic_gengduo_nor"] forState:UIControlStateNormal];
    [self.moreButton setImage:[UIImage imageNamed:@"liaotian_ic_gengduo_press"] forState:UIControlStateHighlighted];
    [self.moreButton addTarget:self action:@selector(clickMoreButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreButton];
}

- (void)textViewDidChange:(UITextView *)textView
{
    _textInputHeight = ceilf([self.textInput sizeThatFits:CGSizeMake(self.textInput.bounds.size.width, MAXFLOAT)].height);
    self.textInput.scrollEnabled = _textInputHeight > _TextInputMaxHeight && _TextInputMaxHeight > 0;
    if (self.textInput.scrollEnabled) {
        self.textInput.height = 5 + _TextInputMaxHeight;
        self.y = SCREEN_HEIGHT - _keyboardHeight - _TextInputMaxHeight - 5 - 8;
        self.height = _TextInputMaxHeight + 15;
    } else {
        self.textInput.height = _textInputHeight;
        self.y = SCREEN_HEIGHT - _keyboardHeight - _textInputHeight - 5 - 8;
        self.height = _textInputHeight + 15;
    }
    self.voiceButton.y = self.emojiButton.y = self.moreButton.y = self.height - self.voiceButton.height - 12;
    if ([_delegate respondsToSelector:@selector(inputToolbar:orignY:)]) {
        [_delegate inputToolbar:self orignY:self.y];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textInput.inputView = nil;
}

- (void)emojiButtonView:(EmojiButtonView *)emojiButtonView emojiText:(NSObject *)text
{
    if ([text  isEqual: deleteButtonId]) {
        [self.textInput deleteBackward];
        return;
    }
    if (![text isKindOfClass:[UIImage class]]) {
        [self.textInput replaceRange:self.textInput.selectedTextRange withText:(NSString *)text];
    } else {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
        textAttachment.image = (UIImage *)text;
        textAttachment.bounds = CGRectMake(0, - 5, self.textInput.font.lineHeight + 2, self.textInput.font.lineHeight + 2);
        NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:self.textInput.attributedText];
        [strM replaceCharactersInRange:self.textInput.selectedRange withAttributedString:imageText];
        [strM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(self.textInput.selectedRange.location, 1)];
        self.textInput.attributedText = strM;
        self.textInput.selectedRange = NSMakeRange(self.textInput.selectedRange.location + 1,0);
        [self.textInput.delegate textViewDidChange:self.textInput];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (_sendContent) {
            _sendContent(self.textInput.attributedText);
            self.y = SCREEN_HEIGHT - _keyboardHeight - InputToolbarHeight;
            _inputToolbarFrameChange(self.height,self.y);
        }
        textView.text = nil;
        self.textInput.height = 36;
        self.height = InputToolbarHeight;
        self.voiceButton.y = self.emojiButton.y = self.moreButton.y = 9;
        return NO;
    }
    return YES;
}

- (void)emojiButtonView:(EmojiButtonView *)emojiButtonView sendButtonClick:(UIButton *)sender
{
    if (_sendContent) {
        _sendContent(self.textInput.attributedText);
        self.y = SCREEN_HEIGHT - _keyboardHeight - InputToolbarHeight;
        _inputToolbarFrameChange(self.height,self.y);
    }
    self.textInput.text = nil;
    self.textInput.height = 36;
    self.height = InputToolbarHeight;
    self.voiceButton.y = self.emojiButton.y = self.moreButton.y = 9;
}

- (void)clickVoiceButton
{
    [self switchToKeyboard:self.leftButtonView];
}

- (void)clickEmojiButton
{
    if (self.textInput.inputView == nil || !self.keyboardIsVisiable) {
        self.textInput.inputView = self.emojiButtonView;
        self.showKeyboardButton = YES;
    } else {
        
        if (self.textInput.inputView != self.emojiButtonView) {
            self.textInput.inputView = self.emojiButtonView;
            self.showKeyboardButton = YES;
        } else {
            self.textInput.inputView = nil;
            self.showKeyboardButton = NO;
        }
    }
    [self.textInput endEditing:YES];
    [self.textInput becomeFirstResponder];
}

- (void)clickMoreButton
{
    [self switchToKeyboard:self.moreButtonView];
}

- (void)switchToKeyboard:(UIView *)keyboard
{
    if (self.textInput.inputView == nil || !self.keyboardIsVisiable) {
        self.textInput.inputView = keyboard;
    } else {
        //优先弹出非键盘keyboard
        if (self.textInput.inputView != keyboard) {
            self.textInput.inputView = keyboard;
        } else {
            self.textInput.inputView = nil;
        }
        self.showKeyboardButton = NO;
    }
    [self.textInput endEditing:YES];
    [self.textInput becomeFirstResponder];
}

- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    // 默认的图片名
    NSString *image = @"liaotian_ic_biaoqing_nor";
    NSString *highImage = @"liaotian_ic_biaoqing_press";
    
    // 显示键盘图标
    if (showKeyboardButton) {
        image = @"liaotian_ic_jianpan_nor";
        highImage = @"liaotian_ic_jianpan_press";
    }
    
    // 设置图片
    [self.emojiButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emojiButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

- (void)setIsBecomeFirstResponder:(BOOL)isBecomeFirstResponder
{
    if (isBecomeFirstResponder) {
        [self.textInput becomeFirstResponder];
    } else {
        [self.textInput resignFirstResponder];
    }
}

- (void)setMorebuttonViewDelegate:(id)delegate
{
    self.moreButtonView.delegate = delegate;
}

- (void)setTextViewMaxVisibleLine:(NSInteger)textViewMaxVisibleLine
{
    _textViewMaxVisibleLine = textViewMaxVisibleLine;
    _TextInputMaxHeight = ceil(self.textInput.font.lineHeight * (textViewMaxVisibleLine - 1) + self.textInput.textContainerInset.top + self.textInput.textContainerInset.bottom);
}

- (void)clearInputToolbarContent
{
    self.textInput.text = nil;
}

- (void)resetInputToolbar
{
    self.textInput.text = nil;
    self.textInput.height = 36;
    self.height = InputToolbarHeight;
    self.voiceButton.y = self.emojiButton.y = self.moreButton.y = 9;
}

@end
