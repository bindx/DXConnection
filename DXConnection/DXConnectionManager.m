//
//  DXConnectionManager.m
//  HttpRequest
//
//  Created by Bindx on 9/28/14.
//  Copyright (c) 2014 Bindx. All rights reserved.
//

#import "DXConnectionManager.h"

static DXConnectionManager *netshared;

@implementation DXConnectionManager{
    NSOperationQueue *downloadQueue;
    int i;
}

+ (DXConnectionManager *)shareManager{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        netshared = [[self alloc]init];
    });
    return netshared;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        downloadQueue = [[NSOperationQueue alloc]init];
        downloadQueue.maxConcurrentOperationCount = MAX_CONCURRENT_OPEATION_COUNT;
        i = 0;
    }
    return self;
}

- (void)maxConcurrentOperationCount:(int)max{
    if (max>0) {
        downloadQueue.maxConcurrentOperationCount = max;
    }
}

- (void)addRequest: (DXRequest *)request{
    DXConnectionOperation * opertion = [[DXConnectionOperation alloc]initWithRequest:request];
    [downloadQueue addOperation:opertion];
    i++;
}

- (DXResponse *)addSynchronizedRequest:(DXRequest *)request{
    NSError *error;
    NSURLResponse *response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request.request returningResponse:&response error:&error];
    DXResponse * resp = [[DXResponse alloc]init];
    resp.response = response;
    resp.responseData = data;
    resp.error = error;
    return resp;
}

@end
