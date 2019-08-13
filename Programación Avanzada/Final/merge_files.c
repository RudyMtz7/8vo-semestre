/*----------------------------------------------------------------

*

* Programación avanzada: Exámen Final

* Fecha: 10 de mayo del 2019

* Autor: A01700309 Rodolfo Martínez Guevara

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

#define PATH_MAX  4096
#define NAME_MAX  255
#define SIZE      128

void get_info(char *name, char *directory, char* program) {
	int i;
	struct stat info;
	struct passwd *pw;
	struct group *gr;
	time_t rawtime;
	struct tm* timeinfo;
	char date[13];
	char permits[] = {'x', 'w', 'r'};
	char filename[PATH_MAX + NAME_MAX + 1];


	sprintf(filename, "%s/%s", directory, name);
	if (lstat(filename, &info) < 0) {
		perror(program);
		exit(-1);
	}

	printf("Working in: %s\n", filename);

	 switch (info.st_mode & S_IFMT) {
		case S_IFDIR:  printf("d");	break;
		case S_IFLNK:  printf("l"); break;
		default		:  printf("-"); break;
	}

	for (i = 0; i < 9; i++) {
		if (info.st_mode & (0400 >> i)) {
			printf("%c", permits[(8 - i) % 3]);
		} else {
			printf("-");
		}
	}

	printf(" %2li", info.st_nlink);

	rawtime = info.st_mtime;
	timeinfo = localtime(&rawtime);
	strftime(date, 13, "%b %d %R", timeinfo);
	printf(" %s", date);

	printf(" %s\n", name);
}

void recursive_f(char *directory, int recursive, char* program) {
	DIR* dir;
	struct dirent* direntry;
	struct stat info;
	char filename[PATH_MAX + NAME_MAX + 1];

	if ( (dir = opendir(directory)) == NULL ) {
		perror(program);
		exit(-1);
	}

	while ( (direntry = readdir(dir)) != NULL ) {
		if (strcmp(direntry->d_name, ".") != 0 &&
			strcmp(direntry->d_name, "..") != 0) {
			sprintf(filename, "%s/%s", directory, direntry->d_name);
			get_info(direntry->d_name, directory, program);
		}
	}

	rewinddir(dir);
	while ( (direntry = readdir(dir)) != NULL ) {
		if (strcmp(direntry->d_name, ".") != 0 &&
			strcmp(direntry->d_name, "..") != 0) {

			sprintf(filename, "%s/%s", directory, direntry->d_name);
			lstat(filename, &info);
			if (S_ISDIR(info.st_mode)) {
				recursive_f(filename, recursive, program);
			}
		}
	}
	printf("\n");
}

int main(int argc, char *argv[]){
  int fd_in, fd_out;
  float num;
  char *directory;
  int recursive;

	if (argc != 4) {
		printf("usage: %s merge_file directory max_level\n",argv[0]);
		return -1;
	}

  num = atof(argv[3]);

  if (num < 1 || num != (int)num) {
    printf("%s: the max level must be a positive integer number greater than 1\n", argv[0]);
    return -1;
  }


	if ( (fd_in = open(argv[1], O_RDONLY)) < 0 ) {
		perror(argv[0]);
		return -1;
	}

  recursive = 1;
	directory = argv[2];


	unsigned char buffer;
	ssize_t nbytes;
	int i,p;

  recursive_f(directory, recursive, argv[0]);

	close(fd_in);
	close(fd_out);
	return 0;
}
