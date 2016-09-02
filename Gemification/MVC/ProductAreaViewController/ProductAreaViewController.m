//
//  ProductAreaViewController.m
//  Gemification
//
//  Created by Macintosh HD on 03/09/16.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

#import "ProductAreaViewController.h"

@interface ProductAreaViewController ()

@end

@implementation ProductAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnSideMenu.target = self.revealViewController;
    _btnSideMenu.action = @selector(revealToggle:);
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"areaCell"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductsViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsViewController"];
    [self.navigationController pushViewController:pvc animated:YES];
    
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
