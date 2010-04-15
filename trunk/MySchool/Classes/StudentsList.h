//
//  StudentsList.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StudentsList : baseViewController <UITableViewDelegate, UITableViewDataSource>{
	NSArray *students;
	IBOutlet UITableView *tableview;
}

@property (nonatomic, retain) NSArray *students;
@property (nonatomic, retain) UITableView *tableview;

@end
