//
//  StudentQuestionHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;
@class User;
@class Chapter;
@class BarScale;
@protocol QuestionDelegate;

@interface StudentQuestionHome : baseViewController {
	IBOutlet UIView *teacherView;
	IBOutlet UIImageView *studentView;
	IBOutlet UIButton *sButton;
	IBOutlet UIButton *a1Button;
	IBOutlet UIButton *a2Button;
	IBOutlet UIButton *a3Button;
	int whichQuestion;
	Student *student;
	Chapter *chapter;
	BarScale *bar;
	id<QuestionDelegate> delegate;
	int answerKey;

}

@property (nonatomic, retain) UIView *teacherView;
@property (nonatomic, retain) UIImageView *studentView;
@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) Chapter *chapter;
@property (nonatomic, retain) UIButton *sButton;
@property (nonatomic, retain) UIButton *a1Button;
@property (nonatomic, retain) UIButton *a2Button;
@property (nonatomic, retain) UIButton *a3Button;
@property (nonatomic) int whichQuestion;
@property (nonatomic, retain) BarScale *bar;
@property (nonatomic) int answerKey;

@property (assign) id<QuestionDelegate> delegate;

@end

@protocol QuestionDelegate <NSObject>
-(void)dismissQuestionWindow:(NSNumber*)points;

@end
