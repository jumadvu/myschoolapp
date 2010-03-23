//
//  StoreHomeCell.h
//  MySchool
//
//  Created by Ashley Kayler on 3/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreItem;

@interface StoreHomeCell : UITableViewCell {
	UILabel *lblTitle;
	UILabel *lblCost;
	UIButton *itemButton;
	StoreItem *item;
}

@property (nonatomic, retain) UILabel *lblCost;
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UIButton *itemButton;
@property (nonatomic, retain) StoreItem *item;

-(void)buttonSelected:(id)sender;

@end
