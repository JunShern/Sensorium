# Sensorium

![Wall gif](https://github.com/JunShern/Sensorium/blob/master/Pictures/IMG_5984%2000_00_00-00_00_13.gif?raw=true "Wall gif")

A collaborative tech/art installation by the Imperial College Advanced Hackspace and Dyson School of Design Engineering, on display at the Imperial Festival 2016. 

Watch the making-of [video](https://www.youtube.com/watch?v=WoExhnElK3E)!

##How It Works

High-level details can be seen from the diagram below:

![Tech overview](https://github.com/JunShern/Sensorium/blob/master/Pictures/Sensorium%20LED%20Screen%20Overview.png?raw=true "Tech overview")

###Image Capture and Processing

Two Microsoft Kinects, one for each half of the wall, were used to get images of the scene in front of the wall. These images were then fed into [Processing](https://processing.org/ "Processing"), which was the main workhorse for the project. 

Using depth information from the Kinects, any images further than 3m from the wall were filtered out so that only the images of people directly in front of the wall would be retained. Then, a Canny Edge Detector was used to obtain the final silhouttes sent to the LED display.

###LED Wall Display

![Bare boards](https://github.com/JunShern/Sensorium/blob/master/Pictures/IMG_5950.JPG?raw=true "Bare boards")

##Pictures

![Little girl](https://github.com/JunShern/Sensorium/blob/master/Pictures/DSC_0563.gif?raw=true "Little girl")

![Wall with people](https://github.com/JunShern/Sensorium/blob/master/Pictures/IMG_1588.JPG?raw=true "Wall with people")


##The Team
Find out more about the team behind this project [here](http://icah.org.uk/sensorium/team.html)!
