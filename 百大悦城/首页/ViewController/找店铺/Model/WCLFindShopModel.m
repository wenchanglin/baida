//
//  WCLFindShopModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLFindShopModel.h"
@implementation WCLFindShopFloorModel
@end
@implementation WCLShopIndustryModel
@end
@implementation WCLFindShopModel
-(NSString *)description
{
    NSMutableDictionary * dictionry = [NSMutableDictionary dictionary];
    uint count;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        objc_property_t preperty = propertys[i];
        NSString *name = @(property_getName(preperty));
        id value = [self valueForKey:name]?:@"nil";//默认值为nil
        [dictionry setObject:value forKey:name];
    }
    free(propertys);
    return [NSString stringWithFormat:@"<%@: %p>-- %@",[self class],self,dictionry];
}
@end
