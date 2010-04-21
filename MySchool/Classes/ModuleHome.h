//
//  ModuleHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Module;

@interface ModuleHome : baseViewController <UITableViewDataSource, UITableViewDelegate>{
	IBOutlet UILabel *moduleNameLabel;
	Module *targetModule;
	IBOutlet UITableView *tableview;
	BOOL goToLearn;
}

@property (nonatomic, retain) UILabel *moduleNameLabel;
@property (nonatomic, retain) Module *targetModule;
@property (nonatomic, retain) UITableView *tableview;
@property (nonatomic) BOOL goToLearn;

//-(IBAction)toChapter;

@end
