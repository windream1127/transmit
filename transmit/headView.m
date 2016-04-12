//
//  headView.m
//  transmit
//
//  Created by lei_dream on 16/4/11.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

#import "headView.h"
#import "presentedVC.h"

//屏幕宽度
#define kSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define kSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


@interface headView ()

@property (strong, nonatomic) NSArray *models; /**< models */

@end
@implementation headView

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    for (int i=0; i<20; i++) {
        NSString *str = [NSString stringWithFormat:@"第%d行",i];
        [arr addObject:str];
    }
    
    self.models = [NSArray arrayWithArray:arr];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifer = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [keyWindow convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    
    presentedVC *rootVC = [[presentedVC alloc]init];
    rootVC.title = self.models[indexPath.row];
    
    [self animationTo:rootVC from:rect];
}

/**
 *  扩展展示
 *
 *  @param viewController 要展示的VC
 *  @param frame          白色展开条的初始位置
 */
-(void)animationTo:(UIViewController*)viewController from:(CGRect)frame{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    
    //黑色遮罩
    UIView *backgroudView = [[UIView alloc]initWithFrame:keyWindow.bounds];
    backgroudView.backgroundColor = [UIColor blackColor];
    backgroudView.alpha = 0.7;
    [keyWindow addSubview:backgroudView];
    
    //白色展开块
    UIView *whiteView = [[UIView alloc]initWithFrame:frame];
    whiteView.backgroundColor = [UIColor whiteColor];
    [keyWindow addSubview:whiteView];
    
    NSTimeInterval timeInterval = 0.5;
    
    [UIView animateWithDuration:timeInterval animations:^{
        whiteView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        //这两句可以保证，下一个视图覆盖了当前视图的时候，当前视图依然在渲染
        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:nav animated:YES completion:^{
            [backgroudView removeFromSuperview];
            [whiteView removeFromSuperview];
        }];
    }];
    
    [UIView animateWithDuration:timeInterval animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
         self.navigationController.view.transform = CGAffineTransformIdentity;
    }];
    
}

@end
