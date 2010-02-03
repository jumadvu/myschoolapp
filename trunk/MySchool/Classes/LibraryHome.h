//
//  LibraryHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LibraryHome : baseViewController {
	IBOutlet UIButton *moduleButton;
	NSMutableArray *moduleNames;
	IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) UIButton *moduleButton;
@property (nonatomic, retain) NSMutableArray *moduleNames;
@property (nonatomic, retain) UITableView *tableView;

-(IBAction)toModule;

@end
