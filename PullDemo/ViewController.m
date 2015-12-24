//
//  ViewController.m
//  PullDemo
//
//  Created by 123 on 15/10/28.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "ViewController.h"
#import "AFHttpTool.h"
//#import "MountCellEntity.h"
#import "MountCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)  NSMutableArray *reviewContent;
@property (nonatomic, strong) MountCell    *heightCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _reviewContent = [NSMutableArray new];
    [self makeDataSource];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)makeDataSource{
    [AFHttpTool loadMixedPostWithPage:@"0" success:^(id response) {
        NSLog(@"成功之后的事件在这里写 response数据 ：%@",response[@"itemList"]);
        [_reviewContent addObjectsFromArray:response[@"itemList"]];
        [_tableView reloadData];
    } failure:^(NSError *err) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _reviewContent.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"MountCell";
    MountCell *cell = (MountCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    MountCellEntity *entity = [MountCellEntity new];
    if ([_reviewContent[indexPath.row][@"item_type"] isEqualToString:@"img"]) {
        entity.imageURL = _reviewContent[indexPath.row][@"imgs"][0][@"upfile_web"];
        entity.dict = _reviewContent[indexPath.row][@"imgs"][0];
    }else{
        entity.imageURL = @"";
    }
    
    [cell resetCellWithEntity:entity];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.heightCell == nil) {
        self.heightCell = (MountCell *)[tableView dequeueReusableCellWithIdentifier:@"MountCell"];
    }
    MountCellEntity *entity = [MountCellEntity new];
    if ([_reviewContent[indexPath.row][@"item_type"] isEqualToString:@"img"]) {
        entity.imageURL = _reviewContent[indexPath.row][@"imgs"][0][@"upfile_web"];
        entity.dict = _reviewContent[indexPath.row][@"imgs"][0];
        
        [self.heightCell resetCellWithEntity:entity];
        NSLog(@"cell 高度 %f",self.heightCell.frame.size.height+20);
        
        return self.heightCell.frame.size.height+20;
    }else{
        entity.imageURL = @"";
        return 44;
    }
    
    return 44;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.heightCell == nil) {
        self.heightCell = (MountCell *)[tableView dequeueReusableCellWithIdentifier:@"MountCell"];
    }
    MountCellEntity *entity = [MountCellEntity new];
    if ([_reviewContent[indexPath.row][@"item_type"] isEqualToString:@"img"]) {
        entity.imageURL = _reviewContent[indexPath.row][@"imgs"][0][@"upfile_web"];
        entity.dict = _reviewContent[indexPath.row][@"imgs"][0];
        
        [self.heightCell resetCellWithEntity:entity];
        NSLog(@"cell 高度 %f",self.heightCell.frame.size.height+20);
        
        return self.heightCell.frame.size.height+20;
    }else{
        entity.imageURL = @"";
        return 44;
    }

    return 44;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
