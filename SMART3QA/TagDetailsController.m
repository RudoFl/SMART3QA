#import "TagDetailsController.h"
#import "Tag.h"

@implementation TagDetailsController

- (void)loadTag:(Tag *)tag
{
    [app downloadDataForTag:[tag getTagId]];
    [self setTitle:[tag getName]];
    [titleLabel setText:[tag getName]];
    
    [excerptLabel setText:[tag getExcerpt]];
    CGSize labelsize = [[tag getExcerpt] sizeWithFont:excerptLabel.font 
                                      constrainedToSize:CGSizeMake(250, 9999) 
                                          lineBreakMode:excerptLabel.lineBreakMode];
    CGRect excertRect = excerptLabel.frame;
    excertRect.size.height = labelsize.height;
    excerptLabel.frame = excertRect;
    [excerptLabel setNumberOfLines:labelsize.height / excerptLabel.font.lineHeight];
    
    /*[wikiLabel setText:[tag getWiki]];
    labelsize = [[tag getExcerpt] sizeWithFont:wikiLabel.font 
                             constrainedToSize:CGSizeMake(310, 9999) 
                                 lineBreakMode:wikiLabel.lineBreakMode];
    CGRect wikiRect = wikiLabel.frame;
    wikiRect.origin.y = excerptLabel.frame.origin.y + excerptLabel.frame.size.height + 15;
    wikiRect.size.height = labelsize.height;
    wikiLabel.frame = wikiRect;
    [wikiLabel setNumberOfLines:labelsize.height / wikiLabel.font.lineHeight];*/
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, wikiLabel.frame.origin.y + wikiLabel.frame.size.height)];
//1000)];//wikiLabel.frame.origin.y + wikiLabel.frame.size.height)];
    
    UIBarButtonItem *questionsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"questions.png"]
                                                                                            style:UIBarButtonItemStyleBordered 
                                                                                           target:self 
                                                                                           action:nil];
    [questionsButton setTitle:@"Questions"];
    self.navigationItem.rightBarButtonItem = questionsButton;
}

@end