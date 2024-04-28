//
//  DoneViewController.h
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>
@property BOOL filterEnabled;
@property (nonatomic, strong) NSMutableDictionary *sectionedTasks;
@property (nonatomic, strong) NSMutableArray *tasks;

@property (weak, nonatomic) IBOutlet UITableView *doneTable;
- (IBAction)btnFilterDone:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
