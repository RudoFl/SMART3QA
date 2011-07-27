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

@interface SMART3QAAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSArray *questions, *users;
    NSString *hostname;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *hostname;

- (UIImage *)downloadImage:(NSURL *)url;
- (UIImage *)resizeImage:(UIImage *)image scaleToSize:(CGSize)newSize;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSDate *)dateFromString:(NSString *)string;
- (void)downloadQuestions;
- (NSArray *)getQuestions;
- (Question *)getQuestionForId:(NSInteger *)questionid;
- (Question *)getQuestionForIndex:(NSInteger *)index;
- (void)downloadUsers;
- (NSArray *)getUsers;
- (User *)getUserForId:(NSInteger *)userid;
- (Question *)getUserForIndex:(NSInteger *)index;

@end
