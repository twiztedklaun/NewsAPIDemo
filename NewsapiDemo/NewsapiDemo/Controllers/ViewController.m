//
//  ViewController.m
//  NewsapiDemo
//
//  Created by Leonid Petrov on 07/09/2019.
//  Copyright © 2019 Leonid Petrov. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "Publication.h"
#import "Article.h"
#import "NewsCell.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SafariServices.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) Publication *publication;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setUpRefresControl];
    [self reloadPublications];
}

- (void)reloadPublications {
    [NetworkServiceInstance() getJsonResponse:[NetworkServiceInstance() constructUrlForTopHeadlines] success:^(NSDictionary * _Nonnull responseDict) {
        ViewController __weak *weakSelf = self;
        weakSelf.publication = [[Publication alloc] initFromJson:responseDict];
        [weakSelf.publication.articles enumerateObjectsUsingBlock:^(Article *article, NSUInteger idx, BOOL * _Nonnull stop) {
            [article setArticleImage];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSError * _Nonnull error) {
        return;
    }];
}

- (void)setUpRefresControl {
    _refreshControl = [[UIRefreshControl alloc]init];
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    if (@available(iOS 10.0, *)) {
        _tableView.refreshControl = _refreshControl;
    } else {
        [_tableView addSubview:_refreshControl];
    }
}

- (void)refreshTable {
    [self reloadPublications];
    [_refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _publication.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    Article *article = _publication.articles[indexPath.row];
    cell.titleLabel.text = article.title;
    cell.newsPublicationLabel.text = article.articleDescription;
    if (article.image) cell.newsImage.image = article.image;
    else [NetworkServiceInstance() downloadImage:article.urlToImage success:^(UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.newsImage.image = image;
        });
    } failure:^(NSError * _Nonnull error) {}];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Article *article = _publication.articles[indexPath.row];
    NSURL *urlToArticle = [NSURL URLWithString:article.url];
    SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:urlToArticle];
    [self presentViewController:safariController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
