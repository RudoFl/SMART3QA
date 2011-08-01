#import "TagDetailsController.h"
#import "Tag.h"

@implementation TagDetailsController

- (void)setup
{   
    app = (SMART3QAAppDelegate*)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 30)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:titleLabel];
    
    excertLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x,
                                                          titleLabel.frame.origin.y + titleLabel.frame.size.height + 5,
                                                          310,
                                                          0)];
    [excertLabel setFont:[UIFont systemFontOfSize:12]];
    [excertLabel setBackgroundColor:[UIColor clearColor]];
    [excertLabel setLineBreakMode:UILineBreakModeWordWrap];
    [self.view addSubview:excertLabel];
}

- (void)loadTag:(Tag *)tag
{
    [app downloadDataForTag:[tag getTagId]];
    [self setTitle:[tag getName]];
    [titleLabel setText:[tag getName]];
    [excertLabel setText:[tag getExcert]];
    CGSize labelsize = [[tag getExcert] sizeWithFont:excertLabel.font 
                                      constrainedToSize:CGSizeMake(310, 9999) 
                                          lineBreakMode:titleLabel.lineBreakMode];
    CGRect excertRect = excertLabel.frame;
    excertRect.size.height = labelsize.height;
    excertLabel.frame = excertRect;
    [excertLabel setNumberOfLines:labelsize.height / excertLabel.font.lineHeight];
}

@end