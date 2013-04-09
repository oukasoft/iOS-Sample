//
//  BallMgr.h
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tenko.h"
#import "Ball.h"

@interface BallMgr : NSObject{
    CCArray *_ballList;
    Tenko   *_tenko;
    CGSize  _winSize;
    int     _fireCount;
}

-(void)setTenko:(Tenko *)tenko;
-(Tenko *)getTenko;
-(Ball *)makeBall;
-(int)getBallCount;
-(BOOL)checkHitBalls;
-(BOOL)checkTouchBalls:(CGPoint)touchPosition;
-(BOOL)checkFireFlg:(int)time;
-(void)clearBalls;
@end
