//
//  DXResponse.h
//  HttpRequest
//
//  Created by Bindx on 9/28/14.
//  Copyright (c) 2014 Bindx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXResponse : NSObject

@property (nonatomic, copy) NSString *responseTarget;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic) NSInteger expectedSize;
@property (nonatomic, strong) NSError *error;
@property (nonatomic) float downloadRate;
@property (nonatomic, strong) NSURLResponse *response;

@end
