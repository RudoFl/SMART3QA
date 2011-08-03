#import <Foundation/Foundation.h>

@interface Question : NSObject
{
    NSInteger questionId, acceptedAnswer, userId, answerCount;
    NSString *title, *body;
    NSDate *created;
    NSArray *tags;
}

- (void) setQuestionId:(NSInteger)input;
- (NSInteger) getQuestionId;

- (void) setAcceptedAnswer:(NSInteger)input;
- (NSInteger) getAcceptedAnswer;

- (void) setAnswerCount:(NSInteger)input;
- (NSInteger) getAnswerCount;

- (void) setUserId:(NSInteger)input;
- (NSInteger) getUserId;

- (void) setTitle:(NSString *)input;
- (NSString *) getTitle;

- (void) setBody:(NSString *)input;
- (NSString *) getBody;

- (void) setCreated:(NSDate *)input;
- (NSDate *) getCreated;

- (void) setTags:(NSArray *)input;
- (NSArray *) getTags;

@end