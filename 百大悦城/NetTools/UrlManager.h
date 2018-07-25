//
//  UrlManager.h
//  CongestionOfGod
//
//  Created by 文长林 on 15/5/21.
//  Copyright (c) 2015年 文长林. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef CongestionOfGod_UrlManager_h
#define CongestionOfGod_UrlManager_h


#endif
#define HeadPlaceHolder [UIImage imageNamed:@"aboutUS"]
//132
#define URL_H5 @"http://yjwang.wmalle.com/mall/baida-app-h5/index.html#/"
#define URL_Server_String  @"https://yjwang.wmalle.com/wechat/"//把yjwang.wmalle.com换成ceshi.wmalle.com
//169
//#define URL_H5 @"http://ceshi.wmalle.com/mall/baida-app-h5/index.html#/"
//#define URL_Server_String  @"https://ceshi.wmalle.com/wechat/"
//正式
//#define URL_H5 @"http://m.hfbh.com.cn/mall/baida-app-h5/index.html#/"
//#define URL_Server_String   @"https://m.hfbh.com.cn/wechat/"
//室内导航
#define URL_MallFloor @"mallFloor/floorList.json"
//秒杀列表和团购列表
#define URL_MiaoShaList @"commodity/listCommodity.json"
//确认支付
#define URL_CommodityOrder @"order/submitOrder.json"
//主扫优惠买单
//1.获取订单单据数据
#define URL_ScanBuyData @"scanCodePay/getMemberPromotion.json"
//我的活动列表获取以及各tag
#define URL_mineActivityList @"wechat/signup_activity/list.json"
//11.1.2.发现-活动列表
#define URL_ActivityList @"signupActivity/list.json"
//活动详情页
#define URL_ActivityDetail @"wechat/signup_activity/detail.json"
//确认活动报名
#define URL_SureSignUp @"wechat/signup_activity/signup_form.json"
//11.2.5.获取报名记录信息
#define URL_CheckSignUp @"wechat/signup_activity/signup_record.json"
//活动立即报名
#define URL_SignUpSubmit @"wechat/signup_activity/signup_submit.json"
//6.1.9.用户账户余额
#define URL_UserMoney @"member/queryAmount.json"
//11.1.3.我的-活动列表
#define URL_MineAcivityList @"wechat/signup_activity/list.json"
//生成活动报名订单
#define URL_ActivityOrder @"wechat/signup_activity/getPayData.json"
//发现-商品列表
#define URL_Find_GoodsList @"commodity/listCommodity.json"
//发现-人气商品详情
#define URL_GoodsDetail @"commodity/commodity.json"
#define URL_Shop_Detail  @"shop/shopDetail.json"
//城市商城切换
#define URL_SwitchShop_List @"cityConfig/cityList.json"
//获取积分列表和优惠券列表
#define URL_GiftAndCouPonList @"pointsReward/list.json"
//获取积分列表的详情
#define URL_GiftDetail @"pointsReward/info.json"
//积分兑换
#define URL_GiftExchange @"pointsReward/exchange.json"
//优惠券列表
#define URL_CouPonList @"webcoupon/listCouponDefault.json"
///优惠券详情
#define URL_CouPonDetail @"webcoupon/getCouponDesc.json"
//优惠券兑换
#define URL_ExchageByPoints @"webcoupon/exchangeByPoints.json"
///验证手机号是否注册
#define URL_QueryByPhoto @"appRequest/queryByPhone.json"
//会员注册
#define URL_Register @"appRequest/register.json"
//会员登录(手机+密码)
#define URL_Login @"appRequest/appLogin.json"
//会员登录(手机+验证码)
#define URL_ValidatePhone @"appRequest/appVerificationLogin.json"
//备用
#define URL_ValidatePhone1 @"member/validatePhone.json"
///获取验证码
#define URL_GetSecuntyCode @"register/getSecurityCode.json"
//忘记密码
#define URL_ForgetPwd @"appRequest/forgetPwd.json"
//重置密码（手机+短信验证码+新密码）
#define URL_RestPwd @"appRequest/resetPwd.json"
//修改用户信息
#define URL_UpdateUserInfo @"appRequest/updateMemberInfo.json"
//获取会员信息
#define URL_GetUserInfo @"member/queryMember.json"
//退出登录
#define URL_LoginOut @"appRequest/loginOut.json"
//预付卡列表
#define URL_PrePaidList @"member/prePaidCardList.json"
//保存预付储值卡
#define URL_SavePrePaidCard @"member/savePrePaidCard.json"
//删除预付卡
#define URL_DeletePrePaidCar @"member/deleteCard.json"
//会员-资金明细
#define URL_MoneyDetail @"member/accountChangeRecord.json"
//会员-积分明细
#define URL_PointsDetail @"member/pointsRecord.json"
//上传图片
#define URL_UploadPic @"wechatCommon/saveAppImgToLocal.json"
//意见反馈
#define URL_Suggest @"feedback/save.json"
//是否绑定支付密码
#define URL_isBindPayPwd @"member/isBindPassword.json"
//验证支付密码接口
#define URL_ValidatePayPwd @"member/validatePassword.json"
//会员身份验证（验证码登录）
#define URL_MemberValidateForPhone @"member/validatePhone.json"
//绑定支付密码
#define URL_BindPayPwd @"member/bindPassword.json"
//重置支付密码
#define URL_ResetPayPwd @"member/resetPassword.json"
//我的票券
#define URL_MyTicket @"memberCoupon/memberCoupon.json"
//我的订单
#define  URL_MineAllOrder @"memberOrderShop/listOrder.json"
//我的订单-取消订单
#define URL_MineCancleOrder @"memberOrderShop/cancelOrder.json"
//我的订单-支付订单
#define URL_MinePayOrder @"order/orderView.json"
//我的活动--生成核销码
#define URL_Verify_Codes @"wechat/signup_activity/verify_codes.json"
//我的兑换--
#define URL_ExchangeList @"memberCoupon/listMemberCoupon.json"
//我的兑换详情
#define URL_ExchangeDetail @"memberCoupon/getVerifyCoupon.json"
//被扫获取订单
#define URL_BeiSCanner @"scanCodePay/queryOrder.json"
//确认订单支付
#define URL_SureOrder @"scanCodePay/confirmOrder.json"
//验证用户是否登录
#define URL_IsLogin @"appRequest/memberIsLogin.json"
//获取广播未读数量
#define URL_HeadLineCount @"broadcast/notReadNum.json"
//广播消息列表
#define URL_HeadLineList @"broadcast/list.json"
//广播设为已读
#define URL_HeadLineRead @"broadcast/update.json"
//我的消费记录
#define URL_SaleDetail @"member/saleIntems.json"
//支付订单
#define URL_PayOrder @"order/getPayData.json"
//冻结预付卡
#define URL_DongJieYFK @"wechat/signup_activity/preparePay.json"
//冻结预付卡成功
#define URL_DongJieYFKSuccess @"wechat/signup_activity/getPayDataSuccess.json"
//冻结余额
#define URL_DongJieYE @"order/freezeBalance.json"
//冻结余额成功
#define URL_DongJieYESuccess @"order/confirmBalance.json"
