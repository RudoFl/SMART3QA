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

@interface SMART3QAAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{    
    NSString *hostname;
    NSArray *questions, *users, *tags;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (UIImage *)downloadImage:(NSURL *)url;
- (UIImage *)resizeImage:(UIImage *)image scaleToSize:(CGSize)newSize;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSDate *)dateFromString:(NSString *)string;
- (NSString *)timeSinceDate:(NSDate *)date;
- (void)downloadQuestions;
- (void)downloadDataForQuestion:(NSInteger)questionId;
- (NSArray *)getQuestions;
- (NSArray *)getQuestionsForUser:(NSInteger)userId;
- (NSArray *)getQuestionsForTag:(NSInteger)tagId;
- (Question *)getQuestionForId:(NSInteger)questionId;
- (Question *)getQuestionForIndex:(NSInteger)index;
- (void)downloadUsers;
- (void)downloadDataForUser:(NSInteger)userId;
- (NSArray *)getUsers;
- (User *)getUserForId:(NSInteger)userid;
- (User *)getUserForIndex:(NSInteger)index;
- (void)downloadTags;
- (void)downloadDataForTag:(NSInteger)tagId;
- (NSArray *)getTags;
- (Tag *)getTagForId:(NSInteger)tagid;
- (Tag *)getTagForIndex:(NSInteger)index;
- (NSString *)getTagsForQuestion:(Question *)question;
- (void)describeDictionary:(NSDictionary *)dict;

@end
