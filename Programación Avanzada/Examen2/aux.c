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

#define MAX 256

void limpia(char *cadena) {
  char *p = strchr(cadena, '\n');
  if (p) {*p = '\0';}
}


int main(int argc, char* argv[]){
  while((c = getchar()) != '\n' && c != EOF){
    if (argc < 1){
      printf("usage: %s \n", argv[0]);
      return -1;

    } else {
      int tuberia_em_re[2];
      int tuberia_re_em[2];
      int pid;
      char mensaje[MAX];

      if (pipe(tuberia_em_re) < 0 || pipe(tuberia_re_em) < 0) {
        perror("pipe");return -1;
      }

      if ((pid = fork()) < 0) {
        perror("fork");return -1;
      } else if (pid == 0) {

        while(read(tuberia_em_re[0], mensaje, MAX) > 0 &&strcmp(mensaje, "FIN") != 0) {
          int i = 0;
          while(mensaje[i]) {
            mensaje[i] = toupper(mensaje[i]);
            i++;
          }
          printf("pid = %i, ppid = %i process starting...\n", getpid(), getppid());
          fprintf(stdout,  "PROCESO  HIJO,   MENSAJE:  %s\n", mensaje);
          write(tuberia_re_em[1], mensaje, strlen(mensaje) + 1);
        }

        close (tuberia_em_re[0]);
        close (tuberia_em_re[1]);
        close (tuberia_re_em[0]);
        close (tuberia_re_em[1]);

        return 0;

      } else {

        do {
          printf("pid = %i parent ...\n", getpid());
          fprintf(stdout, "PROCESO PADRE, MENSAJE: ");
          fgets(mensaje, MAX, stdin);
          limpia(mensaje);

          write(tuberia_em_re[1], mensaje, strlen(mensaje) + 1);
          if (strcmp(mensaje, "FIN") == 0) {
            break;
          }do {
            strcpy(mensaje, "");
            read(tuberia_re_em[0], mensaje, MAX);
            fprintf(stdout,  "PROCESO  PADRE,  EN M:  %s\n", mensaje);
            strcpy(mensaje, "LISTO");
          } while (strcmp(mensaje, "LISTO") != 0);
        } while (1);

        close (tuberia_em_re[0]);
        close (tuberia_em_re[1]);
        close (tuberia_re_em[0]);
        close (tuberia_re_em[1]);

        return 0;
      }

    }
  }

}
