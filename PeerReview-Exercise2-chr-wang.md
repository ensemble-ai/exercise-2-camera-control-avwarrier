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

* *name:* Chris Wang
* *email:* cswang@ucdavis.edu

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

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
Camera controller is always focused on the `Vessel`. However, camera controller contains [unnecessary exported fields](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/position_lock.gd#L5-L6) that should be deleted. To follow, the [drawing function](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/position_lock.gd#L38-L41) should also be revised to not rely on these fields. Cross is correctly drawn when `draw_camera_logic` is set to true.

___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
Camera controller successfully autoscrolls and pushes the `Vessel` at the same time. `Vessel` remains inside the drawn box at all times. The camera includes the required fields.

Autoscroller does not start at the current position of the `Vessel`, instead starting at the center of the map the first time it is selected or its last position. This can be easily fixed by setting the position of the camera controller to the position of the `Vessel` [when the camera controller is not active](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/auto_scroll.gd#L16-L17).

Parts of the drawing function are [hard-coded values](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/auto_scroll.gd#L50-L60) rather than being based off the height and width of the `Vessel`. The change would ensure that the box would still look correct even if the size of the `Vessel` changes.

The [exported variables](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/auto_scroll.gd#L5-L7) should have default values to ensure that the script works even when the fields are not specified otherwise.

___
### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
Camera controller follows the `Vessel` at a slower rate and moves above the `Vessel` once it stops moving. Cross is correctly drawn when `draw_camera_logic` is set to true. The camera includes the required fields.

Similar to the autoscroller in Stage 2, the lerp camera controller does not start at the current position of the `Vessel`. Also, the [exported variables](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L5-L7) do not have default values.

The camera controller utilizes a [leash box](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L42) rather than a leash circle. The controller should compare the difference in distance in the x and y planes together, potentially by using the Pythagorean Theorem, rather than separately.

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [x] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
Camera controller usually leads the `Vessel` and moves above the `Vessel` once it stops moving with a short delay if a delay was not recently interrupted with movement. Cross is correctly drawn when `draw_camera_logic` is set to true. The camera includes the required fields.

Similar to the autoscroller in Stage 2, the lerp camera controller does not start at the current position of the `Vessel`. Also, the [exported variables](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L5-L8) do not have default values. Similar to the lerp camera controller in Stage 3, the this camera controller utilizes a [leash box](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L51).

When using the hyper boost, the camera controller instead follows the `Vessel`. This is due to `lead_speed` being a static value rather than a ratio of the speed of `Vessel`.

The camera controller movement back to above the `Vessel` is not delayed if the `Vessel` moves before the previous delay is completed. Rather than trying to [await a temporary timer](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L40-L43), there should be a private variable storing a timer that can be accessed at any time to accurately determine if the timer is currently running and reset it if interrupted by additional movement. Beyond that, the linked code includes two variables, `timer_running` and `waiting` that appear to serve the same purpose and can be merged into one.

Camera controller also does not properly adjust when the `Vessel` moves diagonally. The `Vessel` gets stuck to the leash box rather than sliding based on direction as expected and demonstrated in the lerp camera controller in Stage 3.

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
Camera controller mostly follows the description, following the `Vessel` slowly inside the speedup zone and acting like the push box controller when the `Vessel` touches the push box. Boxes are correctly drawn when `draw_camera_logic` is set to true. The camera includes the required fields.

Similar to the autoscroller in Stage 2, the lerp camera controller does not start at the current position of the `Vessel`. Also, the [exported variables](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/speedup_zone.gd#L5-L9) do not have default values.

The camera controller moves with the `Vessel` even when it moves away from the push box border. Using the [z-coordinate calculations](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/speedup_zone.gd#L37-L49) as an example, the `elif` should be separated based on whether the `Vessel` is in the top section of the speedup zone or the bottom section. Based on that, the controller can determine whether to move with the `Vessel` or not move if it moves away from the push box border.

___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
Many variables are not explicitly typed or use `:=` to demonstrate that the type is inferred. For example, five consecutive variable definitions are not typed in [lerp_target_focus.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L25-L36). Most of these can be fixed by using `:=` while the last variable should be explicitly typed as it is not immediately assigned a value from which a type could be inferred.

Not all functions are surrounded by two blank lines. For example, the function `_ready()` in [speedup_zone.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/speedup_zone.gd#L11-L15) does not have two blank lines above it.

Some comments do not include spaces between the `#` and the first character of the comment. For example, the comments in [lerp_smoothing.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L50-L61) describing the direction that the code section handles should have the extra space.

#### Style Guide Exemplars ####
All disabled code are correctly commented out by having no space between the `#` and the first character of the line of code. For example, this line in [lerp_smoothing.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L45) is correctly commented out.

The code order for all files are correct.

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
The program generates two errors. The first is caused by the variable `cpos` in [position_lock.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/position_lock.gd#L22), which is declared but never used. The other is caused by the variable `new_position` in [lerp_target_focus.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L36), which is similarly declared but not used. Both of these variables should be deleted to remove the errors.

`draw_camera_logic` is not set to true by default both in the [camera selector](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_selector.gd#L29) and [camera controller base](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/camera_controller_base.gd#L10) as is specified in the basic criteria. This would be an easy fix of changing these boolean settings to true.

Camera zoom in and zoom out does not work. I tried looking through the code and couldn't find the actual reason for this bug after comparing with my own, but I thought it was notable since the base code should have this function built in without any changing necessary.

The `Vessel` jitters for multiple camera controllers when it moves. This can be fixed by setting the maximum FPS of the game to 60 FPS.

Some public variables should be private. For example, the variable `inner` in [speedup_zone.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/speedup_zone.gd#L11) is an internal variable that only affects the calculations inside the script.

The code could include more comments. Some sections, like the border calculations in [auto_scroll.gd](https://github.com/ensemble-ai/exercise-2-camera-control-avwarrier/blob/3335c633fea72d13d4f8de36b192ef7e769b6690/Obscura/scripts/camera_controllers/auto_scroll.gd#L25-L33) are difficult to understand without comments describing what direction each `if-elif` block handles.

#### Best Practices Exemplars ####
