//
//  nFlateViewController.m
//  nFlate
//
//  Created by Mac-005 on 27/02/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "nFlateViewController.h"
#import "nFlateCustomCell.h"
#import "CustomTableView.h"
#import "DeveloperDataClass.h"
#import "ViewDataClass.h"
#import "GameDataClass.h"
#import "CoreDataClass.h"

#define SECTION_COUNT 5
#define ITEM_COUNT 20

@interface nFlateViewController ()
{
    IBOutlet UICollectionView *viewCollection;
    NSMutableArray *sections;
    NSMutableArray *arrDeveloper;
    NSMutableArray *arrView;
     CoreDataClass *objcoreData;
    NSString *listselectID;
}
@end

@implementation nFlateViewController
@synthesize gameArr,arrGameList;
#pragma mark Response/Request Method
-(void)getError:(id)error
{
//    [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
//    showAlert(@"Failure", error, self);
    
    switch (request) {
        case request1:
        {
            if (!arrDeveloper)
            {
                arrDeveloper = [[NSMutableArray alloc]init];
            }else
            {
                [arrDeveloper removeAllObjects];
            }
            
            arrDeveloper= [objcoreData showDataList:[NSString stringWithFormat:@"%@",[nFlateAppDelegate sharedAppDelegate].userID]];
            if ([arrDeveloper count]==0) {
                showAlert(@"Failure", @"No Data Saved", self);
            }
            else{
                
                [self selectQuetion:[[arrDeveloper objectAtIndex:0] name] strid:[[arrDeveloper objectAtIndex:0] idstr]];
            }

        }
        break;
        case request2:
        {
            if (!sections)
            {
                sections = [[NSMutableArray alloc]init];
            }else
            {
                [sections removeAllObjects];
            }
            
            sections= [objcoreData showData:[NSString stringWithFormat:@"%@&%@",[nFlateAppDelegate sharedAppDelegate].userID ,listselectID]];
            if ([arrDeveloper count]==0) {
                showAlert(@"Failure", @"No Data Saved", self);
            }
            else{
                [viewCollection reloadData];

            }
            
//                [self selectQuetion:[[arrDeveloper objectAtIndex:0] name] strid:[[arrDeveloper objectAtIndex:0] idstr]];
            
        }
            
        default:
            break;
    }
    
}

-(void)getResult:(id)jsonData
{
    
    NSLog(@"jsonData=%@",jsonData);
    
    switch (request) {
        
        case request1:
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
            NSDictionary *dictVDataList=[[NSDictionary alloc]initWithObjectsAndKeys:arrDeveloper,[nFlateAppDelegate sharedAppDelegate].userID  , nil];
            [objcoreData saveDataList:dictVDataList];
            [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
            //attaching default first_view
            if([arrDeveloper count]!=0)
            {
                [self selectQuetion:[[arrDeveloper objectAtIndex:0] name] strid:[[arrDeveloper objectAtIndex:0] idstr]];
            }

        }
            break;
            
        case request2:
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
                if (![[jsonData valueForKey:@"View_ID"] isKindOfClass:[NSNull class]]) {
                    NSDictionary *coreDataDict=[[NSDictionary alloc]initWithObjectsAndKeys:sections,[NSString stringWithFormat:@"%@&%@",[nFlateAppDelegate sharedAppDelegate].userID,[jsonData valueForKey:@"View_ID"]], nil] ;
                    CoreDataClass *objCoreData=[[CoreDataClass alloc]init];
                    [objCoreData saveData:coreDataDict];
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

-(void)requestpost:(NSString *)postParameter  array:(NSMutableArray*)arr
{
    [[nFlateAppDelegate sharedAppDelegate] addloadingView];
    Request *req=[[Request alloc]init];
    req.delegate=self;
    switch (request)
    {
        case request1:
        {
            NSDictionary *dict=@{@"dID": [nFlateAppDelegate sharedAppDelegate].userID};
            [req postRequest:dict url:GETVIEWLISTURL];
        }
            break;
        case request2:
        {
            
            NSDictionary *dict=@{@"dID": [nFlateAppDelegate sharedAppDelegate].userID,@"View_ID":postParameter};
            [req postRequest:dict url:GETVIEWURL];
        }
            break;
        case request3:
        {
             NSDictionary *dict=@{@"dID": [nFlateAppDelegate sharedAppDelegate].userID,@"View_Name":self.lblTable1.text,@"View_ID":postParameter};
             [req postRequest:dict url:SAVEURL];
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
        if([arrDeveloper count]==0)
        {
        //do nothing
        }
        else if([arrDeveloper count]<MAX_DISPLAY_ROWS_TABLE_1)
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
        
        for(int i=0;i<[self.arrGameList count];i++)
        {
            if([[[self.self.arrGameList objectAtIndex:i] gameName] length]>=[[[self.self.arrGameList objectAtIndex:maxIndex] gameName] length])
            {
                maxIndex=i;
            }
        }

        if([self.arrGameList count]==0)
        {
               [self.view_table2 removeConstraints:[self.view_table2 constraints]];
            //do nothing
        }
       else if([self.arrGameList count]<MAX_DISPLAY_ROWS_TABLE_2)
        {
            [self.view_table2 removeConstraints:[self.view_table2 constraints]];
            //create width constraint based on new width value
            
            
            //use this for system font
            CGFloat width =  [[[self.arrGameList objectAtIndex:maxIndex] gameName] sizeWithFont:[UIFont systemFontOfSize:20 ]].width+80;
            
            
            [self.view_table2 addConstraint:[NSLayoutConstraint constraintWithItem:self.view_table2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual                                        toItem:nil attribute:NSLayoutAttributeWidth                                        multiplier:1.0                                        constant:width]];
            
            
            //create height constraint based on new height value
            [self.view_table2 addConstraint:[NSLayoutConstraint
                                             constraintWithItem:self.view_table2
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                             constant:CELL_SIZE_2*[self.arrGameList count]]];
            
            CGRect newFrame = self.view_table2.frame;
            newFrame.size = CGSizeMake(width,CELL_SIZE_2*[self.arrGameList count] );
            self.view_table2.frame = newFrame;
        }
        else
        {
            [self.view_table2 removeConstraints:[self.view_table2 constraints]];
            //create width constraint based on new width value
            
            //use this for system font
            CGFloat width =  [[[self.arrGameList objectAtIndex:maxIndex] gameName] sizeWithFont:[UIFont systemFontOfSize:20 ]].width+80;
            
            
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
        CustomTableView *obj=[[CustomTableView alloc]initWithFrame:CGRectMake(0,0,self.view_table2.frame.size.width, self.view_table2.frame.size.height) array:self.arrGameList TableType:tableType];
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
     NSMutableArray *arrupdateView=[[NSMutableArray alloc]init];
    for (int i =0; i<[sections count]; i++)
    {
        
        ViewDataClass *objViewData=[sections objectAtIndex:i];
       
        NSDictionary *dictD=[[NSDictionary alloc]initWithObjectsAndKeys:objViewData.title,@"Title",objViewData.value,@"Value", nil];
        NSLog(@"dictD=%@",dictD);
        NSDictionary *dictG=[[NSDictionary alloc]initWithObjectsAndKeys:objViewData.gameID,@"game_id",objViewData.matrixID,@"matrix_id", nil];
        NSLog(@"dictG=%@",dictG);
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:dictD,@"D",dictG,@"G", nil];
        NSLog(@"dict=%@",dict);
        [arrupdateView addObject:dict];
        
        
        //strView = [strView stringByAppendingString:[NSString
                                                   // stringWithFormat:@"%@",[sections objectAtIndex:i]]];
    }
    NSLog(@"arrupdateView=%@",arrupdateView);
    request=request3;
    [self requestpost:listselectID array:arrupdateView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lbluserID.text=[nFlateAppDelegate sharedAppDelegate].userID;
    self.arrGameList=[[NSMutableArray alloc] init];
    objcoreData=[[CoreDataClass alloc]init];
    //TapGesture for handle touch outside of tableListVie
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [viewCollection addGestureRecognizer:singleFingerTap];
    [self hideTableView];
    request = request1;
    [self requestpost:Nil array:nil];
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
//    
  // NSString *hex = [NSString stringWithFormat:@"%06X", arc4random() % 0xFFFFFF];
//    cell.imgBG.image =imagetinting([UIImage imageNamed:@"box"],colorWithHexString(hex));
    
    ViewDataClass *objdata = [sections objectAtIndex:indexPath.item];
    cell.lblTitle.text =[NSString stringWithFormat:@"%@", objdata.title];
    NSLog(@"%@",objdata.value);
    cell.lblValue.text = [NSString stringWithFormat:@"%@", objdata.value];
    
    NSString *id_obj=objdata.gameID;
    
    int index_id=0;
    for(int i=0;i<[gameArr count];i++)
    {
        if([[[gameArr objectAtIndex:i] gameID] isEqualToString:id_obj])
        {
            [arrGameList addObject:[gameArr objectAtIndex:i]];
            index_id=i;
            break;
        }
    }
    
    // // // // //
    for(int i=0;i<[self.arrGameList count];i++)
        NSLog(@"===%@",[NSString stringWithFormat:@"%@",[[self.arrGameList objectAtIndex:i] gameID]]);
    
    
    NSMutableArray *uniqueArray = [[NSMutableArray alloc]init];
    
    [uniqueArray addObjectsFromArray:[[NSSet setWithArray:self.arrGameList] allObjects]];
    self.arrGameList=uniqueArray;
    for(int i=0;i<[self.arrGameList count];i++)
        NSLog(@"//////===%@",[[self.arrGameList objectAtIndex:i] gameID]);
    // // // // // // // // // 
    
    NSLog(@"%d",index_id);
    NSString *hex =[[gameArr objectAtIndex:index_id] gameColor];
    cell.imgBG.image =imagetinting([UIImage imageNamed:@"box"],colorWithHexString(hex));
    
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
            [arrGameList removeAllObjects];
            self.lblTable1.text=strName;
            request=request2;
            listselectID=[NSString stringWithFormat:@"%@",strid];
            [self requestpost:strid array:nil];
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
