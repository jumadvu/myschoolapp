//
//  StoreItemPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 3/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StoreItem (StoreItemPlus)

+(void)createStoreItems;
+(NSArray*)storeItemsArray;
+(NSArray*)fetchStoreItems;

@end
