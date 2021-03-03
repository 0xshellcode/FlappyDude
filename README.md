# Flappy Dude

Modified implementation of a Flappy Bird-style game,

## Some Important things

### Audio, Images & Fonts

Regarding the resources used for this project, all of them have the constant that they are loaded from the `mail.lua` file (with the exception of the images of the Dude and the pipes), that is to say we must specify the PATH from where these files must be obtained, so that later the Love2D engine can convert them to an object and finally it can handle them.

### The parallax update.

Refers to how 2 objects give the illusion that one is farther away and the other closer thanks to how much closer they are, in this case is what we want to achieve with the floor and the pipes and the mountains behind. In orther to achieve this effect we must create a local variable that allows us to assign a speed to our images to achieve the parallax effect, in this case if what we want is that the near object moves faster then we have to assign a greater value to it, while to the one that passes slower a smaller value. 
the background looping will allow us to make the effect of an infinite background. 

In addition, to be able to update the speed, we will use the variable delta time, which will increase with time and will be multiplied with the values we have already assigned, finally, if the looping does not coincide and we do not calculate it in the correct way what we will cause is that our back image will be cut off.

### Gravity

To be able to simulate the gravity in a 2d game we have to use again delta time that is going to be increasing as the time passes, achieving the effect that really happens with the gravity that the things are falling faster and faster. 

First we have to go to the Dude class to be able to define the value of the gravity that we are going to use. 
in that place we go to the Dude:update(dt) 
where we see the gravity constant which was the value we gave multiplied by delta time and added with the same velocity of the object. 

Once we have gravity we must look for the effect of the jump.
for that it will be necessary 
in the Dude class we must place a negative constant that will make us rise giving the jump effect, and we must define the function that will allow us to know if a key was pressed and if that key coincides with the one that we configured to activate the conditional to jump. 

### Infinite Pipes

Now to achieve the effect of the infinite pipes what we will do, what we put in the pipe class is to mention that it is going to be created in the virtual window which means that for the user it will not be perceptible yet, but when he enters the window it will already be visible, this is important to understand it because it is precisely what is used to give the illusion that it is infinite, it is to use the virtual to create things and then that they are already seen in the window. 

To be able to make that it is creating followed the pipes we use the spawnTimer and we conditioned it to that if it was greater to 2 then that it would create a new pipe. and well obviously we have to return its value to 0 so that it restarts the count.

## State Machine

In our machine state we can see that the first state is when we are waiting for the user to press the Space key to start the movement effect and the objects that we must avoid are generated, this state is known as Playstate, in which we create the illusion that the frog jumps to avoid colliding with the buildings, finally when we collide with one of these objects, it will mark our Score achieved in this game and the cycle will restart again waiting for the key to be pressed to start playing again.

![Alt text](FlappyDude.jpg?raw=true "Flappy Dude")

## Resources Used

- For Music

    - http://drpetter.se/project_sfxr.html

- For Graphics

    - https://www.dafont.com/es/search.php?q=cyberpunk
    - https://www.piskelapp.com/
    - https://www.deviantart.com/jecksfox/art/it-is-wednesday-my-dudes-829944162

- Mentoring:

    - Colton Ogden & David J. Malan. (2021). Games50/fifty-bird (Versión 12) [Lua; Multiplatform LÖVE2D]. CS50’s Introduction to Game Development. https://github.com/games50/fifty-bird 
    - (Original work published 2018) freeCodeCamp.org. (2019). Flappy Bird (with Lua) (Vol. 2) [YouTube Video]. CS50. https://www.youtube.com/watch?v=rBHusPevM5k
