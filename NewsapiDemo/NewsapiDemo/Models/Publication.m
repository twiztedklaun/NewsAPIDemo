//
//  Publication.m
//  NewsapiDemo
//
//  Created by Leonid Petrov on 07/09/2019.
//  Copyright © 2019 Leonid Petrov. All rights reserved.
//

#import "Publication.h"
#import "Article.h"

@implementation Publication

- (id)initFromJson:(NSDictionary *)jsonData {
    self = [super init];
    if (self) {
        self.status = jsonData[@"status"];
        self.totalResults = jsonData[@"totalResults"];
        self.articles = [self createArticles:jsonData[@"articles"]];
    }
    return self;
}

- (NSArray *)createArticles:(NSArray *)articles {
    NSMutableArray *totalArticles = [NSMutableArray new];
    for (NSDictionary *dictionary in articles) {
        Article *article = [[Article alloc] init];
        article.sourceId = dictionary[@"source"][@"id"];
        article.sourceName = dictionary[@"source"][@"name"];
        article.author = dictionary[@"author"];
        if (dictionary[@"urlToImage"] != [NSNull null]) {
            article.urlToImage = dictionary[@"urlToImage"];
        } else {
            article.urlToImage = @"";
        }
        article.content = dictionary[@"content"];
        if (dictionary[@"title"] != [NSNull null]) {
            article.title = dictionary[@"title"];
        } else {
            article.title = @"";
        }
        article.publishDate = dictionary[@"publishedAt"];
        if (dictionary[@"description"] != [NSNull null]) {
            article.articleDescription = dictionary[@"description"];
        } else {
            article.articleDescription = @"";
        }
        article.url = dictionary[@"url"];
        [totalArticles addObject:article];
    }
    return [NSArray arrayWithArray:totalArticles];
}

@end
