//
//  DXConnectionOperation.h
//  HttpRequest
//
//  Created by Bindx on 9/28/14.
//  Copyright (c) 2014 Bindx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXConnectionDeletage;
@class DXRequest;
@class DXResponse;


@protocol DXConnectionDeletage <NSObject>

- (void)downloadDidFinish:(NSDictionary *)response;

@end

@interface DXConnectionOperation : NSOperation

@property (nonatomic, strong) DXRequest *request;
@property (nonatomic, strong) DXResponse *response;
@property (nonatomic, strong) NSObject <DXConnectionDeletage> *delegate;

- (id)initWithRequest:(DXRequest *)request;

@end
