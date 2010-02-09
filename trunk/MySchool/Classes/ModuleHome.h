//
//  ModuleHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ModuleHome : baseViewController {
	IBOutlet UIButton *chapterButton;
	IBOutlet UITableView *tableview;
	IBOutlet UILabel *moduleNameLabel;
	NSMutableArray *chapters;
	NSString *moduleName;
	NSString *fileName;
}

@property (nonatomic,retain) UIButton *chapterButton;
@property (nonatomic,retain) NSMutableArray *chapters;
@property (nonatomic,retain) UITableView *tableview;
@property (nonatomic, retain) UILabel *moduleNameLabel;
@property (nonatomic, retain) NSString *moduleName;
@property (nonatomic, retain) NSString *fileName;


-(IBAction)toChapter;

@end
