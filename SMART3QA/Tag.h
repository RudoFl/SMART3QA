#import <Foundation/Foundation.h>

@interface Tag : NSObject
{
    NSInteger tagId, questionCount;
    NSString *name;
}

- (void)setTagId:(NSInteger)input;
- (NSInteger)getTagId;

- (void)setQuestionCount:(NSInteger)input;
- (NSInteger)getQuestionCount;

- (void)setName:(NSString *)name;
- (NSString *)getName;

@end