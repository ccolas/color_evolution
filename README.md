# color_evolution
Processing code to evolve colors towards random RGB targets using a simple genetic algorithm

The drawing represents one generation per line, one individual per box. The bottom color is the target.
It changes every n generations.

An individual is charaterized by its genotype (RGB values between 0 and 255) and expresses a phenotype (the corresponding color).
The fitness function is the inverse of the Manhattan distance between the individual RGB genotype and the target RGB.
Each individual has a probability to reproduce that is proportional to its fitness.
A child is created from two different parents, and each of its genes is randomly selected from one parent or the other.
A mutation occurs on a child genes with a probability p_mutation. If it occurs, one gene is selected and a Gaussian noise of 
power sigma is added to its value.

The html_version.html file allows to print the result in a html page using Processing.js.

This work is inspired by some parts of The Nature of Code, freely accessible here: http://natureofcode.com/book/

Learn more on [my blog](https://cedriccolas.com/project/chromatic_cartography)

Author: Cédric Colas

Email: cdric.colas@gmail.com
