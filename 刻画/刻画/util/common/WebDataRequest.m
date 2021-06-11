//
//  WebDataRequest.m
//  WhereTheDragon
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "WebDataRequest.h"


@implementation WebDataRequest



+ (NSURL *) getImagePath:(ImagePath) imagePath ImageName:(NSString *) imageName
{
    NSString *str;
    if (imagePath == ImagePathZodiac) {
        str = [NSString stringWithFormat:@"%@/zodiac/%@",IMAGEPATH,imageName];
    }else if (imagePath == ImagePathConstellation) {
        str = [NSString stringWithFormat:@"%@/constellation/%@",IMAGEPATH,imageName];
    }else if (imagePath == ImagePathImage) {
        str = [NSString stringWithFormat:@"%@/image/%@",IMAGEPATH,imageName];
    }else if (imagePath == ImagePathTemplet) {
        str = [NSString stringWithFormat:@"%@/templet/%@",IMAGEPATH,imageName];
    }else if (imagePath == ImagePathCard) {
        str = [NSString stringWithFormat:@"%@/card/%@",IMAGEPATH,imageName];
    }else if (imagePath == ImagePathZodiacgif) {
        str = [NSString stringWithFormat:@"%@/zodiacgif/%@",IMAGEPATH,imageName];
    }else
        str = [NSString stringWithFormat:@"%@/default/%@",IMAGEPATH,imageName];
    
    
    return [[NSURL alloc] initWithString:str];
}

- (id) initWithDelegate:(id<WebDataRequestDelegate>) delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void) requestData:(NSDictionary *) params action:(NSString *) action
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",HTTP,action];
    
    [self requestData:params urlStr:urlStr];
}


- (void) requestData:(NSDictionary *) params urlStr:(NSString *) urlStr
{
    if ([WebDataRequest getNetStatus] == kNotReachable) {
        
        [_delegate finishRequest:nil isError:YES error:@"无网络！"];
        
        return ;
    }
    
    
    NSArray *keys = [params allKeys];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    _request = [ASIFormDataRequest requestWithURL:url];
    [_request setRequestMethod:@"POST"];
    
    [_request setTimeOutSeconds:20];
    
    for (NSString *key in keys) {
        [_request setPostValue:[params objectForKey:key] forKey:key];
    }
    
    __block ASIFormDataRequest *request = _request;
    __block id<WebDataRequestDelegate> delegate = _delegate;
    
    
    [_request setCompletionBlock:^{
        NSError *error;
        NSData *response = request.responseData;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        if (error) {
            if (delegate) {
                [delegate finishRequest:nil isError:YES error:@"读取数据失败！"];
            }
        }else{
            
            NSString *theError = [dic objectForKey:@"error"];
            
            if ([theError intValue] == 1) {
                
                [delegate finishRequest:nil isError:YES error:[dic objectForKey:@"errormsg"]];
                
            }else{
                NSArray *ar = [dic objectForKey:@"datas"];
                [delegate finishRequest:ar isError:NO error:nil];
                
            }
        }
        
    }];
    
    
    
    [_request setFailedBlock:^{
        if (delegate) {
            [delegate finishRequest:nil isError:YES error:@"请求失败！"];
        }
    }];
    
    
    [_request startAsynchronous];
}


- (void) requestImageData:(ImagePath) ImagePath ImageName:(NSString *) imageName
{
    if ([WebDataRequest getNetStatus] == kNotReachable) {
        
        [_delegate finishRequest:nil isError:YES error:@"无网络！"];
        
        return ;
    }
    
    NSURL *url = [WebDataRequest getImagePath:ImagePath ImageName:imageName];
    
    _request = [ASIFormDataRequest requestWithURL:url];
    [_request setRequestMethod:@"POST"];
    
    [_request setTimeOutSeconds:20];
    
    __block ASIFormDataRequest *request = _request;
    __block id<WebDataRequestDelegate> delegate = _delegate;
    
    [_request setCompletionBlock:^{
//        NSError *error;
        NSData *response = request.responseData;
        
        [delegate finishImageRequest:response isError:NO error:nil];
        
    }];
    
    
    
    [_request setFailedBlock:^{
        if (delegate) {
            [delegate finishRequest:nil isError:YES error:@"请求失败！"];
        }
    }];
    
    
    [_request startAsynchronous];
}


- (void) getAppVisonMsg:(NSString *) appId
{
    if ([WebDataRequest getNetStatus] == kNotReachable) {
        
        [_delegate finishRequest:nil isError:YES error:@"无网络！"];
        
        return ;
    }
    
    NSString *strUrl = @"http://itunes.apple.com/lookup";
    
    NSDictionary *params = @{@"id": appId};
    
    NSArray *keys = [params allKeys];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    _request = [ASIFormDataRequest requestWithURL:url];
    
    [_request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    
    [_request setRequestMethod:@"POST"];
    
    [_request setTimeOutSeconds:20];
    
    for (NSString *key in keys) {
        [_request setPostValue:[params objectForKey:key] forKey:key];
    }
    
    __block ASIFormDataRequest *request = _request;
    __block id<WebDataRequestDelegate> delegate = _delegate;
    
    
    [_request setCompletionBlock:^{
        NSError *error;
        NSData *response = request.responseData;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        if (error) {
            if (delegate) {
                [delegate finishRequest:nil isError:YES error:@"读取数据失败！"];
            }
        }else{
            
            NSArray *ar = [dic objectForKey:@"results"];
            
            if (ar.count < 1) {
                
                [delegate finishRequest:nil isError:YES error:[dic objectForKey:@"读取数据失败！"]];
                
            }else{
                
                [delegate finishRequest:ar isError:NO error:nil];
                
            }
        }
        
    }];
    
    
    
    [_request setFailedBlock:^{
        if (delegate) {
            [delegate finishRequest:nil isError:YES error:@"请求失败！"];
        }
    }];
    
    
    [_request startAsynchronous];
    
}

+ (NetworkStatus) getNetStatus
{
    //监听网络
    Reachability *reachbility = [Reachability reachabilityForInternetConnection];
    [reachbility startNotifier];
    NetworkStatus status = reachbility.currentReachabilityStatus;
    
    return status;
}

+ (void) forImageWithCache:(UIImageView *) imageView WithURL:(NSURL *) url placeholderImage:(UIImage *) pImage
{
    
    
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:[url absoluteString]];
    
    if (image) {
        imageView.image = image;
    }else{
        
        [imageView setImageWithURL:url placeholderImage:pImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            [[SDImageCache sharedImageCache] storeImage:image forKey:[url absoluteString]];
            
        }];
        
    }
    
}

@end
