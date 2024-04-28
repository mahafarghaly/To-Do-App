//
//  TaskViewControllerDelegate.h
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaskViewControllerDelegate <NSObject>

- (void)taskViewControllerDidAddTaskWithTitle:(NSString *)title description:(NSString *)description date:(NSDate *)date priority:(NSInteger)priority;

@end
