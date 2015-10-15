# DXConnection

####使用CocoaPods
</p>

    pod 'DXConnection',:git=>"https://github.com/bindx/DXConnection.git"


###使用方法

##---GET请求

#####-Block方式
    [DXRequest getDataWithUrlStr:@"http://getxxxx.com" WithCompleteBlcok:^(NSDictionary *dic, NSError   *error) {
        
    }];
    
#####-Delegate方式

    [DXRequest getDataWithUrlStr:@"http://getxxxx.com" WithCompleteDelegate:self];

    
##---POST请求

#####-Block方式

    [DXRequest PostStrWithUrlStr:@"http://postxxxx.com" Paramters:@"xxxx" WithCompleteBlcok:^(NSDictionary *dic, NSError *error) {
        
    }];
    
        
    [DXRequest PostDataWithUrlStr:@"http://postdata.com" Paramters:xxxx WithCompleteBlcok:^(NSDictionary *dic, NSError *error) {
       
     }];
    
    
#####-Delegate方式

    [DXRequest PostDataWithUrlStr:@"http://postDataxxx.com" Paramters:xxxx WithCompleteDelegate:self];


...

####-Delegate实现代理 <DXConnectionDeletage

```
- (void)downloadDidFinish:(NSDictionary *)response;
```


### And more?
=============


关注GitHub <https://github.com/bindx/OWSDemo.git>

Follow [@Bindx](https://github.com/bindx) on GitHub for the latest update.