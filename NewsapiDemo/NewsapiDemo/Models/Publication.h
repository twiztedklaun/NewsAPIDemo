//
//  Publication.h
//  NewsapiDemo
//
//  Created by Leonid Petrov on 07/09/2019.
//  Copyright © 2019 Leonid Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

@interface Publication : NSObject
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSNumber *totalResults;
@property (nonatomic, strong) NSArray *articles;

- (id)initFromJson:(NSDictionary *)jsonData;
@end

NS_ASSUME_NONNULL_END
