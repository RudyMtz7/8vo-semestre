//Dr. Profesor Rodolfo Martínez Guevara
//A01700309

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

int copy_file(char *file, char *directory){

  int fd_in, fd_out;
  char buffer[128];
	ssize_t nbytes;

  if ( (fd_in = open(file, O_RDONLY)) < 0 ) {
		perror(file);
		return -1;
	}

  strcpy(directory,file);

	if ( (fd_out = open(directory, O_WRONLY | O_TRUNC | O_CREAT, 0666)) < 0 ) {
		perror(file);
		return -1;
	}

	while ( (nbytes = read(fd_in, buffer, 128)) != 0 ) {
    write(fd_out, buffer, nbytes);
	}

	close(fd_in);
	close(fd_out);

  return 1;
}


int is_dir(const char* name){
    struct stat st;
    if (-1 == stat(name, &st)) {
      return -1;
    }
    return (int)((st.st_mode & S_IFDIR) == S_IFDIR);
}

void list(char *directory, char *lesser, char *greater, long var_n, char *program) {
 char filename[300 + 1];
 DIR *dir;
 struct dirent *dir_entry;
 struct stat ss;
 long fileSize;

 if ( (dir = opendir(directory)) == NULL ) {
   perror(program);
   exit(-1);
 }


 while ( (dir_entry = readdir(dir)) != NULL ) {
   if (strcmp(dir_entry->d_name, ".") == 0 ||
     strcmp(dir_entry->d_name, "..")  == 0) {
     continue;
   }
   sprintf(filename, "%s/%s" , directory, dir_entry->d_name);
   lstat(filename, &ss);
   if (S_ISREG(ss.st_mode)) {
     fileSize = ss.st_size;
     printf("%ld\n",fileSize);
     if (fileSize < var_n) {
       printf("Lesser\n");
       // copy_file(, lesser);
     }else{
       printf("Greater\n");
       // copy_file(, greater);
     }
   }
 }
 printf("\n");

 rewinddir(dir);
 while ( (dir_entry = readdir(dir)) != NULL ) {
   if (strcmp(dir_entry->d_name, ".") == 0 ||
     strcmp(dir_entry->d_name, "..")  == 0) {
     continue;
   }
   sprintf(filename, "%s/%s", directory, dir_entry->d_name);
   lstat(filename, &ss);
   if (S_ISDIR(ss.st_mode)) {
     list(filename, lesser, greater, var_n,program);
   }
 }
 closedir(dir);
}

int main(int argc, char* argv[]){
  int bas, less, gt;
  int var_n = atoi(argv[4]);
  char *base, *lesser, *greater;
  base =  argv[1];
  lesser = argv[2];
  greater = argv[3];

  if (argc != 5){
    printf("usage: ./split base lesser greater N\n");
    return 0;
  } else if(var_n < 1) {
      printf("N must be a positive number greater than zero.\n");
  } else {
    if ( (bas = open(argv[1], O_RDONLY)) < 0 || (less = open(argv[1], O_RDONLY)) < 0 || (gt = open(argv[1], O_RDONLY)) < 0) {
  		printf("./split: No such file or directory\n");
  		return -1;
  	} else{
      close(bas);
      close(less);
      close(gt);

      if(!is_dir(argv[1]) || !is_dir(argv[2]) || !is_dir(argv[3])){
        printf("./split: Not a directory\n");
        return -1;
      }

    }
  }

  list(base, lesser, greater, var_n, argv[0]);
  return 0;
}
