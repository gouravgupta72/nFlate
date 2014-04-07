//
//  CustomTableView.m
//  nFlate
//
//  Created by mac-007 on 27/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "CustomTableView.h"
#import "DeveloperDataClass.h"
#import "GameDataClass.h"
@interface CustomTableView()
{
    DeveloperDataClass *objDeveloper;
    GameDataClass *objGame;
}
@end
@implementation CustomTableView

- (id)initWithFrame:(CGRect)frame array:(NSArray*)arr TableType:(int)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.arr=[[NSMutableArray alloc]initWithArray:arr];
        tableType=type;
        self.delegate=self;
        self.dataSource=self;
        self.bounces=false;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        
      /*  if(tableType==table2)
        {
                for(int i=0;i<[self.arr count];i++)
                    NSLog(@"===%@",[NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:i] gameID]]);
                
                
                NSMutableArray *uniqueArray = [[NSMutableArray alloc]init];
                
                [uniqueArray addObjectsFromArray:[[NSSet setWithArray:self.arr] allObjects]];
                self.arr=uniqueArray;
                for(int i=0;i<[self.arr count];i++)
                    NSLog(@"//////===%@",[[self.arr objectAtIndex:i] gameID]);
        }
        */
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 /*   if([self.arr count]<4)
    {
        CGRect newFrame = self.superview.frame;
        newFrame.size = CGSizeMake(self.superview.frame.size.width,44*[self.arr count] );
        self.superview.frame = newFrame;
    }
    else
    {
        CGRect newFrame = self.superview.frame;
        newFrame.size = CGSizeMake(self.superview.frame.size.width,44*4 );
        self.superview.frame = newFrame;
    }*/
    NSLog(@"========%d",[self.arr count]);
    return [self.arr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableType)
    {
        case table1:
        {
            return CELL_SIZE_1;
        }
            break;
        case table2:
        {
            return CELL_SIZE_2;
        }
        default:
        {
            return CELL_SIZE_1;
        }
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    switch (tableType)
    {
        case table1:
            
        {
            objDeveloper=[[DeveloperDataClass alloc]init];
            objDeveloper= [self.arr objectAtIndex:indexPath.row];
            if (![objDeveloper.name isKindOfClass:[NSNull class]]) {
                cell.textLabel.text=[NSString stringWithFormat:@"%@",objDeveloper.name];
            }
            
        }
            break;
        case table2:
        {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

            objGame=[[GameDataClass alloc]init];
            objGame= [self.arr objectAtIndex:indexPath.row];
            cell.textLabel.text=[NSString stringWithFormat:@"%@",objGame.gameName];
            
            cell.imageView.image=imagetinting([UIImage imageNamed:@"mini_box"], colorWithHexString(objGame.gameColor));
        }
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableType)
    {
        case table1:
        {
            
            objDeveloper= [self.arr objectAtIndex:indexPath.row];
            [self.delgate selectQuetion:objDeveloper.name strid:objDeveloper.idstr];
        }
            break;
        case table2:
        {

//           // [self.delgate selectQuetion:[self.arr objectAtIndex:indexPath.row]];
//            obj= [self.arr objectAtIndex:indexPath.row];
//            [self.delgate selectQuetion:obj.name strid:obj.idstr];

        }
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
