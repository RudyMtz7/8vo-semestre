/*-----------------------------------------------------------

* Programación avanzada: Echo server

* Fecha: 26 de abril 2019

* Autor:  A01700309	Rodolfo Martínez Guevara

*------------------------------------------------------------*/

#include "header.h"
#include "string.h"

int main(int argc, char* argv[]) {
  int sfd, answer, continuE;
  char message[50];
  char ip[16];
	int port, guess;
	struct sockaddr_in server_info;

	if (argc != 2) {
	    printf("usage: %s ip\n", argv[0]);
	    return -1;
	}

	port = DEFAULT_PORT;
	if (port < 5000) {
		printf("%s: The port must be greater than 5000.\n", argv[0]);
		return -1;
	}

	if ( (sfd = socket(AF_INET, SOCK_STREAM, 0)) < 0 ) {
		perror(argv[0]);
		return -1;
	}
  strcpy(ip, DEFAULT_IP);

	server_info.sin_family = AF_INET;
	server_info.sin_addr.s_addr = inet_addr(argv[1]);
	server_info.sin_port = htons(port);
	if ( connect(sfd, (struct sockaddr *) &server_info, sizeof(server_info)) < 0 ) {
		perror(argv[0]);
		return -1;
	}
	printf("Introduce el mensaje: \n");
  //Asigna el mensaje introducido por el usuario.
  fgets(message,50,stdin);

  //Envia y recibe respuesta del server.
	write(sfd, &message, sizeof(message));
	read(sfd, &message, sizeof(message));
  //Imprime la respuesta.
	fprintf(stdout,"\nServer %s : %s\n",ip,message);

	close(sfd);
	return 0;
}
