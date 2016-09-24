//
//  MyQuizViewController.m
//  Gemification
//
//  Created by Macintosh HD on 02/09/16.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

#import "MyQuizViewController.h"

@interface MyQuizViewController ()

@end

@implementation MyQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnSideMenu.target = self.revealViewController;
    _btnSideMenu.action = @selector(revealToggle:);
    // Do any additional setup after loading the view.
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

@end
