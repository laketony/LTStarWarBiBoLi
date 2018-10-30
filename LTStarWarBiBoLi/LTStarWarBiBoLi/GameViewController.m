//
//  GameViewController.m
//  LTStarWarBiBoLi
//
//  Created by Laketony on 2018/10/30.
//  Copyright © 2018年 Laketony. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController
{
    GameScene *scene;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
     scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}
- (IBAction)btnFxFixSelect:(id)sender {
    [scene unSelect];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
