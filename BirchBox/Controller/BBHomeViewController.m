//
//  ViewController.m
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBHomeViewController.h"
#import "BBProductViewController.h"
#import "Birchbox.h"

@interface BBHomeViewController ()<UIPageViewControllerDataSource>

@property (nonatomic, copy) NSArray *productIds;
@property (nonatomic, strong) NSMutableArray *products;
@property (strong, nonatomic) UIPageViewController *pageController;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation BBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.productIds = @[@"11307",
                        @"20953",
                        @"20060"];
    self.products = [NSMutableArray array];
    
    [self configurePageController];
}

- (void)configurePageController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self contentView] bounds]];
    
    BBProductViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self contentView] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];

}

- (BBProductViewController *)viewControllerAtIndex:(NSUInteger)index {
    BBProductViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:kStoryboardControllerProduct];
    [childViewController configureWithProductId:self.productIds[index]];
    
    return childViewController;
    
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSString *productId = [(BBProductViewController *)viewController productId];
    NSUInteger index = [self.productIds indexOfObject:productId];

    if (index == 0) {
        index = self.productIds.count - 1;
    } else {
        index --;
    }
    

    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSString *productId = [(BBProductViewController *)viewController productId];
    NSUInteger index = [self.productIds indexOfObject:productId];
    
    if (index == (self.productIds.count - 1)) {
        index = 0;
    } else {
        index ++;
    }
    
    return [self viewControllerAtIndex:index];
}

@end
