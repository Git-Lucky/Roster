//
//  TableViewDataSource.h
//  FirstDayDemo
//
//  Created by Tim Hise on 1/14/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *studentArray;

@end
