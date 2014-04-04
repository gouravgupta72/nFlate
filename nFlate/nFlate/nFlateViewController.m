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
#import "DeveloperDataClass.h"
#import "ViewDataClass.h"
#import "GameDataClass.h"

#define SECTION_COUNT 5
#define ITEM_COUNT 20

@interface nFlateViewController ()
{
    IBOutlet UICollectionView *viewCollection;
    NSMutableArray *sections;
    NSMutableArray *arrDeveloper;
    NSMutableArray *arrView;
}
@end

@implementation nFlateViewController
@synthesize gameArr;
#pragma mark Response/Request Method
-(void)getError:(id)error
{
    [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
    showAlert(@"Failure", error, self);
    
}

-(void)getResult:(id)jsonData
{
    
    NSLog(@"jsonData=%@",jsonData);
    
    switch (request) {
        case request1:
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
        }
            break;
        case request2:
        {
            if (!arrDeveloper)
            {
                arrDeveloper = [[NSMutableArray alloc]init];
            }else
            {
                [arrDeveloper removeAllObjects];
            }
            
            NSArray *jsonArr=(NSArray*)jsonData;
            for (int i = 0; i<[jsonArr count]; i++)
            {
                DeveloperDataClass *objDeveloper=[[DeveloperDataClass alloc]init];
                
                
                if (![[[jsonArr objectAtIndex:i] valueForKey:@"id"] isKindOfClass:[NSNull class]])
                {
                    objDeveloper.idstr = [[jsonArr objectAtIndex:i] valueForKey:@"id"];
                }
                if (![[[jsonArr objectAtIndex:i] valueForKey:@"name"] isKindOfClass:[NSNull class]])
                {
                    objDeveloper.name = [[jsonArr objectAtIndex:i] valueForKey:@"name"];
                }
                
                [arrDeveloper addObject:objDeveloper];
                
            }
            [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
            
        }
            break;
            
        case request3:
        {
            if ([jsonData isKindOfClass:[NSDictionary class]])
            {
                if (!sections)
                {
                    sections = [[NSMutableArray alloc]init];
                }else
                {
                    [sections removeAllObjects];
                }
                if (![[jsonData  valueForKey:@"View_Data"] isKindOfClass:[NSNull class]])
                {
                    id itemsdict=[jsonData  valueForKey:@"View_Data"];
                    id items=[itemsdict valueForKey:@"items"];
                    if (![items isKindOfClass:[NSNull class]])
                    {
                        if ([items isKindOfClass:[NSArray class]]) {
                            for (int i=0; i<[items count]; i++) {
                                
                                ViewDataClass *objViewData=[[ViewDataClass alloc]init];
                                id itemdict=[items objectAtIndex:i];
                                if (![itemdict isKindOfClass:[NSNull class]]) {
                                    id G=[itemdict valueForKey:@"G"];
                                    if (![[G valueForKey:@"game_id"] isKindOfClass:[NSNull class]]) {
                                        objViewData.gameID=[G valueForKey:@"game_id"];
                                        
                                    }
                                    if (![[G valueForKey:@"matrix_id"] isKindOfClass:[NSNull class]]) {
                                        objViewData.matrixID=[G valueForKey:@"matrix_id"];
                                        
                                    }
                                    id D=[itemdict valueForKey:@"D"];
                                    if (![[D valueForKey:@"Title"] isKindOfClass:[NSNull class]]) {
                                        objViewData.title=[D valueForKey:@"Title"];
                                        
                                    }
                                    if (![[D valueForKey:@"Value"] isKindOfClass:[NSNull class]]) {
                                        objViewData.value=[D valueForKey:@"Value"];
                                        
                                    }
                                    
                                    
                                }
                                NSLog(@"%@,%@,%@,%@",objViewData.gameID,objViewData.matrixID,objViewData.title,objViewData.value);
                                [sections addObject:objViewData];
                            }
                            
                        }
                    }
                }
                [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
                
                [viewCollection reloadData];
                
            }
            break;
            
        default:
            break;
        }
    }
    
}

-(void)request2:(NSString *)postParameter
{
    [[nFlateAppDelegate sharedAppDelegate] addloadingView];
    Request *req=[[Request alloc]init];
    req.delegate=self;
    switch (request) {
        case request2:
        {
            NSString  *postParam = [NSString stringWithFormat:@"dID=araju@hunka.in"];
            [req postRequest:postParam url:BASEURL];
        }
            break;
        case request3:
        {
            NSString  *postParam = [NSString stringWithFormat:@"dID=araju@hunka.in&View_ID=%@",postParameter];
            [req postRequest:postParam url:GETVIEWURL];
        }
        default:
            break;
    }
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
        
        if([arrDeveloper count]<MAX_DISPLAY_ROWS_TABLE_1)
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
                                            constant:CELL_SIZE_1*[arrDeveloper count]]];
            
            CGRect newFrame = self.view_table.frame;
            newFrame.size = CGSizeMake(self.view_table.frame.size.width,CELL_SIZE_1*[arrDeveloper count] );
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
        CustomTableView *obj=[[CustomTableView alloc]initWithFrame:CGRectMake(0,0,self.view_table.frame.size.width, self.view_table.frame.size.height) array:arrDeveloper TableType:tableType];
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
        int maxIndex=0;
        
        for(int i=0;i<[gameArr count];i++)
        {
            if([[[self.gameArr objectAtIndex:i] gameName] length]>=[[[self.gameArr objectAtIndex:maxIndex] gameName] length])
            {
                maxIndex=i;
            }
        }

        
        if([gameArr count]<MAX_DISPLAY_ROWS_TABLE_2)
        {
            [self.view_table2 removeConstraints:[self.view_table2 constraints]];
            //create width constraint based on new width value
            
            
            //use this for system font
            CGFloat width =  [[[gameArr objectAtIndex:maxIndex] gameName] sizeWithFont:[UIFont systemFontOfSize:20 ]].width+80;
            
            
            [self.view_table2 addConstraint:[NSLayoutConstraint constraintWithItem:self.view_table2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual                                        toItem:nil attribute:NSLayoutAttributeWidth                                        multiplier:1.0                                        constant:width]];
            
            
            //create height constraint based on new height value
            [self.view_table2 addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.view_table2
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                             constant:CELL_SIZE_2*[gameArr count]]];
            
            CGRect newFrame = self.view_table2.frame;
            newFrame.size = CGSizeMake(width,CELL_SIZE_2*[gameArr count] );
            self.view_table2.frame = newFrame;
        }
        else
        {
            [self.view_table2 removeConstraints:[self.view_table2 constraints]];
            //create width constraint based on new width value
            
            //use this for system font
            CGFloat width =  [[[gameArr objectAtIndex:maxIndex] gameName] sizeWithFont:[UIFont systemFontOfSize:20 ]].width+80;
            
            
            [self.view_table2 addConstraint:[NSLayoutConstraint constraintWithItem:self.view_table2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual                                        toItem:nil attribute:NSLayoutAttributeWidth                                        multiplier:1.0                                        constant:width]];
            

            
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
            newFrame.size = CGSizeMake(width,CELL_SIZE_2*MAX_DISPLAY_ROWS_TABLE_2 );
            self.view_table2.frame = newFrame;
        }
        for (UIView *view in self.view_table2.subviews)
        {
            if([view isKindOfClass:[CustomTableView class]])
                [view removeFromSuperview];
        }
        
        tableType=table2;
        CustomTableView *obj=[[CustomTableView alloc]initWithFrame:CGRectMake(0,0,self.view_table2.frame.size.width, self.view_table2.frame.size.height) array:self.gameArr TableType:tableType];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lbluserID.text=[nFlateAppDelegate sharedAppDelegate].userID;
    
    
    //TapGesture for handle touch outside of tableListVie
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [viewCollection addGestureRecognizer:singleFingerTap];
    [self hideTableView];
    request = request2;
    [self request2:nil];
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
    
    
    NSString *hex = [NSString stringWithFormat:@"%06X", arc4random() % 0xFFFFFF];
    cell.imgBG.image =imagetinting([UIImage imageNamed:@"box"],colorWithHexString(hex));
    
    ViewDataClass *objdata = [sections objectAtIndex:indexPath.item];
    cell.lblTitle.text =[NSString stringWithFormat:@"%@", objdata.title];
    NSLog(@"%@",objdata.value);
    cell.lblValue.text = [NSString stringWithFormat:@"%@", objdata.value];
    
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
-(void) selectQuetion:(id) strName strid:(id) strid;
{
    switch (tableType)
    {
        case table1:
        {
            self.lblTable1.text=strName;
            request=request3;
            [self request2:strid];
            
        }
            break;
        case table2:
            break;
        default:
            break;
    }
    
    
    
    [self hideTableView];
    
}
@end
