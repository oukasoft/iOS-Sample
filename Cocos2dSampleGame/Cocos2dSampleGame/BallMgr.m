//
//  BallMgr.m
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//
//

#import "BallMgr.h"
#import "Ball.h"

@implementation BallMgr


-(id)init{
    if(self = [super init]){
        _ballList  = [[CCArray alloc]init];
        _tenko     = nil;
        _winSize   = [[CCDirector sharedDirector] winSize];
        _fireCount = 0;
    }
    return self;
}

-(void)setTenko:(Tenko *)tenko{
    _tenko = tenko;
}
-(Tenko *)getTenko{
    return _tenko;
}
-(CCSprite *)makeBall{
    // ボールを生成
    Ball *ball = [Ball spriteWithFile:@"ball.png"];
    // ボールの出発点を９カ所の内からランダムで取得
    ball.position = [self getRandomStartPoint];
    // ボールに出発点とスピードを設定して発射
    [ball fire:_tenko.position speed:[self getRandomSpeed]];
    // ボールをリストに追加
    [_ballList addObject:ball];

    return ball;
}

-(int)getBallCount{
    return _ballList.count;
}

// ボールとtenkoの衝突判定
-(BOOL)checkHitBalls{
    BOOL result = NO;
    for ( Ball *ball in _ballList ) {
        if( CGRectIntersectsRect( ball.boundingBox, _tenko.hitBoundingBox ) ){
            [_tenko hit];
            [ball hit];
            [_ballList removeObject:ball];
            result = YES;
        }
        
    }
    
    return result;
}
// ボールとタッチ位置の衝突判定
-(BOOL)checkTouchBalls:(CGPoint)touchPosition{
    BOOL result = NO;
    for ( Ball *ball in _ballList ) {
        if( CGRectContainsPoint( ball.boundingBox , touchPosition ) ){
            [ball hit];
            [_ballList removeObject:ball];
            result = YES;
            break;
        }
        
    }
    return result;
}
// ボールを消去
-(void)clearBalls{
    for ( Ball *ball in _ballList ) {
        [ball removeFromParentAndCleanup:YES];
    }
    [_ballList removeAllObjects];
}

// 速度を取得する
-(float)getRandomSpeed{
    // 乱数を取得
    float rand = CCRANDOM_0_1();
    int random = (int)(rand*4); // 0〜3までの乱数を取得
    // 1.0〜1.3までの乱数を返す
    return (1.0 + random*0.1 );
}


// 9カ所のどれかの出発点を取得する
-(CGPoint)getRandomStartPoint{
    
    // 乱数を取得
    float rand = CCRANDOM_0_1();
    int random = (int)(rand*11); // 0〜10までの乱数を取得
    //CCLOG(@"set random %d", random );
    CGPoint result;

    switch ( random ) {
        case 0:
            result = ccp( -100 , _tenko.position.y );
            break;
        case 1:
            result = ccp( _winSize.width + 100 , _tenko.position.y );
            break;
        case 2:
            result = ccp( -100 , _tenko.position.y + 50 );
            break;
        case 3:
            result = ccp( _winSize.width + 100 , _tenko.position.y + 50 );
            break;
        case 4:
            result = ccp( -100 , _tenko.position.y + 100 );
            break;
        case 5:
            result = ccp( _winSize.width + 100 , _tenko.position.y + 100 );
            break;
        case 6:
            result = ccp( -100 , _winSize.height + 100 );
            break;
        case 7:
            result = ccp( _winSize.width + 100 , _winSize.height + 100 );
            break;
        case 8:
            result = ccp( _tenko.position.x - 100 , _winSize.height + 100 );
            break;
        case 9:
            result = ccp( _tenko.position.x + 100, _winSize.height + 100 );
            break;
        case 10:
            result = ccp( _tenko.position.x , _winSize.height + 100 );
            break;
        default:
            break;
    }
    //CCLOG(@"make postion x[%f],y[%f]", result.x, result.y );
    return result;
}

// 0.1秒間隔で呼ばれる関数、発射フラグを計算して返す
-(BOOL)checkFireFlg:(int)time{
    BOOL result = NO;
    // 発射カウントを増やす
    _fireCount++;
    
    // 20秒〜14秒の間は0.9秒に1回発射
    if ( time > 13 ) {
        result = (_fireCount%9==0)? YES:NO;
    // 13秒〜8秒の間は0.6秒に1回発射
    }else if( time <= 13 && time > 7 ){
        result = (_fireCount%6==0)? YES:NO;
    // 7秒〜0秒の間は0.3秒に1回発射
    }else{
        result = (_fireCount%3==0)? YES:NO;
    }
    return result;
}

@end
