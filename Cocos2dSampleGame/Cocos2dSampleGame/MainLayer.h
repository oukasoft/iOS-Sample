//
//  MainLayer.h
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BallMgr.h"

@interface MainLayer : CCLayer {
    BallMgr    *_ballMgr;
    CCLabelTTF *_timeLbl;
    int        _time;
}
+(CCScene *) scene;

-(void)onScheduleAddBall:(ccTime)delta;
@end
