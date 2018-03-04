//
// Evolution of colors towards a random target. A simple genetic algorithm is implemented.
// An individual is charaterized by its genotype (RGB values between 0 and 255) and expresses a phenotype (the corresponding color).
// The fitness function is the inverse of the Manhattan distance between the individual RGB genotype and the target RGB.
// Each individual has a probability to reproduce that is proportional to its fitness.
// A child is made out of two different parents, and each of its genes is randomly selected from one of its two parents.
// A mutation occurs on a child genes with probability of p_mutation. If it occurs, one gene is selected and a gaussian noise of 
// power sigma is added to its value.
//
// The drawing represents one generation per line, one individual per box. The bottom color is the target. It changes every 81 generations.
//
// Author: Cédric Colas
// Email: cdric.colas@gmail.com
//

int nb_gen = 80; //number of generations
int size_gen = 20; //number of individuals in a generation
float p_mutation = 0.3; //mutation probability of a child
int sigma = 30; //power of the mutation (std of the added Gaussian noise)
COLOR target_color = new COLOR();

COLOR[] parents = new COLOR[size_gen];
COLOR[] childs = new COLOR[size_gen];
float[] fitness_parents = new float[size_gen];
float[] cumulated_probabilities = new float[size_gen];
int x; // tracks the x position on the canvas
int x_step;
int y; // tracks the y position on the canvas
int y_step;


void setup(){
  
  size(1000,600);
  x_step = int(width/size_gen);
  y_step = int(height/(nb_gen+3));
  x = 0;
  y = 0;
  int[] colors = target_color.rgb;
  fill(colors[0],colors[1],colors[2]);
  rect (x, height-3*y_step, width,3*y_step);
  y = 0;
  
  // creates the first generation at random
  for (int i=0; i<size_gen; i++){
    parents[i] = new COLOR();
  }
}



void draw(){

  if(y>(height-3*y_step)){
    target_color = new COLOR();
    fill(target_color.rgb[0], target_color.rgb[1],target_color.rgb[2]);
    rect (x, height-3*y_step, width,3*y_step);
    y = 0;
  }
  
  // draw generation
  for (int i=0; i<size_gen; i++){
    fill(parents[i].rgb[0], parents[i].rgb[1], parents[i].rgb[2]);
    rect (x, y, x_step, y_step);
    x= x+x_step;
  }
  x=0;
  y=y+y_step;
  
  // evaluates fitness
  for (int i=0; i<size_gen; i++) {
    parents[i].fitness(target_color);
    fitness_parents[i]= parents[i].fitness;
  }
  
  // compute probability to be parent
  float sum = 0;
  for(int i=0;i<size_gen;i++){
   sum=sum+fitness_parents[i]; 
  }
  float sum_p=0;
  for(int i=0;i<size_gen;i++){
   fitness_parents[i]=fitness_parents[i]/sum; 
   sum_p=sum_p+fitness_parents[i];
   cumulated_probabilities[i] = sum_p;
  }  

  // create the childs
  float rand;
  int a = 0;
  int b;
  for(int i=0;i<size_gen;i++){
   rand = random(1);
   for(int j=0;j<size_gen;j++){
    if(rand<cumulated_probabilities[j]){
      a=j;
      break;
    }
   }
   b=a;
   while(a==b){
     rand = random(1);
     for(int j=0;j<size_gen;j++){
      if(rand<cumulated_probabilities[j]){
        b=j;
        break;
      }
     }
   }
   COLOR parentA = parents[a];
   COLOR parentB = parents[b];
   childs[i] = parentA.crossover(parentB);
  }
  
  // mutate childs
  for(int i=0;i<size_gen;i++){
   childs[i].mutation(p_mutation, sigma); 
  }
  parents=childs;
  
  // insert small delay
  int start = millis();
  while (millis()-start<100){
    
  }  
}