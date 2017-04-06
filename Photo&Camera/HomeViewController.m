//
//  HomeViewController.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "HomeViewController.h"
#import "Photo.h"
#import "AlbumTableViewController.h"
#import "CameraViewController.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        [Photo CheckPhotoisAvailable];
        
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)GoToCamera:(id)sender {
        
        CameraViewController * cameraVC = [[CameraViewController alloc]init];
        [self presentViewController:cameraVC animated:YES completion:nil];
}


- (IBAction)GoToPhoto:(id)sender {
        
        AlbumTableViewController *albumVC = [[AlbumTableViewController alloc]init];
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:albumVC];
        [self presentViewController:navigationController animated:YES completion:nil];
}

@end
