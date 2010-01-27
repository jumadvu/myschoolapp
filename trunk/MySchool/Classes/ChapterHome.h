//
//  ChapterHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChapterHome : UIViewController {
	IBOutlet UIButton *learnButton;

}

@property (nonatomic,retain) UIButton *learnButton;

-(IBAction)toArticle;

@end
