#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface TagsViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    SMART3QAAppDelegate* app;
}

@end
