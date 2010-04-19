//
//  StudentReports.h
//  MySchool
//
//  Created by Ashley Kayler on 4/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;

@interface StudentReports : baseViewController <UITableViewDelegate, UITableViewDataSource> {
	Student *student;
	IBOutlet UITableView *tableView;
	IBOutlet UIImageView *frontView;
	NSMutableArray *reports;
	IBOutlet UIImageView *smartsBox;
	IBOutlet UILabel *smartsScore;
	IBOutlet UIImageView *respectBox;
	IBOutlet UILabel *respectScore;
	IBOutlet UIImageView *enthusiasmBox;
	IBOutlet UILabel *enthusiasmScore;
	
}

@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *frontView;
@property (nonatomic, retain) NSMutableArray *reports;

- (void)dismissQuestionWindow:(BOOL)correct;

@end
