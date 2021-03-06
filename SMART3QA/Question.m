#import "Question.h"

@implementation Question

- (void) setQuestionId:(NSInteger)input
{
    questionId = input;
}
- (NSInteger) getQuestionId
{
    return questionId;
}

- (void) setAcceptedAnswer:(NSInteger)input
{
    acceptedAnswer = input;
}
- (NSInteger) getAcceptedAnswer
{
    return acceptedAnswer;
}

- (void) setUserId:(NSInteger)input
{
    userId = input;
}
- (NSInteger) getUserId
{
    return userId;
}

- (void) setAnswerCount:(NSInteger)input
{
    answerCount = input;
}
- (NSInteger) getAnswerCount
{
    return answerCount;
}

- (void) setTitle:(NSString *)input
{
    title = input;
}
- (NSString *) getTitle
{
    return title;
}

- (void) setBody:(NSString *)input
{
    body = input;
}
- (NSString *) getBody
{
    return body;
}

- (void) setCreated:(NSDate *)input
{
    created = input;
}
- (NSDate *) getCreated
{
    return created;
}

- (void) setTags:(NSArray *)input
{
    tags = input;
}
- (NSArray *) getTags
{
    return tags;
}

- (void) setAnswers:(NSArray *)input
{
    answers = input;
}
- (NSArray *) getAnswers
{
    return answers;
}

- (void) setComments:(NSArray *)input
{
    comments = input;
}
- (NSArray *) getComments
{
    return comments;
}

@end
