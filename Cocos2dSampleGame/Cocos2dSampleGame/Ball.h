//
//  Ball.h
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Ball : CCSprite {
    BOOL _hitFlg;
}

-(void)fire:(CGPoint)_target speed:(float)speed;
-(void)hit;

@end
