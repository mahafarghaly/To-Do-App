//
//  DoneViewController.m
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import "DoneViewController.h"
#import "Task.h"
#import "CustomCell.h"
#import "TaskViewController.h"

@interface DoneViewController ()

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.doneTable.delegate = self;
          self.doneTable.dataSource = self;
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
    NSArray *tasksArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];


    NSMutableDictionary *sectionedTasks = [NSMutableDictionary dictionary];
    sectionedTasks[@"High Priority"] = [NSMutableArray array];
    sectionedTasks[@"Medium Priority"] = [NSMutableArray array];
    sectionedTasks[@"Low Priority"] = [NSMutableArray array];


    for (NSDictionary *taskDict in tasksArray) {
        Task *task = [Task new];
        task.title = taskDict[@"title"];
        task.taskDescription = taskDict[@"description"];
        task.date = taskDict[@"date"];
        task.priority = [taskDict[@"priority"] integerValue];
        task.status = [taskDict[@"status"] integerValue];

      
        if (task.status == TaskStatusDone) {
            switch (task.priority) {
                case TaskPriorityHigh:
                    [sectionedTasks[@"High Priority"] addObject:task];
                    break;
                case TaskPriorityMedium:
                    [sectionedTasks[@"Medium Priority"] addObject:task];
                    break;
                case TaskPriorityLow:
                    [sectionedTasks[@"Low Priority"] addObject:task];
                    break;
                default:
                    break;
            }
        }
            
    }

  
  [self.doneTable registerClass:[CustomCell class] forCellReuseIdentifier:@"cell"];


     self.sectionedTasks = sectionedTasks;
    [self.doneTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.filterEnabled) {
        return 3;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSArray *keys = [self.sectionedTasks allKeys];
//    return keys[section];
    if (self.filterEnabled) {
           NSArray *keys = [self.sectionedTasks allKeys];
           return keys[section];
       } else {
           return nil;
       }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *keys = [self.sectionedTasks allKeys];
//    NSString *key = keys[section];
//    NSArray *tasksInSection = self.sectionedTasks[key];
//    return tasksInSection.count;
    if (self.filterEnabled) {
          NSArray *keys = [self.sectionedTasks allKeys];
          NSString *key = keys[section];
          NSArray *tasksInSection = self.sectionedTasks[key];
          return tasksInSection.count;
      } else {
         
          return self.sectionedTasks.count;
      }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (self.filterEnabled) {
        NSArray *keys = [self.sectionedTasks allKeys];
        NSString *key = keys[indexPath.section];
        NSArray *tasksInSection = self.sectionedTasks[key];
        if (tasksInSection.count > 0) {
            Task *task = tasksInSection[indexPath.row];
            cell.titleLabel.text = task.title;
          
            cell.circleImageView.image = [UIImage imageNamed:@"done.png"];
        }
    }


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}
- (IBAction)btnFilterDone:(UIButton *)sender {
    self.filterEnabled = !self.filterEnabled;
    

    [self.doneTable reloadData];
}




@end
