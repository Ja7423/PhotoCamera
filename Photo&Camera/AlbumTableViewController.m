//
//  AlbumTableViewController.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/4.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "AlbumTableViewController.h"



@interface AlbumTableViewController () <UITableViewDelegate, DataSourceModelDelegate>
{
        DataSourceModel * _dataSourceModel;
        
        BOOL _needUpdateData;
}

@end

@implementation AlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        // navigationBar setting
        self.navigationItem.title = @"Album";
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backToHome)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTableView)];
        
        [self.tableView registerClass:[AlbumTableViewCell class] forCellReuseIdentifier:@"AlbumTableViewCell"];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        _needUpdateData = NO;
        _dataSourceModel = [[DataSourceModel alloc]init];
        [_dataSourceModel startLinkPhotoLibrary];
        _dataSourceModel.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];
        [_dataSourceModel needUpdateData:_needUpdateData];
}

- (void)viewWillDisappear:(BOOL)animated
{
        [super viewWillDisappear:animated];
        _needUpdateData = YES;
}

- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark - status bar style
- (UIStatusBarStyle)preferredStatusBarStyle
{
        return UIStatusBarStyleLightContent;
}

#pragma mark - button action
- (void)backToHome
{
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadTableView
{
        [self.tableView reloadData];
}

#pragma mark - data source model delegate
- (void)dataSourceModelDidChange:(DataSourceModel *)dataSourceModel
{
        dispatch_async(dispatch_get_main_queue(), ^{
            
                _needUpdateData = NO;
                
                [self.tableView reloadData];
                
        });
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return [_dataSourceModel numberOfDataAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumTableViewCell" forIndexPath:indexPath];
    
        // Configure the cell...
        FetchResultModel *model = [_dataSourceModel dataAtIndex:indexPath.row];
         [model postImageSize:cell.albumImageView.frame.size completion:^(UIImage *image) {
                 cell.albumImageView.image = image;
         }];
        
        [cell.albumLabel setText:[NSString stringWithFormat:@"%@ (%lu)", model.albumName, (unsigned long)model.count]];
        
        return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return self.view.frame.size.height / 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        PhotoPickerViewController * photoVC = [[PhotoPickerViewController alloc]init];
        photoVC.fetchResultModel = [_dataSourceModel dataAtIndex:indexPath.row];
        [self.navigationController pushViewController:photoVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
