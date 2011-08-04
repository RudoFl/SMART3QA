#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface UsersViewController : UITableViewController
    <UITableViewDelegate, UITableViewDataSource>
{
    SMART3QAAppDelegate* app;
}

@end
