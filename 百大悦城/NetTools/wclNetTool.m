//
//  wclNetTool.m
//  ceshi
//
//  Created by banbo on 2017/9/12.
//  Copyright © 2017年 banbo. All rights reserved.
//

#import "wclNetTool.h"
@interface wclNetTool ()

@end
@implementation wclNetTool
+(instancetype)sharedTools
{
    static wclNetTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc]initWithBaseURL:[NSURL URLWithString:URL_Server_String]];
        tool.securityPolicy.allowInvalidCertificates = YES;
        tool.securityPolicy.validatesDomainName = NO;
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",                                                         @"image/jpeg",@"image/png",@"text/plain",@"application/json", nil];
        [tool.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        tool.requestSerializer.timeoutInterval = 8.f;
        [tool.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        tool.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    });
    return tool;
}

-(void)updateRequest:(NSString *)url
              params:(NSMutableDictionary *)params
     fileConfigArray:(NSMutableArray *)fileConfigArray
            finished:(void(^)(id responseObject,NSError * error))finished
{
    BOOL vaild = [self checkRequestVaildWith:url];
    if (!vaild) {
        return;
    }
    params[@"appType"]=@"ios";
    params[@"appVersion"]= @"1.0.0";
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults] ;
    if ([[userd stringForKey:@"hash"]length] > 0 ) {
        NSString * str1 = [userd stringForKey:@"hash"];
        [params setObject:str1 forKey:@"hash"];
    }
//    WCLLog(@"%@%@-%@",self.baseURL,url,params);
    [[wclNetTool sharedTools]POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (JSFileConfig *file in fileConfigArray) {
            [formData appendPartWithFileData:file.fileData name:file.name fileName:file.fileName mimeType:file.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(nil,error);
    }];
}
-(BOOL)checkRequestVaildWith:(NSString *)url{
    if (!url) {
        [SVProgressHUD showErrorWithStatus:@"URL不存在!"];
        [YBLLogLoadingView dismissInWindow];
        [SVProgressHUD dismiss];
        return NO;
    }
    NSString *kongString = @" ";
    if ([url rangeOfString:kongString].location!=NSNotFound) {
        [url stringByReplacingOccurrencesOfString:kongString withString:@""];
    }
    if ([WCLUserManageCenter shareInstance].isNoActiveNetStatus) {
        [YBLLogLoadingView dismissInWindow];
        [SVProgressHUD dismiss];
        return NO;
    }
    return YES;
}

- (void)request:(HTTPMethod)method urlString:(NSString *)urlString parameters:(NSMutableDictionary *)parameters finished:(void (^)(id responseObject, NSError *error))finished {
     NSUserDefaults *userd = [NSUserDefaults standardUserDefaults] ;
    parameters[@"appType"]=@"ios";
    parameters[@"appVersion"]= @"1.0.0";
    BOOL vaild = [self checkRequestVaildWith:urlString];
    if (!vaild) {
        return;
    }

    if (method == GET) {
        if ([[userd stringForKey:@"hash"]length] > 0 ) {
            NSString * str1 = [userd stringForKey:@"hash"];
            [parameters setObject:str1 forKey:@"hash"];
        }
        if([[userd stringForKey:@"organizeId"]length]>0)
        {
            parameters[@"organizeId"] = [userd stringForKey:@"organizeId"];
        }
        if ([[userd stringForKey:@"token"]length]>0) {
            parameters[@"token"] =[userd stringForKey:@"token"];
        }
        WCLLog(@"%@%@-%@",self.baseURL,urlString,parameters);
        
        [[wclNetTool sharedTools] GET:urlString parameters:parameters  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"code"]integerValue]==4002) {
                [WCLUserManageCenter logout];
                finished(nil,nil);
            }
            else
            {
            finished(responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil,error);
        }];
    } else {
        if ([[userd stringForKey:@"hash"]length] > 0 ) {
            [parameters setObject:[userd stringForKey:@"hash"] forKey:@"hash"];
        }
        if([[userd stringForKey:@"organizeId"]length]>0)
        {
        parameters[@"organizeId"] = [userd stringForKey:@"organizeId"];
        }
        if ([[userd stringForKey:@"token"]length]>0) {
            parameters[@"token"] =[userd stringForKey:@"token"];
        }
        WCLLog(@"%@%@-%@",self.baseURL,urlString,parameters);
        [[wclNetTool sharedTools] POST:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            if ([responseObject[@"code"]integerValue]==4002) {
                [WCLUserManageCenter logout];
                finished(nil,nil);
            }
            else
            {
                finished(responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil,error);
        }];
    }
}

@end
