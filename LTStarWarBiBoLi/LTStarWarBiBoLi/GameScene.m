//
//  GameScene.m
//  LTStarWarBiBoLi
//
//  Created by Laketony on 2018/10/30.
//  Copyright © 2018年 Laketony. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene 
{
    NSArray *selectNodes;
    bool isSelectedNodes;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    [super didMoveToView:view];
    
    for (int i = 0; i<100; i++) {
        SKSpriteNode* node =  [SKSpriteNode spriteNodeWithImageNamed:@"LAZY_LOAD_ship_44"];
        [node setPosition:CGPointMake(700-rand()%1334, 350-rand()%700)];
        [spMapNode addChild:node];
    }
    isSelectedNodes = NO;
    
    
    SKSpriteNode* node =  [SKSpriteNode spriteNodeWithImageNamed:@"LAZY_LOAD_DOWN_ship82"];
    [node setPosition:CGPointMake(300,1500)];
    [node setScale:5];
    [spMapNode addChild:node];
}




- (void)touchDownAtPoint:(CGPoint)pos {
    [super touchDownAtPoint:pos];
    
    if(isSelectedNodes){
      
    }else{
        downPoint = pos;
        down2Point = pos;
        CGFloat w = fabs(downPoint.x - down2Point.x);
        CGFloat h = fabs(downPoint.y - down2Point.y);
        _touchShow = [SKShapeNode shapeNodeWithRect:CGRectMake(downPoint.x, downPoint.y, w, h)];
        [_touchShow setStrokeColor:[UIColor greenColor]];
        [_touchShow setFillColor:[[UIColor greenColor] colorWithAlphaComponent:0.1]];
        [self addChild:_touchShow];
    }
    
   
    
   
    
}



- (void)touchMovedToPoint:(CGPoint)pos {
    [super touchMovedToPoint:pos];
    

    if(isSelectedNodes  ){
        
    }else{
        down2Point = pos;
        [_touchShow removeFromParent];
        
        CGFloat w = fabs(downPoint.x - down2Point.x);
        CGFloat h = fabs(downPoint.y - down2Point.y);
        CGFloat x = downPoint.x>down2Point.x?downPoint.x-w:downPoint.x;
        CGFloat y = downPoint.y>down2Point.y?downPoint.y-h:downPoint.y;
        CGRect selectRect = CGRectMake(x,y, w, h);
        
        _touchShow = [SKShapeNode shapeNodeWithRect:selectRect];
        [_touchShow setStrokeColor:[UIColor greenColor]];
        [_touchShow setFillColor:[[UIColor greenColor] colorWithAlphaComponent:0.1]];
        [self addChild:_touchShow];
        
        
        selectNodes = [self nodeInRect:selectRect];
    }
}

- (void)touchUpAtPoint:(CGPoint)pos {
    [super touchUpAtPoint:pos];

    
    if(isSelectedNodes){
        if(selectNodes != nil ){
            for (SKSpriteNode * node in selectNodes) {
                SKSpriteNode *tagernode =[spMapNode nodeAtPoint:pos];
                // tagernode == spMapNode 移动,不等于就攻击
                bool move_or_attack = [tagernode isEqualToNode:spMapNode];
               //move or attack
                if(move_or_attack){
                    CGFloat moveX = node.position.x - pos.x;
                    CGFloat absf = fabs(node.yScale);
                    
                    if(moveX>0){
                        [node runAction: [SKAction scaleXTo:absf duration:0.1]];
                    }else if(moveX<0){
                        [node runAction: [SKAction scaleXTo:absf*-1 duration:0.1]];
                    }
                    
                    [node runAction: [SKAction moveTo:CGPointMake(pos.x+(250-rand()%500), pos.y+(250-rand()%500)) duration:3]];
                }else{
                    //
                    int ssssi = rand()%4+1;
                    //
                    for (int i = 0; i<ssssi; i++) {
                        NSArray * attackArray = @[[SKAction runBlock:^{
                            
                            SKSpriteNode *biu = [SKSpriteNode spriteNodeWithImageNamed:@"LAZY_LOAD_hit03_00"];
                            [biu setPosition:node.position];
                            CGSize tsize = [tagernode size];
                            CGPoint tpos = tagernode.position;
                            
                            CGPoint overPoint = CGPointMake(tpos.x+(tsize.width/2.0-rand()%(int)tsize.width), tpos.y+(tsize.height/2.0-rand()%(int)tsize.height));
                            
                            CGMutablePathRef path = CGPathCreateMutable();
                            CGPathMoveToPoint(path, nil, node.position.x, node.position.y);
                            CGPathAddLineToPoint(path, nil, overPoint.x, overPoint.y);
                            
                            SKAction *biuMove = [SKAction followPath:path asOffset:NO orientToPath:YES duration:1+rand()%100/20.0];
                            
                            
                            
                            SKAction *over = [SKAction animateWithTextures:@[
                                                                             [SKTexture textureWithImageNamed:@"LAZY_LOAD_hit03_00"],
                                                                             [SKTexture textureWithImageNamed:@"LAZY_LOAD_hit03_01"],
                                                                             [SKTexture textureWithImageNamed:@"LAZY_LOAD_hit03_02"]
                                                                             ] timePerFrame:0.2];
                            SKAction *remove = [SKAction removeFromParent];
                            [biu runAction:[SKAction sequence:@[biuMove,over,remove]]];
                            [self addChild:biu];
                        }],[SKAction waitForDuration:0.4]];
                        
                        [node removeActionForKey:@"attack"];
                        [node runAction: [SKAction repeatActionForever:[SKAction sequence:attackArray]] withKey:@"attack"];
                    }
                    //
                }
                //
            }
        }
    }else{
        [_touchShow removeFromParent];
        
        for (SKSpriteNode * node in selectNodes) {
            [node setColor: [UIColor greenColor]];
            [node setColorBlendFactor:0.3];
        }
        isSelectedNodes = YES;
    }
    
}

-(void)unSelect{
    
    for (SKSpriteNode * node in selectNodes) {
        [node setColor: [UIColor whiteColor]];
        [node setColorBlendFactor:1];
    }
    
    selectNodes = nil;
    isSelectedNodes = NO;
}


@end
