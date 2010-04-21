//
//  HelpCell.h
//  MySchool
//
//  Created by Ashley Kayler on 4/20/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpCell : UITableViewCell {
	UILabel *titleLbl;
	UILabel *textLbl;
}

@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, retain) UILabel *textLbl;

@end