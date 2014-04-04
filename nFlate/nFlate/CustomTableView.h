//
//  CustomTableView.h
//  nFlate
//
//  Created by mac-007 on 27/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomTableViewDelegate <NSObject>
-(void) selectQuetion:(id) strName strid:(id) strid;


@end

@interface CustomTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    int tableType;
}
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong) id<CustomTableViewDelegate> delgate;

- (id)initWithFrame:(CGRect)frame array:(NSMutableArray*)arr TableType:(int)type;


@end
