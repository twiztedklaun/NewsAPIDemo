//
//  Article.h
//  NewsapiDemo
//
//  Created by Leonid Petrov on 07/09/2019.
//  Copyright © 2019 Leonid Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Article : NSObject
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *sourceName;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *articleDescription;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *urlToImage;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIImage *image;

- (void)setArticleImage;
@end

NS_ASSUME_NONNULL_END
