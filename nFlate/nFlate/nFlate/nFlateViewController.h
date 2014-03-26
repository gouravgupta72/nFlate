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
@interface nFlateViewController : UIViewController<UICollectionViewDataSource_Draggable, UICollectionViewDelegate,RequestDelegate>
{
}
@end
