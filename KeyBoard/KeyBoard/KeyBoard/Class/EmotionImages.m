//
//  Emotion.m
//  KeyBoard
//
//  Created by ShaoFeng on 16/9/2.
//  Copyright © 2016年 Cocav. All rights reserved.
//

#import "EmotionImages.h"
#import "IMEmotionEntity.h"
@implementation EmotionImages

+ (EmotionImages *)shareEmotinImages
{
    static EmotionImages *initEmotionImagesInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        initEmotionImagesInstance = [[self alloc] init];
    });
    return initEmotionImagesInstance;
}

- (void)initEmotionImages
{
    _emotions = [NSMutableArray array];
    _images = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emotion_icons.plist" ofType:nil];
    NSArray* array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray* entities = [NSMutableArray arrayWithCapacity:array.count];
    IMEmotionEntity* entity = nil;
    NSDictionary* dic = nil;
    for (int i = 0; i < array.count; i++) {
        dic = array[i];
        entity = [IMEmotionEntity entityWithDictionary:dic atIndex:i];
        [entities addObject:entity];
        [_emotions addObject:entity.name];
        [_images addObject:[UIImage imageNamed:entity.imageName]];
    }
}
@end
