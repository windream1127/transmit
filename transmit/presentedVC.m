//
//  presentedVC.m
//  transmit
//
//  Created by lei_dream on 16/4/12.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

#import "presentedVC.h"

@implementation presentedVC

-(void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    [self.navigationItem setLeftBarButtonItem:item];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dismissSelf {
    
        self.presentingViewController.view.transform = CGAffineTransformMakeScale(0.85, 0.85);
        [UIView animateWithDuration:0.5 animations:^{
            self.presentingViewController.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
