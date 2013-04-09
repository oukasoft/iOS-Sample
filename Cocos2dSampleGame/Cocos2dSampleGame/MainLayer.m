//
//  MainLayer.m
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "ResultLayer.h"
#import "Tenko.h"
#import "Ball.h"
#import "SimpleAudioEngine.h"

@implementation MainLayer
+(CCScene *) scene
{
	CCScene    *scene = [CCScene node];
	MainLayer  *layer = [MainLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
	[super onEnter];

    // 画面サイズを取得
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    // 背景画像用スプライトを生成
    CCSprite *backImg = [CCSprite spriteWithFile:@"main_bk.png"];
    // 表示位置設定
    backImg.position = ccp( winSize.width/2,winSize.height/2 );
    // レイヤーに追加
    [self addChild:backImg];

    // 残り時間表示用ラベル作成
    _time = 20;
    _timeLbl= [CCLabelTTF labelWithString:[NSString stringWithFormat:@"のこり時間:%d", _time ] fontName:@"HiraKakuProN-W3" fontSize:29];
    _timeLbl.color = ccc3(0,0,0);
    _timeLbl.position = ccp( winSize.width * 0.24 ,winSize.height * 0.88 );
    [self addChild:_timeLbl];

    // てんこ生成
    Tenko *tenko = [Tenko spriteWithFile:@"tenko.png"];
    // 表示位置設定
    [tenko setPosition];
    // あたり判定に使う領域作成
    [tenko setBoundingBox];
    // レイヤーに追加
    [self addChild:tenko];
    
    // ボール管理クラス生成
    _ballMgr = [[BallMgr alloc]init];
    [_ballMgr setTenko:tenko];
    
    // スケジュールを設定
    [self scheduleUpdate]; // メインループ 1秒に60回実行される
    [self schedule:@selector(onScheduleAddBall:) interval:0.1]; // 0.1秒に1回実行される
    [self schedule:@selector(onScheduleTimeCount:) interval:1.0]; // 1秒に1回実行される
    
    // タッチイベントを有効にする
    self.isTouchEnabled = YES;
    
    // 効果音のプリロード
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"hit.wav"];
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"hit2.wav"];
}

// メインループ
-(void) update:(ccTime)dt{
    // ボールがあればあたり判定のチェック
    if( [_ballMgr getBallCount] ){
        if( [_ballMgr checkHitBalls] ){
            // 当たった場合は画面を揺らせる
            CCMoveBy *move1 = [CCMoveBy actionWithDuration:0.05 position:ccp( 3, 0 )];
            CCMoveBy *move2 = [CCMoveBy actionWithDuration:0.05 position:ccp( -6, 2 )];
            CCMoveBy *move3 = [CCMoveBy actionWithDuration:0.05 position:ccp( 3, -2 )];
            CCSequence *seq = [CCSequence actions:move1,move2,move3, nil];
            [self runAction:seq];
            // 音を鳴らす
            [[SimpleAudioEngine sharedEngine]playEffect:@"hit.wav"];
        }
    }
}

// 0.1秒に1回実行されるループ処理
-(void)onScheduleAddBall:(ccTime)delta{
    if( _time == 0 ){ return; }

    // 発射フラグを取得
    BOOL fireFlg = [_ballMgr checkFireFlg:_time];
    
    if( fireFlg ){
        // ボールを生成(表示位置やアクションなども生成しています)
        Ball *ball = [_ballMgr makeBall];
        // ボールをレイヤーに追加
        [self addChild:ball];
    }
}
// 1秒に1回実行されるループ処理
-(void)onScheduleTimeCount:(ccTime)delta{
    // 秒数を減らす
    _time--;
    // ラベルを更新する
    [_timeLbl setString:[NSString stringWithFormat:@"のこり時間:%d", _time ]];
    // 終了判定
    if( _time == 0 ){
        // 表示中の弾をすべて消去
        [_ballMgr clearBalls];
        // 次の画面に遷移
        [self nextLayer];
    }
}

// タッチイベント
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    // タッチされた座標を取得&変換
    CGPoint touchPotision = [touch locationInView:touch.view];
    CGPoint position      = [[CCDirector sharedDirector] convertToGL:touchPotision];
    // タッチ座標とボールの衝突判定
    if( [_ballMgr checkTouchBalls:position] ){
        [[SimpleAudioEngine sharedEngine] playEffect:@"hit2.wav"];
    }
}


// 次の画面に遷移
-(void)nextLayer{
    
    // 次のシーンを生成
    CCScene *nextScene = [ResultLayer scene];
    // シーンからレイヤーを取得
    ResultLayer *layer = [nextScene.children objectAtIndex:0];
    // データをセット
    layer.hitCount = [_ballMgr getTenko].hitCount;
    
    CCTransitionFade *trans = [CCTransitionFade transitionWithDuration:1.0
                                                                 scene:nextScene];
    [[CCDirector sharedDirector] replaceScene:trans];
}

@end
