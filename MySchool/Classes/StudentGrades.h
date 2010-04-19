//
//  StudentGrades.h
//  MySchool
//
//  Created by Ashley Kayler on 4/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Student;

@interface StudentGrades : baseViewController <UITableViewDelegate, UITableViewDataSource> {
	
	Student *student;
	IBOutlet UITableView *tableView;
	IBOutlet UILabel *heading;
	IBOutlet UIImageView *frontView;
	IBOutlet UILabel *gradeLabel;
	
}

@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UILabel *heading;
@property (nonatomic, retain) UILabel *gradeLabel;
@property (nonatomic, retain) UIImageView *frontView;

@end
