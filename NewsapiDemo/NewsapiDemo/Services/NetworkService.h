//
//  NetworkService.h
//  NewsapiDemo
//
//  Created by Leonid Petrov on 07/09/2019.
//  Copyright © 2019 Leonid Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NetworkService;

NetworkService *NetworkServiceInstance(void);

@interface NetworkService : NSObject
+ (NetworkService *)instance;
- (void)getJsonResponse:(NSString *)urlString success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;
- (NSString *)constructUrlForTopHeadlines;
- (void)downloadImage:(NSString *)imageUrl success:(void (^)(UIImage *image))success failure:(void(^)(NSError* error))failure;
@end

NS_ASSUME_NONNULL_END
