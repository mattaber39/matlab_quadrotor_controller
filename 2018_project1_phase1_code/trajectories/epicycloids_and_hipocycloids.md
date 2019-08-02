# What are the Epicycloids and Hipocycloids?

Epicycloids and Hipocycloids are very fun to work with, they are parametric functions that can make figures that resemble flowers and stars, respectively. They are made by having a fixed circle _G_ with some radius _a_ and rolling around it another circle _D_ with radius _b_. If we trace the trajectory that some point P in the _D_ circle has, it will create an Epicycloid if _D_ is outside _G_, or a Hipocycloid if _D_ is inside the circle _G_.

The equations for these figures are shown next.

## Epicycloids
x = (a+b)cos((p)t)  -  (b)cos(p((a+b)/b)t)

y = (a+b)sin((p)t)  -  (b)sin(p((a+b)/b)t)

## Hipocycloids
x = (a-b)cos((p)t)  +  (b)cos(p*((b-a)/b)t)

y = (a-b)sin((p)t)  +  (b)sin(p((b-a)/b)t)

## Explanation
The period of a Cos and Sin function is 2pi if the argument is (t). If the want the period to last 80 seconds, for example, we divide 2pi/80 and we will multiply this by the argument inside the function. This lets you know how much time you need to complete one rotation, but this doesn't mean the figure will be complete after this.

The time to complete the figure depends on the characteristics of the radius _a_ and _b_. To simplify things up, _a_ is going to tell you how many "corners" the figure is going to have, while _b_ shows in how many rotations do you need to complete the figure.

For example, if you have _a = 7_ and _b = 3_, you will have 7 corners and you will need 3 rotations to finish the figure, this means that if your period is 40 seconds, after 120 seconds the figure will be completed.

Play around with the values to see what amazing figures you can make!
