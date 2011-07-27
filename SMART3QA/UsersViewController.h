#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface UsersViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource>
{
    SMART3QAAppDelegate* app;
}

@end
