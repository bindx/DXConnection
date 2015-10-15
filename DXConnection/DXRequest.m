//
//  DXRequest.m
//  HttpRequest
//
//  Created by Bindx on 9/28/14.
//  Copyright (c) 2014 Bindx. All rights reserved.
//

#import "DXRequest.h"
#import "DXNetPublic.h"
#import "DXConnectionManager.h"

@implementation DXRequest

static DXRequest * share = nil;

+ (DXRequest *)shareManager{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        share = [[DXRequest alloc]init];
    });
    return share;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _request = [[NSMutableURLRequest alloc]init];
    }
    return self;
}

/**
    HTTP - GET
 */
+ (void)getDataWithUrlStr:(NSString *)url WithCompleteBlcok:(CompleteBlock)block{
    [DXCONNECT_MANAGER addRequest:[DXNET initWithRequestURL:url CannBacktype:CAllBackTypeBlock methodPost:NO ParamtersDat:nil ParamterStr:nil delegate:nil WithCompleteBlock:[block  copy]]];
}

+ (void)getDataWithUrlStr:(NSString *)url WithCompleteDelegate:(id<DXConnectionDeletage>)delegate{
    [DXCONNECT_MANAGER addRequest: [DXNET initWithRequestURL:url CannBacktype:CAllBackTypeDelegate methodPost:NO ParamtersDat:nil ParamterStr:nil delegate:delegate WithCompleteBlock:nil]];
}

/**
    HTTP - POSTString Block & delegate
*/
+ (void)PostStrWithUrlStr:(NSString *)url Paramters:(NSString *)params WithCompleteBlcok:(CompleteBlock)block{
    [DXCONNECT_MANAGER addRequest:[DXNET initWithRequestURL:url CannBacktype:CAllBackTypeBlock methodPost:YES ParamtersDat:nil ParamterStr:params delegate:nil WithCompleteBlock:[block copy]]];
}

+ (void)PostStrWithUrlStr:(NSString *)url Paramters:(NSString *)params WithCompleteDelegate:(id<DXConnectionDeletage>)delegate{
    [DXCONNECT_MANAGER addRequest:[DXNET initWithRequestURL:url CannBacktype:CAllBackTypeBlock methodPost:YES ParamtersDat:nil ParamterStr:params delegate:delegate WithCompleteBlock:nil]];
}

/**
    HTTP - POSTData Block & delegate
*/

+ (void)PostDataWithUrlStr:(NSString *)url Paramters:(NSData *)params WithCompleteBlcok:(CompleteBlock)block{
    [DXCONNECT_MANAGER addRequest:[DXNET initWithRequestURL:url CannBacktype:CAllBackTypeBlock methodPost:YES ParamtersDat:params ParamterStr:nil delegate:nil WithCompleteBlock:[block copy]]];
}

+ (void)PostDataWithUrlStr:(NSString *)url Paramters:(NSData *)params WithCompleteDelegate:(id<DXConnectionDeletage>)delegate{
    [DXCONNECT_MANAGER addRequest:[DXNET initWithRequestURL:url CannBacktype:CAllBackTypeBlock methodPost:YES ParamtersDat:params ParamterStr:nil delegate:delegate WithCompleteBlock:nil]];
}

- (id)initWithRequestURL:(NSString *)url CannBacktype:(CAllBackType)type methodPost:(BOOL)method ParamtersDat:(NSData *)paramDat ParamterStr:(NSString *)paraStr delegate:(id<DXConnectionDeletage>)delegate_ WithCompleteBlock:(CompleteBlock)block{
        self = [super init];
        if (self) {
            _request.URL = [NSURL URLWithString:[HOSTIP stringByAppendingString:url]];
            _request.HTTPMethod = method?@"POST":@"GET";
            if ([_request.HTTPMethod isEqualToString:@"POST"]) {
                if (paramDat) {
                    [_request setHTTPBody:paramDat];
                }else{
                    [_request setHTTPBody:[paraStr dataUsingEncoding:NSUTF8StringEncoding]];
                }
            }
        }
        _callbacktype = type;
        switch (_callbacktype) {
            case CAllBackTypeDelegate:
                _delegate = delegate_;
                
                break;
            case CAllBackTypeBlock:
                _completeblock =[block copy];
                
                break;
                
            default:
                _completeblock =[block copy];
                break;
        }
        
        return self;
}

//重写description方法
- (NSString *)description {
    return [NSString stringWithFormat:@"requets url is %@, header is %@",_request.URL.absoluteString, [_request allHTTPHeaderFields]];
}

@end
