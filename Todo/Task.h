
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TaskPriority) {
   TaskPriorityLow,
   TaskPriorityMedium,
   TaskPriorityHigh
};
typedef NS_ENUM(NSInteger, TaskStatus) {
    TaskStatusToDo,
    TaskStatusInProgress,
    TaskStatusDone
};


@interface Task : NSObject

@property NSString *title;
@property NSString *taskDescription;
@property TaskPriority priority;
@property TaskStatus status;
@property  NSDate *date;
// -(instancetype)initWithTitle:(NSString *)title description:(NSString *)description priority:(TaskPriority)priority date:(NSDate *)date;



@end


