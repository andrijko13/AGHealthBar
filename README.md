# AGHealthBar
Objective-C Health Bar class to be used with Apple's iOS SpriteKit library.

##Usage:

Using the class is simple. After opening up a SpriteKit project, follow these steps to get a health bar up and running:

```Objective-C
// put `ASHealthBar *healthBar;` in the class interface
double half_height = [UIScreen mainScreen].bounds.size.height/2;
self.healthBar = [ASHealthBar initWithSize:CGSizeMake(130, 10)];
self.healthBar.position = CGPointMake(0, half_height-10);
self.healthBar.zPosition = 2000;
self.healthBar.maxHealth = 100;
self.healthBar.currentHealth = 100;
[self addChild:self.healthBar];
```

This will set up a health bar, to use it with fancy animations:

```Objective-C
// Put this in the update loop, where healthBar is a class variable
// This will animate the healthBar up and down!
if (self.healthBar.currentHealth == 0) [healthBar animateToPercentage:1.0f withTime:1.0f];
else if (self.healthBar.currentHealth == 100) [healthBar animateToPercentage:0.0f withTime:2.0f];
```

You can also just set the health to a certain percentage or value:
```Objective-C
[self.healthBar setCurrentHealth: 50];
[self.healthBar updateColor];
```
