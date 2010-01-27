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
}

@property (nonatomic,retain) UIButton *chapterButton;

-(IBAction)toChapter;

@end
