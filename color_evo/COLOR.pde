// class COLOR representing an individual


class COLOR{
  int[] rgb = new int[3];
  float fitness;
  
  //constructor
  
  COLOR(){
    
    // create a random genotype
    for(int i=0;i<rgb.length;i++){
      rgb[i] = int(random(255));
    }
  }
  
  // fitness is the inverse of the Manhattan distance between the target genotype and the individual genotype
  void fitness(COLOR target_color){
    float distance;
    distance = abs(target_color.rgb[0] - rgb[0]) + abs(target_color.rgb[1] - rgb[1]) + abs(target_color.rgb[2] - rgb[2]);
    fitness = 1/(distance+1);
  }
  
  // crossover function, selects for each gene, one of the parents' at random
  COLOR crossover(COLOR partner){
   COLOR child = new COLOR();
   for(int j=0;j<3;j++){
     float rand = int(random(2));
     if(rand==0){
       child.rgb[j] = rgb[j];
     }
     else{
      child.rgb[j] = partner.rgb[j]; 
     }
   }
   return child;
  }
  
  // mutation function: with probability p_mutation, selects one of the genes and apply Gaussian noise to its value.
  void mutation(float p_mutation, float sigma){
   float rand = random(1);
   if(rand<p_mutation){
     float rand2 = random(3);
     rgb[int(rand2)] = rgb[int(rand2)] + int(randomGaussian()*sigma);
     // bounds to 0-255
     if(rgb[int(rand2)]>255){
       rgb[int(rand2)]=255;
     }
     if(rgb[int(rand2)]<0){
       rgb[int(rand2)]=0;
     }
   }
  }
  
}