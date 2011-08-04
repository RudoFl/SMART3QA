#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface QuestionsViewController : UITableViewController
<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *questions;
    SMART3QAAppDelegate* app;
}

- (void)loadQuestionsForUserId:(NSInteger)userId;
- (void)loadQuestionsForTagId:(NSInteger)tagId;

@end
