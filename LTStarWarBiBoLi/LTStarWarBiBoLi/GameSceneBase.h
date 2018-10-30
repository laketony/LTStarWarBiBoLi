//
//  GameSceneBase.h
//  LTStarWarBiBoLi
//
//  Created by Laketony on 2018/10/30.
//  Copyright © 2018年 Laketony. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameSceneBase : SKScene
{
    SKShapeNode * _touchShow;
    
    CGPoint downPoint;
    CGPoint down2Point;
    
    SKNode * spMapNode;
}


-(NSMutableArray*)nodeInRect:(CGRect)rect;
- (void)touchDownAtPoint:(CGPoint)pos;
- (void)touchMovedToPoint:(CGPoint)pos;
- (void)touchUpAtPoint:(CGPoint)pos;


@end

NS_ASSUME_NONNULL_END
