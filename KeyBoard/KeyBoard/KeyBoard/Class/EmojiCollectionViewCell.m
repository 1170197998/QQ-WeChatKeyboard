//
//  EmojiCollectionViewCell.m
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/19.
//  Copyright © 2016年 Cocav. All rights reserved.
//
#import "EmojiCollectionViewCell.h"

@interface EmojiCollectionViewCell ()
@property (nonatomic,strong)UIButton *button;
@end

@implementation EmojiCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.button = [[UIButton alloc] init];
    self.button.userInteractionEnabled = false;
    [self.contentView addSubview:self.button];
}

- (void)setString:(NSString *)string
{
    if ([string isEqual: deleteButtonId]) {
        [self.button setTitle:nil forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"DeleteEmoticonBtn"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"DeleteEmoticonBtnHL"] forState:UIControlStateHighlighted];
        [self.button setFrame:CGRectMake(7, 3, self.contentView.frame.size.width - 10, self.contentView.frame.size.height - 6)];
     } else {
        [self.button setImage:nil forState:UIControlStateNormal];
        [self.button setImage:nil forState:UIControlStateHighlighted];
        [self.button setTitle:string forState:UIControlStateNormal];
         self.button.frame = CGRectInset(self.contentView.bounds, 0, 0);
    }
}

- (void)setImage:(UIImage *)image
{
    self.button.frame = CGRectInset(self.contentView.bounds, 0, 0);
    [self.button setTitle:nil forState:UIControlStateNormal];
    if (image) {
        [self.button setImage:image forState:UIControlStateNormal];
        [self.button setImage:image forState:UIControlStateHighlighted];
    } else {
        [self.button setImage:nil forState:UIControlStateNormal];
        [self.button setImage:nil forState:UIControlStateHighlighted];
    }
}

@end
