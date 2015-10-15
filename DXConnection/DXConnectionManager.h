//
//  DXConnectionManager.h
//  HttpRequest
//
//  Created by Bindx on 9/28/14.
//  Copyright (c) 2014 Bindx. All rights reserved.
//

#define DXCONNECT_MANAGER ((DXConnectionManager *)[DXConnectionManager shareManager])
#define MAX_CONCURRENT_OPEATION_COUNT 3

#import <Foundation/Foundation.h>
#import "DXConnectionOperation.h"
#import "DXResponse.h"
#import "DXRequest.h"

@interface DXConnectionManager : NSObject

+ (DXConnectionManager *)shareManager;

- (void)maxConcurrentOperationCount:(int)max;

- (void)addRequest: (DXRequest *)request;

- (DXResponse *)addSynchronizedRequest:(DXRequest *)request;

@end
