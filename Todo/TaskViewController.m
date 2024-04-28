

#import "TaskViewController.h"
#import "Task.h"


@interface TaskViewController ()

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.editingTask) {
           self.titleTextField.text = self.editingTask.title;
           self.descTextField.text = self.editingTask.taskDescription;
           self.datePicker.date = self.editingTask.date;
           self.prioritySegmentedControl.selectedSegmentIndex = self.editingTask.priority;
           self.statusSegmentedControl.selectedSegmentIndex = self.editingTask.status;
       }
    NSLog(@"%@",self.editingTask.title);
    
}



- (IBAction)taskbtn:(UIButton *)sender {

   NSString *title = self.titleTextField.text;
    NSString *description = self.descTextField.text;
    NSInteger priorityIndex = self.prioritySegmentedControl.selectedSegmentIndex;
    TaskPriority priority = TaskPriorityLow;

    switch (priorityIndex) {
        case 0:
            priority = TaskPriorityLow;
            break;
        case 1:
            priority = TaskPriorityMedium;
            break;
        case 2:
            priority = TaskPriorityHigh;
            break;
        default:
            break;
    }
    
    NSInteger statusIndex = self.statusSegmentedControl.selectedSegmentIndex;
    TaskStatus status = TaskStatusToDo;
    switch (statusIndex) {
        case 0:
            status = TaskStatusToDo;
            break;
        case 1:
            status = TaskStatusInProgress;
            break;
        case 2:
            status = TaskStatusDone;
            break;
        default:
            break;
    }
    
    NSDate *date = self.datePicker.date;
    
    NSMutableArray *tasksArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"] mutableCopy];
    if (!tasksArray) {
        tasksArray = [NSMutableArray new];
    }
    
    if (self.editingTask) {
    
            for (int i = 0; i < tasksArray.count; i++) {
                NSDictionary *taskDict = tasksArray[i];
                if ([taskDict[@"title"] isEqualToString:self.editingTask.title]) {
                    // Update existing task
                          self.editingTask.title = title;
                          self.editingTask.taskDescription = description;
                          self.editingTask.date = date;
                          self.editingTask.priority = priorityIndex;
                          self.editingTask.status = statusIndex;
                    tasksArray[i] = @{
                        @"title": self.editingTask.title,
                        @"description": self.editingTask.taskDescription,
                        @"date": self.editingTask.date,
                        @"priority": @(self.editingTask.priority),
                        @"status": @(self.editingTask.status)
                    };
                    break;
                }
            }
      
        
    
    
    } else {
        // Create new task
        [tasksArray addObject:@{
            @"title": title,
            @"description": description,
            @"date": date,
            @"priority": @(priorityIndex),
            @"status": @(statusIndex)
        }];
    }
    
    // Save the updated tasks array back to UserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:tasksArray forKey:@"tasks"];
    
    [self.navigationController popViewControllerAnimated:YES];
  

}



@end
