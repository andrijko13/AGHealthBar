//
//  ASHealthBar.h
//  Average Guy 2
//
//  Created by Andriy Suden on 10/12/16.
//  Copyright © 2016 DropGeeks. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASHealthBar : SKNode
{
    
}
@property (nonatomic) double healthPercentage;
@property (nonatomic) long maxHealth;
@property (nonatomic) long currentHealth;
@property NSTimer *animationTimer;

+(ASHealthBar *)initWithSize:(CGSize)size;
-(void)animateToPercentage:(double)percentage withTime:(double)time_val;
-(void)animateToHealth:(long)health_val withTime:(double)time_val;
@end
