//
//  ProgressViewController.h
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressViewController : UIViewController<UITableViewDelegate ,UITableViewDataSource>
@property BOOL filterEnabled;
@property (nonatomic, strong) NSMutableDictionary *sectionedTasks;
@property (nonatomic, strong) NSMutableArray *tasks;
//@property (nonatomic, strong) NSDictionary *sectionedTasks;
@property (weak, nonatomic) IBOutlet UITableView *progressTable;
- (IBAction)btnFilter:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
