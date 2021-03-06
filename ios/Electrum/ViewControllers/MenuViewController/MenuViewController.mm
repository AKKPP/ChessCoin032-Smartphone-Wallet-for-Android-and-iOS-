//
//  MenuViewController.m
//  Horoscopes
//
//  Created by Jasf on 05.11.2017.
//  Copyright © 2017 Mail.Ru. All rights reserved.
//

#import "LGSideMenuController.h"
#import "MenuViewController.h"
#import "Managers.h"

typedef NS_ENUM(NSInteger, MenuRows) {
    HistoryRow,
    SettingsRow,
    FeedbackRow,
    RowsCount
};

static CGFloat const kGenericOffset = 8.f;
static CGFloat const kHoroscopeCellBottomOffset = 8.f;

static CGFloat const kRowHeight = 40.f;
static CGFloat const kHeaderViewHeight = 20.f;
static CGFloat const kSeparatorAlpha = 0.25f;

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MenuViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [[UIColor whiteColor] colorWithAlphaComponent:kSeparatorAlpha];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide:) name:LGSideMenuDidHideLeftViewNotification object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleCell" bundle:nil] forCellReuseIdentifier:@"SimpleCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect frame = self.view.bounds;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height += statusBarHeight;
    frame.origin.y -= statusBarHeight;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return RowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
    cell.textLabel.textColor = [UIColor whiteColor];
    switch (indexPath.row) {
        case HistoryRow: cell.textLabel.text = L(@"History"); break;
        case SettingsRow: cell.textLabel.text = L(@"Settings"); break;
        case FeedbackRow: cell.textLabel.text = L(@"Feedback"); break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case HistoryRow: {
            if ([_handler respondsToSelector:@selector(walletTapped:)]) {
                [_handler walletTapped:nil];
            }
            break;
        }
        case SettingsRow: {
            if ([_handler respondsToSelector:@selector(settingsTapped:)]) {
                [_handler settingsTapped:nil];
            }
            break;
        }
        case FeedbackRow: {
            [[Managers shared].feedbackManager showFeedbackController:self];
            break;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - Observers
- (void)menuDidHide:(id)sender {
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointZero;
}

@end
