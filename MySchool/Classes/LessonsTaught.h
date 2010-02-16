//
//  LessonsTaught.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LessonsTaught : baseViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *modules;
	IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) NSArray *modules;
@property (nonatomic, retain) UITableView *tableView;

-(void)goBack;

@end
