//
//  AFHttpTool.m
//  AF
//
//  Created by youziyue on 15/8/18.
//  Copyright (c) 2015年 youziyue. All rights reserved.
//

#import "AFHttpTool.h"
#import "AFNetworking.h"

#define FAKE_SERVER @"http://apitest.youziyue.com"//@"http://119.254.110.241:80/" //Login 线下测试

//#define FAKE_SERVER @"http://125.215.37.92:8081/PhonePospInterface/"
//#define ContentType @"text/plain"
#define ContentType @"text/html"

@implementation AFHttpTool
+ (void)requestWihtMethod:(RequestMethodType)methodType url:(NSString *)url params:(NSDictionary *)params Authorized:(BOOL)authorized success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSURL *baseURL = [NSURL URLWithString:FAKE_SERVER];
    
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    if (authorized) {
       [mgr.requestSerializer setValue:@"Cache-Control" forHTTPHeaderField:@"no-cache"];
        NSDictionary *header = [AFHttpTool headerDictionary:[AFHttpTool tokenWithBasicEncyption:@"0eba59092f839bada32dcde9b964b9e2"]];
       // NSLog(@"%@",header);
        for (NSString *key in header.allKeys) {
            //设置请求头
            [mgr.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }

    }
    NSMutableSet *types = [NSMutableSet setWithSet:mgr.responseSerializer.acceptableContentTypes];
    [types addObject:@"text/plain"];
    [types addObject:@"text/html"];
    [types addObject:@"application/json"];
    mgr.responseSerializer.acceptableContentTypes = types;
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
            case RequestMethodTypePost:
        {
            [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        default:
            break;
    }
}

+(void)postImageWithurl:(NSString *)url params:(NSDictionary *)params Authorized:(BOOL)authorized success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSURL *baseURL = [NSURL URLWithString:FAKE_SERVER];
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    if (authorized) {
        [mgr.requestSerializer setValue:@"Cache-Control" forHTTPHeaderField:@"no-cache"];
        NSDictionary *header = [AFHttpTool headerDictionary:[AFHttpTool tokenWithBasicEncyption:@"0eba59092f839bada32dcde9b964b9e2"]];
        // NSLog(@"%@",header);
        for (NSString *key in header.allKeys) {
            //设置请求头
            [mgr.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
        
    }
    NSMutableSet *types = [NSMutableSet setWithSet:mgr.responseSerializer.acceptableContentTypes];
    [types addObject:@"text/plain"];
    [types addObject:@"text/html"];
    [types addObject:@"application/json"];
    mgr.responseSerializer.acceptableContentTypes = types;
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        NSData *imageData = [[NSData alloc] init];
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(params[@"file"])) {
            //返回为png图像。
            imageData = UIImagePNGRepresentation(params[@"file"]);
        }else {
            //            返回为JPEG图像。
            imageData = UIImageJPEGRepresentation(params[@"file"], 1.0);
        }
        
         [formData appendPartWithFileData:imageData name:@"file" fileName:@"111.jpg" mimeType:@"iconImage/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


#pragma mark ---- 手机注册

+ (void)registerWithEmail:(NSString *)email mobile:(NSString *)mobile userName:(NSString *)userName password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = @{@"phone":mobile,@"code":}
    
}

//4297f44b13955235245b2497399d7a93
#pragma mark ---- 登录
+ (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
//    NSDictionary *params = @{@"phone":@"18616308960",@"pwd":@"4297f44b13955235245b2497399d7a93"};
//    [AFHttpTool requestWihtMethod:RequestMethodTypeGet
//                              url:@"/v1/guest/login"
//                           params:params
//                       Authorized:NO
//                          success:success
//                          failure:failure];
    
    NSDictionary *params = @{@"phone":@"15012341234", @"password":@"111111",@"barnd":@"4"};
    [AFHttpTool requestWihtMethod:RequestMethodTypePost url:@"SignInServlet" params:params Authorized:NO success:success failure:failure];
    
}
#pragma mark ----  请求同校人
+ (void)getSchoolFriendWithTid:(NSString *)tid page:(NSString *)page size:(NSString *)size success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = @{@"tid":tid,@"page":page,@"size":size};
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet url:@"/v1/tag/group/user" params:param Authorized:YES success:success failure:failure];
    
}
#pragma mark ---- 获取首页（自己发的贴，用户的学校发的贴，用户关注的人的，关注的小组的，推荐的）
/**
 * @param page 选填 当前页数
 */


/*
 
 
 itemList =     (
 {
 comment =             (
 );
 "follow_status" = follow;
 "item_add_time" = "2015-08-25 14:16:06";
 "item_comment_num" = 0;
 "item_content" = cdwc;
 "item_description" = "";
 "item_follow_num" = 0;
 "item_highlight" = "<null>";
 "item_id" = 5425;
 "item_ip" = "101.81.51.116";
 "item_keyword" = "";
 "item_share_num" = 0;
 "item_style" = 1;
 "item_title" = ce;
 "item_type" = text;
 "item_url" = c6437739;
 "item_view_num" = 0;
 "item_zan_num" = 0;
 tags =             (
 {
 icon = "/img/default/icon_school.jpg";
 "tag_follow_num" = 4;
 "tag_id" = 1;
 "tag_name" = "\U5176\U5b83\U5b66\U6821";
 "tag_name_en" = other;
 "tag_type" = school;
 "tag_url" = other;
 }
 );
 url = "/v1/item/c6437739?type=text";
 userData =             {
 "account_url" = "/v1/users/62b134da/post";
 "school_id" = 580;
 "school_name" = "\U9999\U6e2f\U79d1\U6280\U5927\U5b66";
 "school_name_en" = "Hong Kong University of Science and Technology";
 "school_url" = "hong_kong_university_of_science_and_technology";
 "upfile_id" = 36380;
 "user_admin_ip" = 0;
 "user_chat_num" = 0;
 "user_face_l" = "http://picapi.youziyue.com/2015/0902/23413043671387_160x160.png";
 "user_face_m" = "http://picapi.youziyue.com/2015/0902/23413043671387_100x100.png";
 "user_face_s" = "http://picapi.youziyue.com/2015/0902/23413043671387_50x50.png";
 "user_follow_num" = 0;
 "user_following_num" = 0;
 "user_gender" = 2;
 "user_id" = 71072;
 "user_item_num" = 4;
 "user_latitude" = "51.509980";
 "user_location_time" = "<null>";
 "user_longitude" = "-0.133700";
 "user_name" = qwer;
 "user_notice_num" = 5;
 "user_rongcloud" = "ZrDtFPiy0JmFFCW4YoB38AlDU9rQNpA8G9Fy4YnWTeylQJzdTagNiq5SllQGhdze47H4ROxCMrfnQpxdWFeEzA==";
 "user_sign" = tttttttt;
 "user_status" = 1;
 "user_url" = 62b134da;
 "user_xiao" = 0;
 };
 "user_id" = 71072;
 "zan_status" = zan;
 },

 
 */
+ (void)loadMixedPostWithPage:(NSString *)pageNum success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *params = @{@"page":pageNum};
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet url:@"/v1/item/list/all" params:params Authorized:YES success:success failure:failure];
}

+ (void)loadTagsItemWithTags:(NSString *)tags andPage:(NSString *)page andSize:(NSString *)size success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *params = @{@"tags":tags,@"page":page,@"size":size};
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet url:@"/v1/item/list/tagsitem" params:params Authorized:YES success:success failure:failure];
}

+ (NSDictionary *)headerDictionary:(NSString *)str {
    //获取名为 accessToken 的本地数据, 转化为字典
    NSDictionary *headerDic = [NSDictionary dictionaryWithObject:str forKey:@"Authorization"];
    return headerDic;
}

+(NSString *)base64:(NSString *)input{
    NSData *tokenData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [tokenData base64EncodedStringWithOptions:0];
    return base64String;
}

+(NSString *)tokenWithBasicEncyption:(NSString *)input{
    //token with column
    NSString *token = [NSString stringWithFormat:@"%@:",input];
    //"Basic " + base64(token + ":")
    NSString *encpyt = [NSString stringWithFormat:@"Basic %@",[self base64:token]];
   // NSLog(@"encpyt is %@\n", encpyt);
    return encpyt;
}

+ (void)postImageWithData:(NSDictionary *)params andName:(NSString *)name andChunk:(NSUInteger)chunk success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [AFHttpTool postImageWithurl:@"/v1/upload/tmp" params:params Authorized:YES success:success failure:failure];
}

+ (void)loadMessageLast:(NSString *)last andNum:(NSString *)num success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = @{@"last":last,@"num":num};
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet url:@"/v1/notice/list" params:param Authorized:YES success:success failure:failure];
}

@end
