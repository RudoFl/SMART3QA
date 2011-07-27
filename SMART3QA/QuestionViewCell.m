#import "QuestionViewCell.h"

@implementation QuestionViewCell

@synthesize titleLabel, userIdLabel, answerCountLabel, questionImage, app;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    app = (SMART3QAAppDelegate*)[[UIApplication sharedApplication]delegate];
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        questionImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        questionImage.image = [app resizeImage:[UIImage imageNamed:@"questionbaloon.png"] scaleToSize:CGSizeMake(60, 60)];
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
        
        userIdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [userIdLabel setFont:[UIFont systemFontOfSize:12]];
        [userIdLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:userIdLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect contentRect = self.contentView.bounds;
    
    CGRect imageRect = contentRect;
    imageRect.origin.x = imageRect.origin.x + 5;
    imageRect.origin.y = imageRect.origin.y + 5;
    imageRect.size.height = 60;
    imageRect.size.width = 60;
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
    titleRect.size.height = 30;
    titleRect.size.width = 300;
    titleLabel.frame = titleRect;
    
    CGRect userIdRect = contentRect;
    userIdRect.origin.x = imageRect.origin.x + imageRect.size.width + 5;
    userIdRect.origin.y = imageRect.origin.y + 17;
    userIdRect.size.width = 200;
    userIdRect.size.height = 30;
    userIdLabel.frame = userIdRect;
}

@end