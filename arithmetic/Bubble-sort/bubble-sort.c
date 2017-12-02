/* TODO: Bubble sort */

#include <stdio.h>

#define success 0
#define failure 1
static void _swap (int * n , int * m);
int bubble_sort_v1 (int * array, int len);

//int mian (int argc, char ** argv){
int main (void){

  #define LEN 10
  int array[LEN] = {
    10,20,30,11,33,
    11,99,78,33,23
  };
  int k=0;

  bubble_sort_v1(array, LEN);

  printf("Sort after:");
  for (k=0; k<LEN; k++)
    printf("%d ", array[k]);
  printf("\n");

  return success;
}

static void _swap (int * n , int * m){
  int temp;
  temp = *m;
  *m = *n;
  *n = temp;
}

int bubble_sort_v1 (int * array, int len){
  int i, j;
  if (len <= 0) return failure ;

  for (i=0; i< len ; i ++)
    for (j=1; j < len -i ; j++)
      if (array[j-1] > array[j])
        _swap(&array[j-1], &array[j]);

  return success;
}
