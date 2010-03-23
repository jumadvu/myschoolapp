//
//  StoreHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StoreHome : baseViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *tableView;
	NSArray* storeItems;
	IBOutlet UILabel * pointsLabel;
}

@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSArray *storeItems;
@property (nonatomic, retain) UILabel *pointsLabel;

@end
