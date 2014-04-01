//
//  nFlateViewController.h
//  nFlate
//
//  Created by Mac-005 on 27/02/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+Draggable.h"
#import "Request.h"
#import "CustomTableView.h"
@interface nFlateViewController : UIViewController<UICollectionViewDataSource_Draggable, UICollectionViewDelegate,RequestDelegate,CustomTableViewDelegate>
{
    NSMutableArray *arr1;
    
    NSMutableArray *arr2;
    int tableType;

}

@property (weak, nonatomic) IBOutlet UIView *view_table;
@property (weak, nonatomic) IBOutlet UIView *view_table2;
- (IBAction)showViewList:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_list;

@property (weak, nonatomic) IBOutlet UIView *topView;
- (IBAction)saveViewAction:(id)sender;
-(void)hideTableView;
- (IBAction)refresh:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTable1;
@property (weak, nonatomic) IBOutlet UIButton *btn_list2;
- (IBAction)action:(id)sender;

@end
