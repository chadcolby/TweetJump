//
//  bmwViewController.m
//  Tweet Dodge
//
//  Created by Chad D Colby on 2/19/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwViewController.h"
#import "bmwMyScene.h"

@implementation bmwViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillLayoutSubviews
{
    // Configure the view.
    self.skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [bmwMyScene sceneWithSize:self.skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)showSelectedTweet
{

    NSLog(@"I SEE THIS");
}

@end
