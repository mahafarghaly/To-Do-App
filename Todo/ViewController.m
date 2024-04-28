//
//  ViewController.m
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import "ViewController.h"
#import "TaskViewController.h"
#import "CustomCell.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.searchBar.delegate = self;
     
    self.toDoTable.delegate = self;
    self.toDoTable.dataSource = self;
     //[self.toDoTable reloadData];
     self.filteredTasks = [NSArray array];
}


//*************

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

     
        if (task.status == TaskStatusToDo) {
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

 

  [self.toDoTable registerClass:[CustomCell class] forCellReuseIdentifier:@"cell"];
     self.sectionedTasks = sectionedTasks;
    [self.toDoTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


        return 3;

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [self.sectionedTasks allKeys];
    return keys[section];
    

      
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keys = [self.sectionedTasks allKeys];
    NSString *key = keys[section];
    NSArray *tasksInSection = self.sectionedTasks[key];
    return tasksInSection.count;

      }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSArray *keys = [self.sectionedTasks allKeys];
    NSString *key = keys[indexPath.section];
    NSArray *tasksInSection = self.sectionedTasks[key];
    
    
    //if (tasks.count > 0 ) {
        Task *task = tasksInSection[indexPath.row];
        cell.titleLabel.text = task.title;
      
        cell.circleImageView.image = [UIImage imageNamed:@"todo.png"];
    //}

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}
//********
//delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
 
        NSArray *keys = [self.sectionedTasks allKeys];
        NSString *key = keys[indexPath.section];
        NSMutableArray *tasksInSection = self.sectionedTasks[key];
        [tasksInSection removeObjectAtIndex:indexPath.row];
        
        // Update NSUserDefaults
        NSMutableArray *tasksArray = [NSMutableArray new];
        for (NSString *key in self.sectionedTasks) {
            NSArray *tasks = self.sectionedTasks[key];
            for (Task *task in tasks) {
                NSDictionary *taskDict = @{
                    @"title": task.title,
                    @"description": task.taskDescription,
                    @"date": task.date,
                    @"priority": @(task.priority)
                };
                [tasksArray addObject:taskDict];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:tasksArray forKey:@"tasks"];
        [[NSUserDefaults standardUserDefaults] synchronize];

   
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//edit**************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *keys = [self.sectionedTasks allKeys];
    NSString *key = keys[indexPath.section];
    NSArray *tasksInSection = self.sectionedTasks[key];
    Task *selectedTask = tasksInSection[indexPath.row];
    [self performSegueWithIdentifier:@"editTaskSegue" sender:selectedTask];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editTaskSegue"]) {
        TaskViewController *taskViewController = segue.destinationViewController;
        Task *selectedTask = (Task *)sender;
        taskViewController.editingTask = selectedTask;
    }
}

//search
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.filteredTasks = self.sectionedTasks;
    } else {
        NSMutableDictionary *filteredSectionedTasks = [NSMutableDictionary dictionary];
        
        for (NSString *priorityKey in self.sectionedTasks) {
            NSArray *tasks = self.sectionedTasks[priorityKey];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", searchText];
            NSArray *filteredTasks = [tasks filteredArrayUsingPredicate:predicate];
            
            if (filteredTasks.count > 0) {
                filteredSectionedTasks[priorityKey] = filteredTasks;
            }
        }
        
        self.filteredTasks = filteredSectionedTasks;
    }
    
    [self.toDoTable reloadData];
}


@end
