//
//  CustomTableView.m
//  nFlate
//
//  Created by mac-007 on 27/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "CustomTableView.h"
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
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
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
            cell.textLabel.text=[self.arr objectAtIndex:indexPath.row];
        }
            break;
        case table2:
        {
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[self.arr objectAtIndex:indexPath.row]];
            //cell.imageView.image=[self.arr objectAtIndex:indexPath.row];

           // cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.arr objectAtIndex:indexPath.row]]];
            cell.imageView.image=imagetinting([UIImage imageNamed:@"mini_box"], [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:0.2]);
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
            [self.delgate selectQuetion:[self.arr objectAtIndex:indexPath.row]];
        }
            break;
        case table2:
        {
            [self.delgate selectQuetion:[self.arr objectAtIndex:indexPath.row]];

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
