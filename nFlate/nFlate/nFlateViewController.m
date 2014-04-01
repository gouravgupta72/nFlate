 //
//  nFlateViewController.m
//  nFlate
//
//  Created by Mac-005 on 27/02/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "nFlateViewController.h"
#import "nFlateCustomCell.h"
#import "nFlateViewDataClass.h"
#import "CustomTableView.h"
#define SECTION_COUNT 5
#define ITEM_COUNT 20

@interface nFlateViewController ()
{
    IBOutlet UICollectionView *viewCollection;
     NSMutableArray *sections;
}
@end

@implementation nFlateViewController

#pragma mark Response/Request Method
-(void)getError:(id)error
{
}

-(void)getResult:(id)jsonData
{
    if ([jsonData isKindOfClass:[NSArray class]])
    {
        if (!sections)
        {
            sections = [[NSMutableArray alloc]init];
        }else
        {
            [sections removeAllObjects];
        }
        
        for (int i = 0; i<[jsonData count]; i++)
        {
            nFlateViewDataClass *dataObj = [[nFlateViewDataClass alloc]init];
            
            if (![[[jsonData objectAtIndex:i] valueForKey:@"index"] isKindOfClass:[NSNull class]])
            {
                dataObj.strTitle = [[jsonData objectAtIndex:i] valueForKey:@"index"];
            }
            
            if (![[[jsonData objectAtIndex:i] valueForKey:@"title"] isKindOfClass:[NSNull class]])
            {
                dataObj.strValue = [[jsonData objectAtIndex:i] valueForKey:@"title"];
            }
            
            [sections addObject:dataObj];
        }
        
        [viewCollection reloadData];
    }
    
    [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
    
}

-(void)requestForGettingViewData
{
    [[nFlateAppDelegate sharedAppDelegate] addloadingView];
    Request *req=[[Request alloc] init];
    req.delegate=self;
    [req request:@"" Parameter:[@"http://hwsdemos.com/nFlate/getSchema.php" stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy]];
}

- (IBAction)showViewList:(id)sender
{
    [self.view sendSubviewToBack:self.view_table2];
    self.view_table2.hidden=true;
    
    if(self.view_table.hidden==true)
    {
        [self.view sendSubviewToBack:viewCollection];
        [self.view bringSubviewToFront:self.view_table];
        self.view_table.hidden=false;
        
        if([arr1 count]<MAX_DISPLAY_ROWS_TABLE_1)
        {
            [self.view_table removeConstraints:[self.view_table constraints]];
            //create height constraint based on new height value
            [self.view_table addConstraint:[NSLayoutConstraint
                                            constraintWithItem:self.view_table
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeHeight
                                            multiplier:1.0
                                            constant:CELL_SIZE_1*[arr1 count]]];
            
            CGRect newFrame = self.view_table.frame;
            newFrame.size = CGSizeMake(self.view_table.frame.size.width,CELL_SIZE_1*[arr1 count] );
            self.view_table.frame = newFrame;
        }
        else
        {
            [self.view_table removeConstraints:[self.view_table constraints]];
            //create height constraint based on new height value
            [self.view_table addConstraint:[NSLayoutConstraint
                                            constraintWithItem:self.view_table
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeHeight
                                            multiplier:1.0
                                            constant:CELL_SIZE_1*MAX_DISPLAY_ROWS_TABLE_1]];
            
            CGRect newFrame = self.view_table.frame;
            newFrame.size = CGSizeMake(self.view_table.frame.size.width,CELL_SIZE_1*MAX_DISPLAY_ROWS_TABLE_1 );
            self.view_table.frame = newFrame;
        }
        
        for (UIView *view in self.view_table.subviews)
        {
            if([view isKindOfClass:[CustomTableView class]])
                [view removeFromSuperview];
        }
        
        tableType=table1;
        CustomTableView *obj=[[CustomTableView alloc]initWithFrame:CGRectMake(0,0,self.view_table.frame.size.width, self.view_table.frame.size.height) array:arr1 TableType:tableType];
        obj.delgate=self;
        [self.view_table addSubview:obj];
    }
    else
    {
        [self hideTableView];
    }
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch= [touches anyObject];
    if ([touch view] == self.view_table || [touch view] == self.btn_list)
    {
        //do nothing
    }
    else
    {
        [self hideTableView];
    }
}

/**
 *  hides tableview on background click
 */
-(void)hideTableView
{
    [self.view bringSubviewToFront:viewCollection];
    self.view_table2.hidden=true;
    self.view_table.hidden=true;
}

- (IBAction)refresh:(id)sender
{
    [self hideTableView];
}

- (IBAction)action:(id)sender
{
    [self.view sendSubviewToBack:self.view_table];
    self.view_table.hidden=true;
    if(self.view_table2.hidden==true)
    {
        
        [self.view sendSubviewToBack:viewCollection];
        [self.view bringSubviewToFront:self.view_table2];
        self.view_table2.hidden=false;
        
        if([arr2 count]<MAX_DISPLAY_ROWS_TABLE_2)
        {
            [self.view_table2 removeConstraints:[self.view_table2 constraints]];
            //create width constraint based on new width value
            [self.view_table2 addConstraint:[NSLayoutConstraint constraintWithItem:self.view_table2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual                                        toItem:nil attribute:NSLayoutAttributeWidth                                        multiplier:1.0                                        constant:183]];
            
            //create height constraint based on new height value
            [self.view_table2 addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.view_table2
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                             constant:CELL_SIZE_2*[arr2 count]]];
            
            CGRect newFrame = self.view_table2.frame;
            newFrame.size = CGSizeMake(self.view_table2.frame.size.width,CELL_SIZE_2*[arr2 count] );
            self.view_table2.frame = newFrame;
        }
        else
        {
            [self.view_table2 removeConstraints:[self.view_table2 constraints]];
            //create width constraint based on new width value
            [self.view_table2 addConstraint:[NSLayoutConstraint constraintWithItem:self.view_table2 attribute:NSLayoutAttributeWidth                                         relatedBy:NSLayoutRelationEqual                                         toItem:nil                                        attribute:NSLayoutAttributeWidth                                        multiplier:1.0                                        constant:self.view_table2.frame.size.width]];
            
            //create height constraint based on new height value
            [self.view_table2 addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.view_table2
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                             constant:CELL_SIZE_2*MAX_DISPLAY_ROWS_TABLE_2]];
            
            CGRect newFrame = self.view_table2.frame;
            newFrame.size = CGSizeMake(self.view_table2.frame.size.width,CELL_SIZE_2*MAX_DISPLAY_ROWS_TABLE_2 );
            self.view_table2.frame = newFrame;
        }
        for (UIView *view in self.view_table2.subviews)
        {
            if([view isKindOfClass:[CustomTableView class]])
                [view removeFromSuperview];
        }
        tableType=table2;
        CustomTableView *obj=[[CustomTableView alloc]initWithFrame:CGRectMake(0,0,self.view_table2.frame.size.width, self.view_table2.frame.size.height) array:arr2 TableType:tableType];
        obj.delgate=self;
        [self.view_table2 addSubview:obj];
        
    }
    else
    {
        [self hideTableView];
    }
    
}

- (IBAction)saveViewAction:(id)sender

{
    [self hideTableView];

    NSString *strView = @"";
    
    for (int i =0; i<[sections count]; i++)
    {
       strView = [strView stringByAppendingString:[NSString stringWithFormat:@"%@",[sections objectAtIndex:i]]];
    }
    [self requestForGettingViewData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[nFlateAppDelegate sharedAppDelegate] addloadingView];
    
    [self requestForGettingViewData];
    
    //TapGesture for handle touch outside of tableListVie
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [viewCollection addGestureRecognizer:singleFingerTap];
    [self hideTableView];
    
    arr1=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"4",nil];
    arr2=[[NSMutableArray alloc]initWithObjects:@"images1",@"images2",@"images3",nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  Hides tableViews on tap on collectionView
 *
 *  @param (UITapGestureRecognizer *)recognizer
 *
 *  @return void
 */
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view bringSubviewToFront:viewCollection];
    self.view_table.hidden=true;
    self.view_table2.hidden=true;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [sections count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    nFlateCustomCell *cell = (nFlateCustomCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"nFlateCell" forIndexPath:indexPath];
    
    
    cell.layer.borderWidth = 1.0f;
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 20.0f;
    
  //   cell.imgBG.image =imagetinting([UIImage imageNamed:@"box"], [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:0.2]);
    
    // 16777215 is FFFFFF
    NSString *hex = [NSString stringWithFormat:@"%06X", arc4random() % 0xFFFFFF];
    cell.imgBG.image =imagetinting([UIImage imageNamed:@"box"],colorWithHexString(hex));
    
    nFlateViewDataClass *objdata = [sections objectAtIndex:indexPath.item];
    cell.lblTitle.text =[NSString stringWithFormat:@"%@", objdata.strTitle];
    cell.lblValue.text = objdata.strValue;
    
    UIColor *complementColor=complementryColorWithHexString(hex);
    cell.lblValue.textColor=complementColor;
    cell.lblTitle.textColor=complementColor;
    cell.lblSubTitle.textColor=complementColor;
    return cell;
}

- (BOOL)collectionView:(LSCollectionViewHelper *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    return YES;
}

- (void)collectionView:(LSCollectionViewHelper *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *index = [sections objectAtIndex:fromIndexPath.item];
    [sections removeObjectAtIndex:fromIndexPath.item];
    [sections insertObject:index atIndex:toIndexPath.item];
}

#pragma mark- ComboViewDelegate method

/* This methods use to delete or read all alerts */
-(void) selectQuetion:(id) que
{
    switch (tableType)
    {
        case table1:
        {
            self.lblTable1.text=que;
          
        }
            break;
        case table2:
            break;
        default:
            break;
    }
    
   /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%d",tableType] message:que delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    */

    [self hideTableView];
   // [self.view bringSubviewToFront:viewCollection];
 //   self.view_table2.hidden=true;
}
@end
