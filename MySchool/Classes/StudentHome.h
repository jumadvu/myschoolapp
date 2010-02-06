//
//  StudentHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;

@interface StudentHome : UITableViewController {

	Student *student;
}

@property (nonatomic, retain) Student *student;

-(void)toMainMenu;

@end
