//
//  GameSceneBase.m
//  LTStarWarBiBoLi
//
//  Created by Laketony on 2018/10/30.
//  Copyright © 2018年 Laketony. All rights reserved.
//

#import "GameSceneBase.h"

@implementation GameSceneBase
{
    SKSpriteNode * _clickD;
    SKSpriteNode * _clickU;
}
- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    _clickD = [SKSpriteNode spriteNodeWithImageNamed:@"quanquan_01"];
    [_clickD setScale:2];
    [_clickD runAction: [SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:0.4]]];
    [_clickD runAction: [SKAction sequence:@[
                                            [SKAction waitForDuration:0.4],
                                            [SKAction scaleTo:0 duration:0.3],
                                            [SKAction removeFromParent]
                                            ]]];
    
    _clickU = [SKSpriteNode spriteNodeWithImageNamed:@"quanquan_02"];
    [_clickU setScale:2];
    [_clickU runAction: [SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:0.2]]];
    [_clickU runAction: [SKAction sequence:@[
                                            [SKAction waitForDuration:0.4],
                                            [SKAction scaleTo:0 duration:0.3],
                                            [SKAction removeFromParent]
                                            ]]];
    
    spMapNode = [SKNode node];
    [self addChild:spMapNode];
}


- (void)touchDownAtPoint:(CGPoint)pos {
    SKSpriteNode * clickshow = [_clickD copy];
    clickshow.position = pos;
    [self addChild:clickshow];
}

- (void)touchMovedToPoint:(CGPoint)pos {

}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKSpriteNode * clickshow = [_clickU copy];
    clickshow.position = pos;
    [self addChild:clickshow];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Run 'Pulse' action from 'Actions.sks'
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}

-(NSMutableArray*)nodeInRect:(CGRect)rect
{
    NSMutableArray * rearray = [NSMutableArray array];
    
    for (SKNode * node in spMapNode.children) {
       
        bool isInRect = CGRectContainsPoint(rect,  node.position);
        
        if (isInRect) {
            [rearray addObject:node];
        }
    }
    
    
    return rearray;
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}
@end
