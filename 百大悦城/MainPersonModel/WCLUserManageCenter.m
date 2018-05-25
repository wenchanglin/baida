//
//  WCLUserManageCenter.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLUserManageCenter.h"
static NSString *const kUserInfoModel = @"bdUserInfoModel";
static NSString *const kUserModel     = @"bdUserModel";
static NSString *const kWXUserModel   = @"bdWXUserModel";
@implementation WCLUserManageCenter
+ (instancetype)shareInstance {
    static WCLUserManageCenter *YBLUserModel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YBLUserModel = [[WCLUserManageCenter alloc] init];
    });
    return YBLUserModel;
}

- (BOOL)isLoginStatus{
    
    return self.userModel.authentication_token!=nil;
}
- (UserOpenedCreditType)userOpenedCreditType{
    
    UserOpenedCreditType uotp = UserOpenedCreditTypeNone;
    if ([self.userInfoModel.credit isEqualToString:@"china"]) {
        uotp = UserOpenedCreditTypeCredit;
    } else if ([self.userInfoModel.credit isEqualToString:@"member"]){
        uotp = UserOpenedCreditTypeMember;
    }
    return uotp;
}

- (OpenCreditType)openCreditType{
    
    OpenCreditType type_ = OpenCreditTypeCredit;
    if (self.userType == UserTypeSeller) {
        type_ = OpenCreditTypeCredit;
    } else {
        type_ = OpenCreditTypeMember;
    }
    return type_;
}

//- (AasmState)aasmState{
//    YBLUserInfoModel *userInfoModel = [YBLUserInfoModel readSingleModelForKey:kUserInfoModel];
//    AasmState state = AasmStateUnknown;
//    if ([userInfoModel.aasm_state isEqualToString:@"initial"]) {
//        state = AasmStateInitial;
//    } else if ([userInfoModel.aasm_state isEqualToString:@"wait_approve"]) {
//        state = AasmStateWaiteApproved;
//    } else if ([userInfoModel.aasm_state isEqualToString:@"approved"]) {
//        state = AasmStateApproved;
//    } else if ([userInfoModel.aasm_state isEqualToString:@"rejected"]) {
//        state = AasmStateRejected;
//    }
//    return state;
//}

- (UserType)userType{
    
    WCLUserInfoModel *userInfoModel = [WCLUserInfoModel readSingleModelForKey:kUserInfoModel];
    UserType usertype = UserTypeGuest;
    if ([userInfoModel.user_type isEqualToString:user_type_guest_key]) {
        usertype = UserTypeGuest;
    } else if ([userInfoModel.user_type isEqualToString:user_type_buyer_key]) {
        usertype = UserTypeBuyer;
    } else if ([userInfoModel.user_type isEqualToString:user_type_seller_key]) {
        usertype = UserTypeSeller;
    }
    return usertype;
}

//- (void)setWxUserModel:(WXUserModel *)wxUserModel{
//
//    [WXUserModel saveSingleModel:wxUserModel forKey:kWXUserModel];
//}
//
//- (WXUserModel *)wxUserModel{
//
//    WXUserModel *wxuserModel = [WXUserModel readSingleModelForKey:kWXUserModel];
//
//    return wxuserModel;
//}

- (void)setUserModel:(WCLUserModel *)userModel{
    
    [WCLUserModel saveSingleModel:userModel forKey:kUserModel];
}

- (WCLUserModel *)userModel{
    
    WCLUserModel *userModel = [WCLUserModel readSingleModelForKey:kUserModel];
    //    userModel.authentication_token = TToken;
    return userModel;
}
- (void)setUserInfoModel:(WCLUserInfoModel *)userInfoModel{
    
    [WCLUserInfoModel saveSingleModel:userInfoModel forKey:kUserInfoModel];
}

- (WCLUserInfoModel *)userInfoModel{
    
    WCLUserInfoModel *userInfo = [WCLUserInfoModel readSingleModelForKey:kUserInfoModel];
    return userInfo;
    
}
+ (void)logout{
    
    [WCLUserManageCenter shareInstance].userModel = nil;
    [WCLUserManageCenter shareInstance].userInfoModel = nil;
    //    [YBLUserManageCenter shareInstance].wxUserModel = nil;
    [WCLUserManageCenter shareInstance].cartsCount = 0;
}
@end
