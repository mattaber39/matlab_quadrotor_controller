# README

## Description
This is the repository for Matt and Daniel's work from Project 1 Phase 1 [1]. Worked on both Geometric and Linear Controllers, as well as some trajectories like the Circle, Diamond and some new ones we wanted to test them out, the Epicycloid and Hipocycloid. Descriptions for how these work are inside the code itself.

## To Use:
1. Clone the repository:
  ```bash
  git clone https://github.com/mattaber39/matlab_quadrotor_controller
  cd matlab_quadrotor_controller
  git submodule update --init --recursive
  ```
  
2. Open the `runsim.m` file in Matlab, and edit the trajectory and controller handles to the ones that you want to use. Run the file. 

## Notes
* We didn't find any big differences between the Geometric and Linear controller, so feel free to try any of them. 
* If the time given to the drone to complete the trajectory is short, it will probably be less precise than if the period of time is longer, because it will have less time to adjust after every turn.

## References
\[1] All source code for running the simulation is taken from [Penn state's MEAM 620 course.](https://alliance.seas.upenn.edu/~meam620/wiki/index.php?n=Main.Projects)  
\[2] [Euler angle velocities article](https://phys.libretexts.org/Bookshelves/Classical_Mechanics/Book%3A_Classical_Mechanics_(Tatum)/4%3A_Rigid_Body_Rotation/4.02A_Angular_Velocity_and_Eulerian_Angles)  
\[3] [Moment of Inertia Tensor article](http://farside.ph.utexas.edu/teaching/336k/Newtonhtml/node64.html#rig)  
\[4] [Triple Cross Product article](http://www.fen.bilkent.edu.tr/~ercelebi/Ax(BxC).pdf)  
\[4] [Referenced paper](http://www-personal.acfr.usyd.edu.au/spns/cdm/papers/Mellinger.pdf)  
\[5] [Vee map reference](http://people.csail.mit.edu/jstraub/download/straubTransformationCookbook.pdf)  
