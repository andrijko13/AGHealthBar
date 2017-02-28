//
//  ASHealthBar.m
//  Average Guy 2
//
//  Created by Andriy Suden on 10/12/16.
//  Copyright © 2016 DropGeeks. All rights reserved.
//

#import "ASHealthBar.h"

@interface ASHealthBar ()
{
    SKSpriteNode *health;
    SKSpriteNode *background;
    SKSpriteNode *outline;
    
    double xFactor;
    double yFactor;
    
    int timerCount;
    double timeInterval;
}
-(void)updateColor;
-(void)createNodeWithSize:(CGSize)size;
@end

@implementation ASHealthBar
@synthesize healthPercentage = _healthPercentage;
@synthesize maxHealth = _maxHealth;
@synthesize currentHealth = _currentHealth;
@synthesize animationTimer = _animationTimer;

-(void)goToHealth:(NSTimer *)sender {
    NSNumber *ourNum = (NSNumber *)sender.userInfo;
    double increment = [ourNum doubleValue];
    
    @try {
        
        NSLog(@"triggred %d time with interval: %f",timerCount, [sender timeInterval]);
        self.healthPercentage += increment;
        
        if (timerCount == 50){
            
            [self.animationTimer invalidate];
            self.animationTimer = nil;
            NSLog(@"invalidated");
        } else {
            //self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(goToHealth:) userInfo:[NSNumber numberWithDouble:increment] repeats:NO];
        }
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"%s\n exception: Name- %@ Reason->%@", __PRETTY_FUNCTION__,[exception name],[exception reason]);
    }
    @finally {
        
        timerCount++;
    }

}

-(void)setCurrentHealth:(long)currentHealth {
    _currentHealth = currentHealth;
    double f = (double)currentHealth/_maxHealth;
    self.healthPercentage = f;
}

-(double)healthPercentage {
    return _healthPercentage;
}

-(void)setHealthPercentage:(double)healthPercentage {
    health.yScale = yFactor;
    health.xScale = xFactor*healthPercentage;
    _healthPercentage = healthPercentage;
    _currentHealth = (long)(healthPercentage*_maxHealth);
    [self updateColor];
}

-(void)updateColor {
    health.colorBlendFactor = 1.0f;
    if (self.healthPercentage > 0.5f) {
        health.color = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
    } else if (self.healthPercentage > 0.15f) {
        health.color = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
    } else {
        health.color = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
    }
}

-(void)animateToHealth:(long)health_val withTime:(double)time_val {
    double f = (double)health_val/self.maxHealth;
    [self animateToPercentage:f withTime:time_val];
}

-(void)animateToPercentage:(double)percentage withTime:(double)time_val {
    if (self.animationTimer) {
        [self.animationTimer invalidate];
    }
    
    if (fabs(percentage-self.healthPercentage) > .01) {
        timerCount = 1;
        
        double increment = (percentage-self.healthPercentage)/50.0f;
        timeInterval = time_val/50.0f;
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(goToHealth:) userInfo:[NSNumber numberWithDouble:increment] repeats:YES];
    }
}

-(void)createNodeWithSize:(CGSize)size{
    self.animationTimer = nil;
    self.maxHealth = 100;
    self.currentHealth = 100;
    
    SKTexture *texture = [SKTexture textureWithImageNamed:@"roundedSquare.png"];
    CGRect center_rect = CGRectMake(4.0/28.0,4.0/28.0,20.0/28.0,20.0/28.0);
    
    xFactor = size.width/28.0f;
    yFactor = size.height/28.0f;
    
    background = [SKSpriteNode spriteNodeWithTexture:texture];
    background.centerRect = center_rect;
    background.anchorPoint = CGPointMake(0.0f, 0.5f);
    background.zPosition = 2;
    background.xScale = xFactor;
    background.yScale = yFactor;
    background.color = [SKColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1];
    background.colorBlendFactor = 1.0f;
    
    health = [SKSpriteNode spriteNodeWithTexture:texture];
    health.centerRect = center_rect;
    
    self.healthPercentage = 1.0f;
    health.anchorPoint = CGPointMake(0.0f, 0.5f);
    health.zPosition = 3;
    
    outline = [SKSpriteNode spriteNodeWithTexture:texture];
    outline.centerRect = center_rect;
    outline.anchorPoint = CGPointMake(0.5f, 0.5f);
    outline.position = CGPointMake(background.position.x+background.frame.size.width/2, background.position.y);
    outline.zPosition = 1;
    outline.xScale = xFactor*1.03;
    outline.yScale = ((outline.size.width-background.size.width)+background.size.height)/28.0f;
    outline.color = [SKColor grayColor];
    outline.colorBlendFactor = 1.0f;

    
    [self addChild:background];
    [self addChild:health];
    [self addChild:outline];
}

+(ASHealthBar *)initWithSize:(CGSize)size {
    ASHealthBar *healthBar = [ASHealthBar node];
    [healthBar createNodeWithSize:size];
    return healthBar;
}

@end
