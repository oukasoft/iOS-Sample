//
//  SampleTouchSprite.m
//  Cocos2dTouchSample
//
//  Created by inukai on 2013/03/16.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SampleTouchSprite.h"


@implementation SampleTouchSprite

-(void)onEnter{
    
    // CCTouchDispatcherに自分を追加
    [[[CCDirector sharedDirector] touchDispatcher ] addTargetedDelegate:self
                                                               priority:0
                                                        swallowsTouches:YES];

    [super onEnter];
}

-(void)onExit{
    // CCTouchDispatcherから自分を削除
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CCLOG(@"start");
    
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    // タッチされた座標を取得&変換
    CGPoint touchPotision = [touch locationInView:touch.view];
    CGPoint position      = [[CCDirector sharedDirector] convertToGL:touchPotision];
    
    // タッチされた座標が画像の範囲内の場合
    if( CGRectContainsPoint( self.boundingBox , position) ){
        // タッチされた座標に画像の座標を設定する
        self.position = position;
    }
    
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CCLOG(@"end");
    
}

@end
