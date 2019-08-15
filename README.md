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
[1] https://alliance.seas.upenn.edu/~meam620/wiki/index.php?n=Main.Projects
