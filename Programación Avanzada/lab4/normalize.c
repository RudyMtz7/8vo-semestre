/*----------------------------------------------------------------

*

* Programación avanzada: Normalización de archivos

* Fecha: 22-Feb-2019

* Autor: A01700309 Rodolfo Martínez Guevara

*

*--------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <pwd.h>
#include <grp.h>
#include <limits.h>

#define SIZE 1000
int values[SIZE];

void max_int(char *filename, char* program, float* p_max){
  FILE *file;
  int i, size,time, intersections;
  float num, max_value;

  max_value=*p_max;

  file= fopen(filename, "r");
  if(file==NULL){
    perror(program);
    exit(-1);
  }

  memset(values, 0, SIZE*sizeof(int));
  while(fscanf(file, "%i,%i", &time, &intersections) != EOF ){

    size = intersections * intersections;

    for(i=0; i<size; i++){
      fscanf(file, ",%f", &num);
      if(num > max_value){
        *p_max=num;
      }
    }
  }
  fclose(file);
}

void normalize(char *filename, char* new_filename, char* program, float max, float min){
  FILE *file;
  FILE *new_file;
  int i, size,time, intersections;
  float num, normalized_num;

  file= fopen(filename, "r");
  if(file==NULL){
    perror(program);
    exit(-1);
  }
  memset(values, 0, SIZE*sizeof(int));

  new_file= fopen(new_filename, "w+");
  if(file==NULL){
    perror(program);
    exit(-1);
  }

  memset(values, 0, SIZE*sizeof(int));

  while(fscanf(file, "%i,%i", &time, &intersections) != EOF ){

    fprintf(new_file, "%i,%i", time, intersections);
    size=intersections * intersections;

    for(i=0; i<size; i++){
      fscanf(file, ",%f", &num);
      normalized_num=(num-min)/(max-min);
      fprintf(new_file, ",%f", normalized_num);
    }

    fprintf(new_file, "\n");

  }

  fclose(new_file);

  fclose(file);
}

int main (int argc, char* argv[]){
    DIR* dir;
    DIR* new_dir;
    struct stat ss;
    struct dirent *dir_entry;
    float max=0, min=0;
    float* p_max;
    char directory_name[NAME_MAX+1], pathname[1024], new_filename[1024];
    char *directory;
    char* new_directory;

    if(argc != 3){
      fprintf(stderr, "usage: %s input_directory output_directory \n", argv[0]);
      return -1;
    }

    if((stat(argv[1], &ss)==-1) || (stat(argv[2], &ss)==-1)){
      fprintf(stderr, "%s: No such file or directory \n", argv[0]);
      return -1;
    }

    if(!S_ISDIR(ss.st_mode)){
          printf("Not a directory\n");
          return -1;
    }

    new_directory=argv[2];
    directory=argv[1];

    if( ( dir=opendir(directory) ) ==NULL ){
      printf("Error openning dir");
      exit(-1);
    }

    p_max=&max;

    while( (dir_entry=readdir(dir)) != NULL ){
        sprintf( pathname, "%s/%s", directory, dir_entry->d_name );

        if(strcmp(dir_entry->d_name, ".")==0 ||  strcmp(dir_entry->d_name, "..") == 0 ){
          continue;
        }

        max_int(pathname, argv[0], p_max);
    }

    rewinddir(dir);


    while( (dir_entry=readdir(dir)) != NULL ){

      sprintf( pathname, "%s/%s", directory, dir_entry->d_name );
      sprintf(new_filename, "%s/%s",new_directory,  dir_entry->d_name );

      if(strcmp(dir_entry->d_name, ".") == 0 ||  strcmp(dir_entry->d_name, "..") == 0 ){
        continue;
      }

      normalize(pathname, new_filename, argv[0], *p_max, min);
    }

    closedir(dir);

    printf("Done\n");

    return 0;
}
