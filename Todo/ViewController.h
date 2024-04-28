//
//  ViewController.h
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface ViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) NSArray *filteredTasks;
//@property  NSArray<Task *> *tasks;
@property (nonatomic, strong) NSMutableArray *tasks;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property (nonatomic, strong) NSDictionary *sectionedTasks;



@end

