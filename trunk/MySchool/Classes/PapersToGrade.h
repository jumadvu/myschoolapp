//
//  PapersToGrade.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PapersToGrade : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *students;
	UITableView *myTableView;
}

@property (nonatomic, retain) NSArray *students;
@property (nonatomic, retain) UITableView *myTableView;

@end
