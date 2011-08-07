#import "QuestionViewCell.h"

@implementation QuestionViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    app = (SMART3QAAppDelegate*)[[UIApplication sharedApplication]delegate];
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        questionImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        questionImage.image = [app resizeImage:[UIImage imageNamed:@"questionbaloon.png"] scaleToSize:CGSizeMake(36, 36)];
        [self.contentView addSubview:questionImage];
        
        answerCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [answerCountLabel setFont:[UIFont boldSystemFontOfSize:24]];
        [answerCountLabel setBackgroundColor:[UIColor clearColor]];
        [answerCountLabel setTextColor:[UIColor whiteColor]];
        [answerCountLabel setTextAlignment:UITextAlignmentCenter];
        [self.contentView addSubview:answerCountLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:titleLabel];
        
        tagsImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        tagsImage.image = [app resizeImage:[UIImage imageNamed:@"tagsneg.png"] scaleToSize:CGSizeMake(15, 15)];
        
        tagsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [tagsLabel setFont:[UIFont systemFontOfSize:12]];
        [tagsLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:tagsLabel];
        
        tableDividerImage = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 41, 640, 1)];
        tableDividerImage.image = [UIImage imageNamed:@"tabledivider.png"];
        [self.contentView addSubview:tableDividerImage];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect contentRect = self.contentView.bounds;
    
    CGRect imageRect = contentRect;
    imageRect.origin.x = imageRect.origin.x + 3;
    imageRect.origin.y = imageRect.origin.y + 3;
    imageRect.size.height = 36;
    imageRect.size.width = 36;
    questionImage.frame = imageRect;
    
    CGRect answerRect = contentRect;
    answerRect.origin.x = imageRect.origin.x;
    answerRect.origin.y = imageRect.origin.y - 5;
    answerRect.size.height = imageRect.size.height;
    answerRect.size.width = imageRect.size.width;
    answerCountLabel.frame = answerRect;
    
    CGRect titleRect = contentRect;
    titleRect.origin.x = imageRect.origin.x + imageRect.size.width + 5;
    titleRect.origin.y = imageRect.origin.y;
    titleRect.size.height = 20;
    titleRect.size.width = 250;
    titleLabel.frame = titleRect;
    
    CGRect tagsImageRect = contentRect;
    tagsImageRect.origin.x = titleRect.origin.x;
    tagsImageRect.origin.y = titleRect.origin.y + titleRect.size.height;
    tagsImageRect.size.width = 15;
    tagsImageRect.size.height = 15;
    tagsImage.frame = tagsImageRect;
    
    CGRect tagsRect = contentRect;
    tagsRect.origin.x = tagsImageRect.origin.x + tagsImageRect.size.width + 2;
    tagsRect.origin.y = tagsImageRect.origin.y;
    tagsRect.size.width = 250;
    tagsRect.size.height = 15;
    tagsLabel.frame = tagsRect;
}

- (void)loadQuestion:(Question *)question
{
    [answerCountLabel setText: [NSString stringWithFormat:@"%d", [question getAnswerCount]]];
    [titleLabel setText: [question getTitle]];
    if([[question getTags] count] > 0)
    {
        [tagsLabel setText:[app getTagsForQuestion:question]];
        [self.contentView addSubview:tagsImage];
    }
}

@end