#import <Foundation/Foundation.h>

@interface Question : NSObject
{
    NSInteger *questionId, *acceptedAnswer, *userId;
    NSString *title, *body, *created;
}

- (void) setQuestionId:(NSInteger *)input;
- (NSInteger *) getQuestionId;

- (void) setAcceptedAnswer:(NSInteger *)input;
- (NSInteger *) getAcceptedAnswer;

- (void) setUserId:(NSInteger *)input;
- (NSInteger *) getUserId;

- (void) setTitle:(NSString *)input;
- (NSString *) getTitle;

- (void) setBody:(NSString *)input;
- (NSString *) getBody;

- (void) setCreated:(NSString *)input;
- (NSString *) getCreated;

@end