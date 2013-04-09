//
//  ResultLayer.m
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ResultLayer.h"
#import "TitleLayer.h"
#import "SimpleAudioEngine.h"
@implementation ResultLayer
@synthesize hitCount;
+(CCScene *) scene
{
	CCScene     *scene = [CCScene node];
	ResultLayer *layer = [ResultLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
    [super onEnter];

    // 画面サイズを取得
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // 背景画像用スプライトを生成
    CCSprite *backImg = [CCSprite spriteWithFile:@"result_bk.png"];
    // 表示位置設定
    backImg.position = ccp( winSize.width/2,winSize.height/2 );
    // レイヤーに追加
    [self addChild:backImg];
 
    // ゲーム結果表示用ラベル作成
    CCLabelTTF *resultLbl= [CCLabelTTF labelWithString:[NSString stringWithFormat:@"被弾した回数:%d", hitCount  ]
                                              fontName:@"HiraKakuProN-W3"
                                              fontSize:35];
    resultLbl.color = ccc3(0,0,0);
    resultLbl.position = ccp( winSize.width /2 ,winSize.height * 0.6 );
    [self addChild:resultLbl];

    // 得点によって表示するメッセージを変える
    if( hitCount == 0 ){
        CCSprite *clearImg = [CCSprite spriteWithFile:@"perfect.png"];
        clearImg.position = ccp( winSize.width/2,winSize.height * 0.4 );
        [self addChild:clearImg];
    }else{
        NSString *message = @"";
        if( hitCount > 0 && hitCount <= 3 ){
            message = @"「あとちょっと...」";
        }else if( hitCount > 3 ){
            message = @"「もっとがんばろう...」";
        }
        CCLabelTTF *messageLbl= [CCLabelTTF labelWithString:message
                                                  fontName:@"HiraKakuProN-W3"
                                                  fontSize:34];
        messageLbl.color = ccc3(0,0,0);
        messageLbl.position = ccp( winSize.width /2 ,winSize.height * 0.4 );
        [self addChild:messageLbl];
    }

    // 画像からメニューを作成
    CCMenuItemImage *item = [CCMenuItemImage itemWithNormalImage:@"push_title_btn.png"
                                                   selectedImage:@"push_title_btn_select.png"
                                                          target:self
                                                        selector:@selector(nextLayer:)];
    
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    menu.position = ccp( winSize.width/2, winSize.height * 0.2  );
    
    // メニューを点滅させる（無限に繰り返し）
    CCBlink *blink = [CCBlink actionWithDuration:1 blinks:1];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:blink];
    [menu runAction:repeat];
    // レイヤーに追加
    [self addChild:menu];
}

-(void)nextLayer:(id)sender{
    // 効果音を鳴らせる
    [[SimpleAudioEngine sharedEngine]playEffect:@"scratch.wav"];
    CCTransitionFade *trans = [CCTransitionFade transitionWithDuration:1.0
                                                                 scene:[TitleLayer scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}

@end
