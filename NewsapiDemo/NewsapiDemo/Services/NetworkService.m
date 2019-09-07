//
//  NetworkService.m
//  NewsapiDemo
//
//  Created by Leonid Petrov on 07/09/2019.
//  Copyright © 2019 Leonid Petrov. All rights reserved.
//

#import "NetworkService.h"
#import <UIKit/UIKit.h>

const NSString *apiKey = @"53b930316011498695998d39779e68c2";
const NSString *url = @"https://newsapi.org/v2/top-headlines";
const NSString *country = @"ru";

NetworkService *NetworkServiceInstance(void) {
    return [NetworkService instance];
}

@implementation NetworkService

static NetworkService* manager = nil;

+ (NetworkService *)instance {
    if(manager == nil) {
        manager = [[NetworkService alloc] init];
    }
    return manager;
};

- (void)getJsonResponse:(NSString *)urlString success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSLog(@"%@",data);
                                                if (error)
                                                    failure(error);
                                                else {
                                                    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                    NSLog(@"%@",json);
                                                    success(json);
                                                }
                                            }];
    [dataTask resume];
}

- (void)downloadImage:(NSString *)imageUrl success:(void (^)(UIImage *image))success failure:(void(^)(NSError* error))failure {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:imageUrl];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSLog(@"%@",data);
                                                if (error)
                                                    failure(error);
                                                else {
                                                    UIImage *image = [UIImage imageWithData:data];
                                                    success(image);
                                                }
                                            }];
    [dataTask resume];
}

- (NSString *)constructUrlForTopHeadlines {
    return [NSString stringWithFormat:@"%@?country=%@&apiKey=%@",url,country,apiKey];
}

@end
