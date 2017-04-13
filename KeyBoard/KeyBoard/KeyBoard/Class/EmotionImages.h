//
//  Emotion.h
//  KeyBoard
//
//  Created by ShaoFeng on 16/9/2.
//  Copyright © 2016年 Cocav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EmotionImages : NSObject
@property(nonatomic,strong)NSMutableArray* emotions;
@property(nonatomic,strong)NSMutableArray<UIImage*>* images;
- (void)initEmotionImages;
+ (EmotionImages *)shareEmotinImages;

@end
