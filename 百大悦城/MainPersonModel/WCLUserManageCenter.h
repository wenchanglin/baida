//
//  WCLUserManageCenter.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCLUserModel.h"
#import "WCLUserInfoModel.h"
@interface WCLUserManageCenter : NSObject
+ (instancetype)shareInstance;
@property(nonatomic,strong)NSMutableArray * userArr;
////是否已经登录
@property (nonatomic, assign) BOOL             isLoginStatus;
@property(nonatomic,strong)NSString * sex;
///当前账号类型
//@property (nonatomic, assign) UserType         userType;
///认证类型
//@property (nonatomic, assign) StoreAuthenType  storeAuthenType;
///审核状态
//@property (nonatomic, assign) AasmState        aasmState;
///user
@property (nonatomic, strong) WCLUserModel     *userModel;
///userinfo
@property (nonatomic, strong) WCLUserInfoModel *userInfoModel;
///购物车数量
//@property (nonatomic, assign) NSInteger        cartsCount;
///wxuser
//@property (nonatomic, strong) WXUserModel      *wxUserModel;
///NetWork Status
@property (nonatomic, assign) BOOL             isNoActiveNetStatus;
///开通类型
//@property (nonatomic, assign) OpenCreditType   openCreditType;
///当前用户的开通服务
//@property (nonatomic, assign) UserOpenedCreditType userOpenedCreditType;

///注销
+ (void)logout;

@end
