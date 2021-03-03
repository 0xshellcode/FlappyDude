# Flappy Dude

Modified implementation of a Flappy Bird-style game,

## Some Important things

### Audio, Images & Fonts

Regarding the resources used for this project, all of them have the constant that they are loaded from the `mail.lua` file (with the exception of the images of the Dude and the pipes), that is to say we must specify the PATH from where these files must be obtained, so that later the Love2D engine can convert them to an object and finally it can handle them.

### The parallax update.

The Parallax update refers to how we manage to create an optical effect that an object is closer than another using the speed of movement, something similar to what happens when we are on the road and we see the cars next to us approaching and moving away very quickly while the mountains seem to be moving very slowly.

To achieve this effect we must create local variables for each of the objects with which we want to simulate this reaction, with these variables what we will do is to select an integer that symbolizes the speed at which we are going to move it. 

To make an object appear to be very far away we must make it move slower than the other objects that we want to simulate proximity.
In the particular case of our video game, the objects that seem closer are the buildings that we have to dodge, therefore in the constant that we select and that we will later use is composed of a lower number than the one we give to the speed of our object that we want to seem farther away, in this case the sky and other buildings.

### Infinite Path

Another of the effects that we want to simulate in our video game is that of an infinite path, which we will achieve using a background with a beginning and end that allows an indefinite continuation, so that the effect is adequate we calculate the measures of the window and the virtual, because depending on these dimensions we will make that fits to the perfection the length of our background so that the cut of the image of behind is not noticed. 

The method that will allow us to do this is called background looping. 
Once we have the speed values of our background and ground we will use a variable that will allow us to increase the speed progressively, this variable will be used whenever we want to increase the speed of the game, both background and ground, as well as the speed of our flying frog. The variable we mention is "deltaTime" (dt).


### Gravity

As we have to make our little flying frog fall as he goes, unless we press the key to make him jump, we are going to simulate gravity in the game. Previously we mentioned that dt was going to serve us also for this purpose, so we will use a new class for frog in which once we have defined our gravity constant we will make it multiply with the value of speed that we already had in the frog object and later we will multiply it by the dt. All this is observed in the method Dude:update(dt). 


### Jumping

For the jumping effect that our frog object will have, we will use the same components for the gravity simulation, only that in the frog class we will assign a negative constant so that it goes in the opposite direction of where it goes with gravity.

To activate this jump function that will have our frog object we have to allow the reading of the pressure of our keys, because usually only a certain number of keys are those that have a functionality within the game, in our case it is the "Space" key that will activate the jump function, otherwise our frog will continue to fall waiting for activation to dodge the buildings. In the case that our frog collides with any of the buildings or falls to the ground, we must make the game end and the speeds of the background and ground, as well as those of the buildings and our frog are paralyzed, to achieve this we use a Boolean in a Scrolling function that will identify if the frog has fulfilled any of the conditions that we determine to lose. 

### Infinite Pipes

The effect of the infinite buildings will be achieved taking into account that the window and the virtual are 2 different things. The window is what the player will be able to see, while the virtual is what exists in our game universe but not necessarily seen by the user, generally this area is called "DeadZone". What we will do is to use the dimensions of the virtual to create the objects of the buildings, the background and the ground although the player cannot see them yet, then all these objects that were initially created in the virtual area will already be visible when they reach the window, which is the place that the player will be able to see. 

As our memory is limited, we have to try to reduce as much as possible the resources and objects stored and running in our game. Therefore we will make use of a function that deletes all the objects that are in the "DeadZone".

To create the building objects, we will first make objects subject to other objects, because as we can see in the game, each point is composed of 2 buildings, one below and one above. For this composite object to be created the first thing we did was the SpawnTimer helper, which is composed of a conditional that says that if the number is greater than 2 then a new composite object must be created in a random place on the right side of the virtual one. When the composite object is created we must reset the count so that a space between buildings is respected.

### Game Over and Game Restarting

The recognition of the loss of the frog is achieved with a box generally called "collider" in which we will give it some values that mean its dimensions, and in the case that this collider has contact with the buildings, we will activate the Scrolling method previously mentioned to stop the game.

## State Machine

In our machine state we can see that the first state is when we are waiting for the user to press the Space key to start the movement effect and the objects that we must avoid are generated, this state is known as Playstate, in which we create the illusion that the frog jumps to avoid colliding with the buildings, finally when we collide with one of these objects, it will mark our Score achieved in this game and the cycle will restart again waiting for the key to be pressed to start playing again.

![Alt text](FlappyDude.png?raw=true "Flappy Dude")

## Resources Used

- For Music

    - http://drpetter.se/project_sfxr.html

- For Graphics

    - https://www.dafont.com/es/search.php?q=cyberpunk
    - https://www.piskelapp.com/
    - https://www.deviantart.com/jecksfox/art/it-is-wednesday-my-dudes-829944162
    - http://angusj.com/resourcehacker/

- Mentoring:

    - Colton Ogden & David J. Malan. (2021). Games50/fifty-bird (Versión 12) [Lua; Multiplatform LÖVE2D]. CS50’s Introduction to Game Development. https://github.com/games50/fifty-bird 
    - (Original work published 2018) freeCodeCamp.org. (2019). Flappy Bird (with Lua) (Vol. 2) [YouTube Video]. CS50. https://www.youtube.com/watch?v=rBHusPevM5k
