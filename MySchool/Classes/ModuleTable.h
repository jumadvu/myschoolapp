//
//  ModuleTableController.h
//  MySchool
//
//  Created by Connor Riley on 2/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ModuleTable : baseViewController <UITableViewDataSource, UITableViewDelegate>{
	NSMutableArray *chapters;
	NSString *moduleName;
	IBOutlet UITableView *tableview;
	NSString *fileName;
}

@property (nonatomic,retain) NSMutableArray *chapters;

@property (nonatomic,retain) NSString *moduleName;
@property (nonatomic,retain) UITableView *tableview;
@property (nonatomic,retain) NSString *fileName;

@end
