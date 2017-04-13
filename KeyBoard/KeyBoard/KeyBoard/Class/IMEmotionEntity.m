//
//  IMEmotionEntity.h
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/18.
//  Copyright © 2016年 Cocav. All rights reserved.
//

#import "IMEmotionEntity.h"

@implementation IMEmotionEntity

+ (IMEmotionEntity *)entityWithDictionary:(NSDictionary*)dic atIndex:(int)index
{
	IMEmotionEntity* entity = [[IMEmotionEntity alloc] init];
    entity.name = dic[@"name"];
    entity.code = [NSString stringWithFormat:@"[%d]", index];//[dic objectForKey:@"code"];
	entity.imageName = [NSString stringWithFormat:@"Expression_%d.png", index+1];//[dic objectForKey:@"image"];
    
	return entity;
}

@end
