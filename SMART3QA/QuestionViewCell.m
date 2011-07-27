#import "QuestionViewCell.h"

@implementation QuestionViewCell

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
        
        userLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [userLabel setFont:[UIFont systemFontOfSize:12]];
        [userLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:userLabel];
        
        createdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [createdLabel setFont:[UIFont systemFontOfSize:12]];
        [createdLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:createdLabel];
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
    titleRect.size.height = 20;
    titleRect.size.width = 250;
    titleLabel.frame = titleRect;
    
    CGRect userIdRect = contentRect;
    userIdRect.origin.x = titleRect.origin.x;
    userIdRect.origin.y = titleRect.origin.y + titleRect.size.height + 5;
    userIdRect.size.width = 250;
    userIdRect.size.height = 15;
    userLabel.frame = userIdRect;
    
    CGRect createdRect = contentRect;
    createdRect.origin.x = titleRect.origin.x;
    createdRect.origin.y = userIdRect.origin.y + userIdRect.size.height;
    createdRect.size.width = 250;
    createdRect.size.height = 15;
    createdLabel.frame = createdRect;
}

- (void)loadQuestion:(Question *)question
{
    [answerCountLabel setText: [NSString stringWithFormat:@"%d", [question getAnswerCount]]];
    [titleLabel setText: [question getTitle]];
    [userLabel setText: [[NSString stringWithString:@"By: "] stringByAppendingString:[[app getUserForId:[question getUserId]] getName]]];
    [createdLabel setText:[app timeSinceDate:[question getCreated]]];
}

@end