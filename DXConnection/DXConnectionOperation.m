//
//  DXConnectionOperation.m
//  HttpRequest
//
//  Created by Bindx on 9/28/14.
//  Copyright (c) 2014 Bindx. All rights reserved.
//

#import "DXConnectionOperation.h"
#import "DXRequest.h"
#import "DXResponse.h"

@implementation DXConnectionOperation{
    NSURLConnection *connection;
    NSMutableData *data;
    BOOL isFinished;
}

- (void)main{
    
    connection = [[NSURLConnection alloc] initWithRequest:_request.request delegate:self startImmediately:YES];
    isFinished = NO;
    if (connection) {
        do {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        } while (!isFinished);
    }
}

- (id)initWithRequest:(DXRequest *)request{
    if (self = [super init]) {
        self.request = request;
        _response = [[DXResponse alloc]init];
        _delegate = _request.delegate;
    }
    return self;
}

#pragma mark 接收到服务器回应的时回调
- (void)connection:(NSURLConnection *)connection_ didReceiveResponse:(NSURLResponse *)response_ {
    if ([[((NSHTTPURLResponse *)response_) allHeaderFields] objectForKey:@"Content-Length"]) {
        _response.expectedSize = [[[((NSHTTPURLResponse *)response_) allHeaderFields] objectForKey:@"Content-Length"] integerValue];
    }
    _response.response = response_;
    data = [[NSMutableData alloc] init];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
}

#pragma mark 接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection_ didReceiveData:(NSData *)data_{
    [data appendData:data_];
}

#pragma mark  数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection_{
    [_response setResponseData:data];
    NSDictionary *serial = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    if (_request.callbacktype == CAllBackTypeDelegate) {
        if (_request.delegate && [_request.delegate respondsToSelector:@selector(downloadDidFinish:)]) {
            [_delegate performSelectorOnMainThread:@selector(downloadDidFinish:) withObject:serial waitUntilDone:NO];
        }
    }
    
    if(_request.callbacktype == CAllBackTypeBlock){
        if (_request.completeblock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _request.completeblock(serial,nil);
            });
        }
    }
    isFinished = YES;
}

#pragma mark 网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection_ didFailWithError:(NSError *)error{
    [_response setError:error];
    NSDictionary * errDic = [NSDictionary dictionaryWithObject:_response.error forKey:@"error"];
    if (_request.callbacktype == CAllBackTypeDelegate) {
        if (_request.delegate && [_request.delegate respondsToSelector:@selector(downloadDidFinish:)]) {
            [_delegate performSelectorOnMainThread:@selector(downloadDidFinish:) withObject:errDic waitUntilDone:NO];
        }
    }
    
    else if(_request.callbacktype == CAllBackTypeBlock){
        if (_request.completeblock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _request.completeblock(nil,_response.error);
            });
        }
    }
    isFinished = YES;
}


@end
