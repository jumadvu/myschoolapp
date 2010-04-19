//
//  AccountSelection.h
//  MySchool
//
//  Created by Ashley Kayler on 1/31/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccountSelection : baseViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *accounts;
	IBOutlet UITableView *tableview;
}

@property (nonatomic, retain) NSArray *accounts;
@property (nonatomic, retain) UITableView *tableview;

@end
