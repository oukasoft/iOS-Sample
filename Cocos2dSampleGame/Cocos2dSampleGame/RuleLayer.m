//
//  RuleLayer.m
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RuleLayer.h"
#import "MainLayer.h"
#import "SimpleAudioEngine.h"
@implementation RuleLayer
+(CCScene *) scene
{
	CCScene    *scene = [CCScene node];
	RuleLayer  *layer = [RuleLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
	[super onEnter];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // 背景画像用スプライトを生成
    CCSprite *backImg = [CCSprite spriteWithFile:@"rule_bk.png"];
    // 表示位置設定
    backImg.position = ccp( winSize.width/2,winSize.height/2 );
    // レイヤーに追加
    [self addChild:backImg];
    // タッチイベントを有効にする
    self.isTouchEnabled = YES;
}

// タッチイベント
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self nextLayer:self];
}

-(void)nextLayer:(id)sender{
    // 効果音を鳴らせる
    [[SimpleAudioEngine sharedEngine]playEffect:@"scratch.wav"];
    CCTransitionFade *trans = [CCTransitionFade transitionWithDuration:1.0
                                                                 scene:[MainLayer scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}

@end
