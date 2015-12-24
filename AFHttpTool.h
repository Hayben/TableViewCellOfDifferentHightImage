//
//  AFHttpTool.h
//  AF
//
//  Created by youziyue on 15/8/18.
//  Copyright (c) 2015年 youziyue. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};

@interface AFHttpTool : NSObject

/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void) requestWihtMethod:(RequestMethodType)methodType
                     url : (NSString *)url
                   params:(NSDictionary *)params
               Authorized:(BOOL)authorized
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure;


+ (void)postImageWithurl:(NSString *)url params:(NSDictionary *)params Authorized:(BOOL)authorized success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//login
+(void) loginWithEmail:(NSString *) email
              password:(NSString *) password
            success:(void (^)(id response))success
               failure:(void (^)(NSError* err))failure;

//reg email mobile username password

+(void) registerWithEmail:(NSString *) email
                   mobile:(NSString *) mobile
                 userName:(NSString *) userName
                 password:(NSString *) password
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure;

+(void) getSchoolFriendWithTid:(NSString *)tid
                          page:(NSString *)page
                          size:(NSString *)size
                       success:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure;
+(void)loadMixedPostWithPage:(NSString *)pageNum
                     success:(void (^)(id response))success
                     failure:(void (^)(NSError* err))failure;
#pragma mark ----获取指定学校/小组的帖子列表
/**
 * @param tags 必填 学校/小组的id，多个用逗号隔开
 * @param page 选填 当前页数
 * @param size 选填 每页显示帖子数
 */
+ (void)loadTagsItemWithTags:(NSString *)tags
                     andPage:(NSString *)page
                     andSize:(NSString *)size
                     success:(void (^)(id response))success
                     failure:(void (^)(NSError* err))failure;;

+ (void)postImageWithData:(NSDictionary *)params
                  andName:(NSString *)name
                 andChunk:(NSUInteger)chunk
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure;
+ (void)loadMessageLast:(NSString *)last
                 andNum:(NSString *)num
                success:(void (^)(id response))success
                failure:(void (^)(NSError* err))failure;
@end
