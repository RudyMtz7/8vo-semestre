/*----------------------------------------------------------------
*
* Programación avanzada: Archivos y directorios
* Fecha: 12-Feb-2018
* Autor: Rodolfo Martínez Guevara
*
*--------------------------------------------------------------*/

#include <time.h>
#include <stdio.h>
#include <fcntl.h>
#include <ctype.h>
#include <dirent.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

void list(char *dir, char *search, int recursive, char *path){
  DIR *dir_p;

  struct dirent *direntry;
  struct stat statbuf;

  time_t lastMessage, lastAccess;

	struct tm* modificationTime;
  struct tm* accessTime;

	char modifictionDate[24], accessDate[24];

  int aux = 0;

  if((dir_p = opendir(dir)) == NULL){
      return;
  }

  chdir(dir);

  while((direntry = readdir(dir_p)) != NULL) {
    lstat(direntry->d_name,&statbuf);

    lastMessage = statbuf.st_mtime;
    lastAccess = statbuf.st_atime;

    modificationTime = localtime(&lastMessage);
    accessTime = localtime(&lastAccess);

    strftime(modifictionDate, 24, "%a %b %d %X %Y", modificationTime);
    strftime(accessDate, 24, "%a %b %d %X %Y", accessTime);


    if(S_ISDIR(statbuf.st_mode)){

      if(strcmp(".", direntry->d_name) == 0 || strcmp("..", direntry->d_name) == 0){
        continue;
      }

      if(strstr(direntry->d_name, search)){
        printf("Name: %s\n",direntry->d_name);
        printf("Path: %s\n", dir);
      	printf("Last Access: %s\n", accessDate);
        printf("Last Modification: %s\n", modifictionDate);
        printf("\n");
      }

      sprintf(path, "%s/%s", dir, direntry->d_name);
      if(recursive == 1){
        list(direntry->d_name, search, recursive, path);
      }
    }
    else{
      if(strstr(direntry->d_name, search)){
        printf("Name: %s\n", direntry->d_name);
        printf("Path: %s\n", dir);
      	printf("Last Access: %s\n", accessDate);
        printf("Last Modification: %s\n", modifictionDate);
        printf("\n");
      }
    }
  }
  chdir("..");
  closedir(dir_p);
}

int check_directory(const char* name){
  struct stat st;
  if(stat(name, &st) == -1){
    return -1;
  }
  return (int)((st.st_mode & S_IFDIR) == S_IFDIR);
}

int main(int argc, char* argv[]){
  int fd_in, fd_out;

  if(argc < 3 || argc > 4){
    printf("usage: %s str directory [-r]\n", argv[0]);
    return 0;
  }
  else{
    if((fd_in = open(argv[2], O_RDONLY)) < 0){
  		printf("%s: No such file or directory\n", argv[0]);
  		return -1;
  	}
    else{
      close(fd_in);
      if(!check_directory(argv[2])){
        printf("%s: Not a directory\n", argv[0]);
        return -1;
      }
    }
    if(argc == 4){
      if(strcmp(argv[3], "-r") != 0){
        printf("usage: %s str directory [-r]\n", argv[0]);
        return -1;
      }
      else{
        list(argv[2], argv[1], 1, argv[2]);
      }
    }else{
      list(argv[2], argv[1], 0, argv[2]);
    }
  }
}
