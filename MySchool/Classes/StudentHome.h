//
//  StudentHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;

@interface StudentHome : baseViewController <UITableViewDelegate, UITableViewDataSource> {

	Student *student;
	IBOutlet UITableView *tableView;
	IBOutlet UIImageView *frontView;
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
@property (nonatomic, retain)  UIImageView *smartsBox;
@property (nonatomic, retain)  UILabel *smartsScore;
@property (nonatomic, retain)  UIImageView *respectBox;
@property (nonatomic, retain)  UILabel *respectScore;
@property (nonatomic, retain)  UIImageView *enthusiasmBox;
@property (nonatomic, retain)  UILabel *enthusiasmScore;

@end
