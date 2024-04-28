//
//  TaskViewController.h
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskViewController : UIViewController

@property (nonatomic, strong) Task *editingTask;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;
- (IBAction)taskbtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegmentedControl;
@end

NS_ASSUME_NONNULL_END
