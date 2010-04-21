//
//  HelpHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpHome : baseViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *tableview;
	NSArray *helpitems;
}

@property (nonatomic, retain) UITableView *tableview;
@property (nonatomic, retain) NSArray *helpitems;

@end
