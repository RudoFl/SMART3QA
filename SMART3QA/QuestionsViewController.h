#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface QuestionsViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    SMART3QAAppDelegate* app;
}

@end
