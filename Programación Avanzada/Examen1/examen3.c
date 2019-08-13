#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <pwd.h>
#include <grp.h>
#include <limits.h>


void list(char *directory,char *word){
  FILE * f;
  char filename[NAME_MAX+1];
  char line[160];
  struct dirent *dir_entry; //estructura para recorer los directorios
  DIR *dir; //estuctura usada para abrir el archivo
  struct stat ss;



  //abro el directorio
  if( ( dir=opendir(directory) ) ==NULL ){ //el directorio no existe o no tengo permiso de verlo
    fprintf(stderr, "No tienes permiso de leer este directorio:%s \n", directory);
    exit(-1);
  }


  while( (dir_entry=readdir(dir)) != NULL ){
    if(strcmp(dir_entry->d_name, ".")==0 ||  strcmp(dir_entry->d_name, "..") == 0 ){
      continue; //no lo peles, son mis casos especiales
    }
    sprintf(filename, "%s/%s", directory, dir_entry->d_name);

     f=fopen(filename,"r");



      while (fgets(line, sizeof(line), f)) {
          if (strstr(line, word) != NULL) {
              printf("%s\n",filename);
              break;
          }
      }
     fclose(f);

     sprintf(filename, "%s/%s", directory, dir_entry->d_name);
     stat(filename, &ss);
     if(S_ISDIR(ss.st_mode)){
       printf("\n%s: \n", filename);
       list (filename,word);
     }

  }

}


int main(int argc, char* argv[]){
  struct stat ss;
  char *directory;
  char filename[NAME_MAX+1];
  char* word;

//numero de argumentos es incorrecto
  if (argc < 2|| argc > 3){
    fprintf(stderr, "Forma de uso: %s palabra [directorio] \n", argv[0]);
    return -1;
  }


  //se puso un directorio como parametro
  if(argc==3){

    sprintf(filename, "./%s", argv[2]);

    //no existe ningun directorio ni archivo que se llame así
    if(stat(filename, &ss)==-1){ //devuelve la info administrativa del archivo
      fprintf(stderr, "%s debe existir y debe ser un directorio \n", argv[2]);
      return -1;
    }


    //Existe un archivo llamado así pero no es un directorio
    if(!S_ISDIR(ss.st_mode)){
          printf("El segundo argumento debe ser un directorio\n");
          return -1;
    }

    word=argv[1];
    directory=argv[2];
    printf("./%s: \n\n", directory);

}

  else{
    word=argv[1];
    directory="./";
    printf("./: \n\n");

  }



  list(directory, word);


}
