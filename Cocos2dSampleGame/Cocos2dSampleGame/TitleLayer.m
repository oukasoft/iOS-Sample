//
//  TitleLayer.m
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TitleLayer.h"
#import "RuleLayer.h"
#import "SimpleAudioEngine.h"

@implementation TitleLayer

+(CCScene *) scene
{
	CCScene    *scene = [CCScene node];
	TitleLayer *layer = [TitleLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
	[super onEnter];

    // 画面サイズを取得
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // 背景画像用スプライトを生成
    CCSprite *backImg = [CCSprite spriteWithFile:@"title_bk.png"];
    // 表示位置設定
    backImg.position = ccp( winSize.width/2,winSize.height/2 );
    // レイヤーに追加
    [self addChild:backImg];

   // 画像からメニューを作成
    CCMenuItemImage *item = [CCMenuItemImage itemWithNormalImage:@"push_start_btn.png"
                                                   selectedImage:@"push_start_btn_select.png"
                                                          target:self
                                                        selector:@selector(nextLayer:)];

    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    menu.position = ccp( winSize.width/2, winSize.height * 0.3  );
    
    // メニューを点滅させる（無限に繰り返し）
    CCBlink *blink = [CCBlink actionWithDuration:1 blinks:1];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:blink];
    [menu runAction:repeat];
    // レイヤーに追加
    [self addChild:menu];

    // 効果音のプリロード
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"scratch.wav"];
}

-(void)nextLayer:(id)sender{
    // 効果音を鳴らせる
    [[SimpleAudioEngine sharedEngine]playEffect:@"scratch.wav"];

    CCTransitionFade *trans = [CCTransitionFade transitionWithDuration:1.0
                                                                 scene:[RuleLayer scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}

@end
