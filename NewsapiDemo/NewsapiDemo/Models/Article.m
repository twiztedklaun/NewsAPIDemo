//
//  Article.m
//  NewsapiDemo
//
//  Created by Leonid Petrov on 07/09/2019.
//  Copyright © 2019 Leonid Petrov. All rights reserved.
//

#import "Article.h"
#import "NetworkService.h"

@implementation Article
- (void)setArticleImage {
    [NetworkServiceInstance() downloadImage:self.urlToImage success:^(UIImage * _Nonnull image) {
        self.image = image;
    } failure:^(NSError * _Nonnull error) {
        return;
    }];
}
@end
