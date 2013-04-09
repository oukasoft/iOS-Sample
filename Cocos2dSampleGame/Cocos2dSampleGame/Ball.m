//
//  Ball.m
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"


@implementation Ball

-(id)init{
    if(self = [super init]){
        _hitFlg = NO;
    }
    return self;
}

-(void)fire:(CGPoint)_target speed:(float)speed{
    
    // ボールにアクションを設定
    CCMoveBy *moveBy = [CCMoveTo actionWithDuration:speed position:_target];
    CCRotateBy *rotate = [CCRotateBy actionWithDuration:speed angle:360];
    CCSpawn *spawn = [CCSpawn actions:moveBy,rotate, nil];
    // アクション開始
    [self runAction:spawn];
}

-(void)hit{
    [self stopAllActions];
    // ボールにアクションを設定
    CCMoveBy *moveBy = [CCMoveTo actionWithDuration:1.0 position:ccp( self.position.x , self.position.y - 20 )];
    CCFadeOut *fade = [CCFadeOut actionWithDuration:1.0];
    CCSpawn *spawn = [CCSpawn actions:moveBy,fade, nil];
    // アクション開始
    [self runAction:spawn];
    [self scheduleOnce:@selector(deleteSelf) delay:1.0];
}

-(void)deleteSelf{
    // レイヤーから削除
    [self removeFromParentAndCleanup:YES];
}

@end
