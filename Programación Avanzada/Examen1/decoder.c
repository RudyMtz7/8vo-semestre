#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> //incluye a getcwd que obtiene el nombre del actual directorio de trabajo
#include <string.h>
#include <fcntl.h>//inlcuye las funciones para abrir archivos
#include <sys/types.h> //constantes
#include <dirent.h> //dir open dir, contiene la funcion opendir
#include <sys/stat.h> //Contiene todas las funciones stat
#include <time.h> //Contiene funciones de conversion de tiempo
#include <pwd.h> // Tiene la funcion pwd sirve para sacar info del usuario al que pertenece el archivo
#include <grp.h> // Tiene la funcion que sirve para sacar info del grupo al que pertenece el archivo

void info(char *archivo, char *programa) {
    char permisos[] = {'x', 'w', 'r'};
    char fecha[13];
    struct stat buf;
    struct passwd *pw;
    struct group *gr;
    int i;
    time_t rawtime;
    struct tm *timeinfo;
    
    if (stat(archivo, &buf) == -1) {
        perror(programa);
        exit(-1);
    }
    /*
    if ((buf.st_mode & S_IFMT) == S_IFDIR) {
        printf("d");
    } else {
        printf("-");
    }

    for (i = 0; i < 9; i++) {
        if (buf.st_mode & (0400 >> i)) {
            printf("%c", permisos[(8 - i) % 3]);
        } else {
            printf("-");
        }
    }*/
    
    //printf(" %2li", buf.st_nlink);
    /*
    if ((pw = getpwuid(buf.st_uid)) == NULL) {
        printf(" ???????");
    } else {
        printf(" %8s", pw->pw_name);
    }
    
    if ((gr = getgrgid(buf.st_gid)) == NULL) {
        printf(" ????????");
    } else {
        printf(" %8s", gr->gr_name);
    }*/
    
    //printf(" %7li", buf.st_size);
    
    rawtime = buf.st_mtime;
    timeinfo = localtime( &rawtime );
    strftime(fecha, 13, "%b %d %R", timeinfo);
    //printf(" %s", fecha);
    
    printf(" %s\n", archivo);
}

void listar(char* directorio, char* programa, int recursivo) {
    char archivo[NAME_MAX + 1];
    DIR* dir;
    struct dirent* direntry;
    struct stat buf;
    
    if ( (dir = opendir(directorio)) == NULL ) {
        perror(programa);
        exit(-1);
    }
    
    printf("DIRECTORY = %s\n", directorio);
    while ( (direntry = readdir(dir)) != NULL ) {
        if (strcmp(direntry->d_name, ".") != 0 &&
            strcmp(direntry->d_name, "..") != 0) {
        
            sprintf(archivo, "%s/%s", directorio, direntry->d_name);
            info(archivo, programa);
            //printf("\n%s\n", archivo);
        }
    }
    rewinddir(dir);
    while ( (direntry = readdir(dir)) != NULL ) {
        if (strcmp(direntry->d_name, ".") != 0 &&
            strcmp(direntry->d_name, "..") != 0) {
        
            sprintf(archivo, "%s/%s", directorio, direntry->d_name);
            printf("%s\n", archivo);
            stat(archivo, &buf);
            if (recursivo && S_ISDIR(buf.st_mode)) {
                listar(archivo, programa, recursivo);
            }
            
        }
    }
}

int main(int argc, char*  argv[]){
    int num = atoi(argv[1]);
    char dir_name[NAME_MAX + 1];
    char* directory;
    char* directorio;
    int recursivo = 0;
    if (argc > 3 ){
        printf("usage: %s number [directory] \n",argv[0]);
        return -1;
    }
    if(num < 0){
        printf("%s: The number must be a positive number greater than zero.\n", argv[0]);
    }
    getcwd(dir_name, NAME_MAX);
    directorio = dir_name;
    recursivo = 0;
    
    if (argc == 2) {
        recursivo = 1;
        directorio = getcwd(dir_name, NAME_MAX);
        //printf("%s", directorio);
    } else if (argc == 3) {
        recursivo = 1;
        directorio = argv[2];
    }
    listar(directorio, argv[0], recursivo);
    return 0;
}