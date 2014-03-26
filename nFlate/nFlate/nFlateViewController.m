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
    if(self.view_table.hidden==true)
    {
        [self.view sendSubviewToBack:viewCollection];
        self.view_table.hidden=false;

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
//Method to hide tableview on background click
-(void)hideTableView
{
    [self.view bringSubviewToFront:viewCollection];
    self.view_table.hidden=true;
}

- (IBAction)refresh:(id)sender
{
    [self hideTableView];
}

- (IBAction)action:(id)sender
{
    [self hideTableView];
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
    
        // Do any additional setup after loading the view, typically from a nib.
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view bringSubviewToFront:viewCollection];
    self.view_table.hidden=true;
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
    
    
    cell.imgBG.image =imagetinting([UIImage imageNamed:@"box"], [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:0.2]);
    
    nFlateViewDataClass *objdata = [sections objectAtIndex:indexPath.item];
    cell.lblTitle.text =[NSString stringWithFormat:@"%@", objdata.strTitle];
    cell.lblValue.text = objdata.strValue;
    
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
@end
