# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* [WengZixuan] 
* *email:* [zxweng@ucdavis.edu]

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera is correctly centered on vessel at any speed.  
Controller correctly draw a 5 by 5 unit cross in the center of the screen when draw_camera_logic is true.

___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera do scroll on the direction of auto scroll speed. However, the student simply add velocity on the global-position without multiply delta, which cause the actual speed to be extramely fast.  
The zoomin and zoomout do not work.  
Controller correctly draw the square when draw_camera_logic is true, but is not at the center of screen. 

___
### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera follows the vessel with slower velocity, and catchup vessel when vessel stop. However, the export speed variable is measured in strange way, the actual velocity is much faster than the input.  
The vessel tremble obviously when move at diagonal direction.  
The vessel is restrict by a leash square instead of leash circle.  
Controller correctly draw the cross in the center of the screen when draw_camera_logic is true.  
The zoomin and zoomout do not work.  

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera moves faster than the vessel at lead_speed and catchup vessel when vessel stop. However, sometimes the camera catchup vessel without delay, and the export CatchupSpeed and LeashDistance is strange.  
The vessel tremble obviously when moving. The zoomin and zoomout do not work.  The vessel is restrict by a leash square instead of leash circle.  
Controller correctly draw the cross in the center of the screen when draw_camera_logic is true.  


___
### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera moving logic works correct. Camera don't move when vessel is inside speedup zone. Camera move at the push_ratio * velocity of vessel when vessel is inside speedup zone. Camera move at direction of reaching push box with the speed of vessel.  
The vessel tremble obviously when moving. The zoomin and zoomout do not work.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

#### Style Guide Exemplars ####

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

#### Best Practices Exemplars ####
