//
//  SideMenuViewController.m
//  EPM
//
//  Created by Macintosh HD on 12/08/16.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController (){
    NSMutableArray *imgName,*NameArray;
}

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NameArray = [NSMutableArray arrayWithObjects:@"",@"DASHBOARD",@"TRAINING",@"LEARNING PRODUCTS",@"GIVE A TIP",@"STUDIO",@"PRODUCT DAY",@"CONTACTS"@"LOG OUT", nil];

    // Do any additional setup after loading the view.
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        return 90;
    }
    return 50;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NameArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
        
    }
    else
    {
        SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
//        cell.backgroundColor = [UIColor colorWithRed:96.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1];
        cell.lblName.text =[NameArray objectAtIndex:indexPath.row];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1)
    {
        DashboardViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
        
        UINavigationController *MainNav= [[UINavigationController alloc]initWithRootViewController:dvc];
        [self.revealViewController pushFrontViewController:MainNav animated:YES];
    }
    else if (indexPath.row == 2)
    {
        
        TrainingViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TrainingViewController"];
        UINavigationController *MainNav= [[UINavigationController alloc]initWithRootViewController:tvc];
        [self.revealViewController pushFrontViewController:MainNav animated:YES];
        
    }
    else if (indexPath.row == 3)
    {
        ProductAreaViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductAreaViewController"];
        UINavigationController *MainNav= [[UINavigationController alloc]initWithRootViewController:pvc];
        [self.revealViewController pushFrontViewController:MainNav animated:YES];
        
    }
    else if (indexPath.row == 4)
    {
        TipsViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TipsViewController"];
        UINavigationController *MainNav= [[UINavigationController alloc]initWithRootViewController:pvc];
        [self.revealViewController pushFrontViewController:MainNav animated:YES];
        
    }
//    else if (indexPath.row == 3)
//    {
//      ChatViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
//        UINavigationController *MainNav= [[UINavigationController alloc]initWithRootViewController:cvc];
//        [self.revealViewController pushFrontViewController:MainNav animated:YES];    }
//    else if (indexPath.row == 4)
//    {
//     SoftSkillViewController *ssvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SoftSkillViewController"];
//        UINavigationController *MainNav= [[UINavigationController alloc]initWithRootViewController:ssvc];
//        [self.revealViewController pushFrontViewController:MainNav animated:YES];
//        
//    }
//    else if (indexPath.row == 7)
//    {
//        MyQuizViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuizViewController"];
//        UINavigationController *MainNav= [[UINavigationController alloc]initWithRootViewController:pvc];
//        [self.revealViewController pushFrontViewController:MainNav animated:YES];
//    }
    
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
