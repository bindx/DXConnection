//
//  DXRequest.h
//  HttpRequest
//
//  Created by Bindx on 9/28/14.
//  Copyright (c) 2014 Bindx. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DXNET ((DXRequest *)[DXRequest shareManager])

@class DXConnectionOperation;
@class DXResponse;

@protocol DXConnectionDeletage;

typedef NS_OPTIONS(NSUInteger, CAllBackType) {
    CAllBackTypeBlock = 0,
    CAllBackTypeDelegate
};

typedef void(^CompleteBlock) (NSDictionary *dic,NSError *error);

@interface DXRequest : NSObject

@property (nonatomic,weak    ) id<DXConnectionDeletage> delegate;
@property (nonatomic,copy    ) CompleteBlock        completeblock;
@property (nonatomic,readonly) CAllBackType         callbacktype;
@property (nonatomic,strong  ) NSMutableURLRequest  *request;
@property (nonatomic) int      expectedSize;

+ (DXRequest *)shareManager;

#pragma mark - init

- (id)initWithRequestURL:(NSString *)url CannBacktype:(CAllBackType)type methodPost:(BOOL)method ParamtersDat:(NSData *)paramDat ParamterStr:(NSString *)paraStr delegate:(id<DXConnectionDeletage>)delegate_ WithCompleteBlock:(CompleteBlock)block;

#pragma mark - Methods of Block

+ (void)getDataWithUrlStr:(NSString *)url WithCompleteBlcok:(CompleteBlock)block;
+ (void)PostStrWithUrlStr:(NSString *)url Paramters:(NSString *)params WithCompleteBlcok:(CompleteBlock)block;
+ (void)PostDataWithUrlStr:(NSString *)url Paramters:(NSData *)params WithCompleteBlcok:(CompleteBlock)block;

#pragma mark - Methods of Delagate

+ (void)getDataWithUrlStr:(NSString *)url WithCompleteDelegate:(id<DXConnectionDeletage>)delegate;
+ (void)PostStrWithUrlStr:(NSString *)url Paramters:(NSString *)params WithCompleteDelegate:(id<DXConnectionDeletage>)delegate;
+ (void)PostDataWithUrlStr:(NSString *)url Paramters:(NSData *)params WithCompleteDelegate:(id<DXConnectionDeletage>)delegate;


@end
