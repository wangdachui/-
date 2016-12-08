//
//  WTMainVC.m
//  学习整理
//
//  Created by 王涛 on 15/7/22.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTMainVC.h"

@interface WTMainVC ()
@property (nonatomic, strong) NSArray *sampleCodeClassNames;
@property (nonatomic, strong) NSArray *sampleCodeTitles;
@end

@implementation WTMainVC
- (void)initDatas{
    
    if (!self.sampleCodeTitles) {
        self.sampleCodeTitles = @[@"寄宿图－contentsRect",
                                  @"仿射变换-AffineTransform",
                                  @"立方体",
                                  @"专业图层",
                                  @"隐式动画",
                                  @"显示动画"];
        ;
    }
    if (!self.sampleCodeClassNames) {
        self.sampleCodeClassNames = @[@"A_CALayer_ContentsRectVC",
                                      @"CGAffineTransformVC",
                                      @"Box3DVC",
                                      @"LayersVC",
                                      @"ImplicitVC",
                                      @"ObviousAnimationVC"];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学习整理";
    [self initDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source &  Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sampleCodeClassNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.sampleCodeTitles[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *className = self.sampleCodeClassNames[indexPath.row];
    UIViewController *subViewController = [[NSClassFromString(className) alloc]init];
    subViewController.title = self.sampleCodeTitles[indexPath.row];
    [self.navigationController pushViewController:subViewController animated:YES];
}

@end
