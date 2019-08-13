#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <time.h>
#include <pwd.h>
#include <grp.h>
#include <sys/stat.h>
#include <dirent.h>
#include <string.h>
#include <fcntl.h>
#include <limits.h>

long list(char *path, char *directory, char* program) {
	DIR* dir;
	struct dirent* direntry;
	struct stat info;

	char filename[PATH_MAX + NAME_MAX + 1];
	char pathcomplete[PATH_MAX + NAME_MAX + 1];
	
	if ( (dir = opendir(directory)) == NULL ) {
		perror(program);
		exit(-1);
	}

	long acum = 0;
	int count = 0;
	
	while ((direntry = readdir(dir)) != NULL)
	{
		if (strcmp(direntry->d_name, ".") != 0 && strcmp(direntry->d_name, "..") != 0)
		{
			sprintf(filename, "%s/%s", directory, direntry->d_name);
			sprintf(pathcomplete, "%s/%s", path, filename);

			lstat(filename, &info);

			if (S_ISDIR(info.st_mode))
			{
				acum += list(path, filename, program);
			}
		}
	}

	rewinddir(dir);

	long val, min, max;
	min = INT_MAX;
	max = INT_MIN;

	printf("Directory: %s\n", directory);
	while ((direntry = readdir(dir)) != NULL)
	{
		if (strcmp(direntry->d_name, ".") != 0 && strcmp(direntry->d_name, "..") != 0)
		{
			sprintf(filename, "%s/%s", directory, direntry->d_name);
			lstat(filename, &info);

			if (!S_ISDIR(info.st_mode))
			{
				val = info.st_size;

				if (val < min)
				{
					min = val;
				}	
				
				if (val > max)
				{
					max = val;
				}

				acum += info.st_size;
				count++;
			}
		}
		
	}
	
	printf("Occupied space: %li Total files:%i\nMin size: %li Max size: %li\n", acum, count, min, max);
	printf("\n");
	return acum;
}

int main(int argc, char* argv[]) {
	char path[NAME_MAX + 1];
	char *directory;
	int recursive;
	long temp = 0;
	
	if (argc != 2) {
		printf("usage: %s directory\n", argv[0]);
		return -1;
	}
	
	directory = argv[1];

	getcwd(path, NAME_MAX);

	temp = list(path, directory, argv[0]);

	return 0;
}

