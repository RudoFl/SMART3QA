//
//  SMART3QAAppDelegate.h
//  SMART3QA
//
//  Created by Ruud Puts on 7/19/11.
//  Copyright 2011 Fontys Hogeschool ICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "User.h"
#import "Tag.h"

@interface SMART3QAAppDelegate : UIResponder <UIApplicationDelegate>
{    
    NSString *hostname;
    NSArray *questions, *users, *tags;
}

@property (strong, nonatomic) UIWindow *window;

- (UIImage *)downloadImage:(NSURL *)url;
- (UIImage *)resizeImage:(UIImage *)image scaleToSize:(CGSize)newSize;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSDate *)dateFromString:(NSString *)string;
- (NSString *)timeSinceDate:(NSDate *)date;
- (void)downloadQuestions;
- (void)downloadDataForQuestion:(NSInteger)questionId;
- (NSArray *)getQuestions;
- (Question *)getQuestionForId:(NSInteger)questionid;
- (Question *)getQuestionForIndex:(NSInteger)index;
- (void)downloadUsers;
- (NSArray *)getUsers;
- (User *)getUserForId:(NSInteger)userid;
- (User *)getUserForIndex:(NSInteger)index;
- (void)downloadTags;
- (NSArray *)getTags;
- (Tag *)getTagForId:(NSInteger)tagid;
- (Tag *)getTagForIndex:(NSInteger)index;

- (void)describeDictionary:(NSDictionary *)dict;

@end
