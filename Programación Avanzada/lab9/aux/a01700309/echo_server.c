/*-----------------------------------------------------------

* Programación avanzada: Echo server

* Fecha: 26 de abril 2019

* Autor:  A01700309	Rodolfo Martínez Guevara

*------------------------------------------------------------*/

#include "header.h"
#include <string.h>

void serves_client(int nsfd) {
	char message_sent[50];

	srand(getpid());
	//Recibe mensaje del cliente y regresa el mismo.
  read(nsfd, &message_sent, sizeof(message_sent));
  write(nsfd, &message_sent, sizeof(message_sent));
	close(nsfd);
}

void server(char* ip, int port, char* program) {
	int sfd, nsfd, pid;
	struct sockaddr_in server_info, client_info;

	if ( (sfd = socket(AF_INET, SOCK_STREAM, 0)) < 0 ) {
		perror(program);
		exit(-1);
	}

	server_info.sin_family = AF_INET;
	server_info.sin_addr.s_addr = inet_addr(ip);
	server_info.sin_port = htons(port);
	if ( bind(sfd, (struct sockaddr *) &server_info, sizeof(server_info)) < 0 ) {
		perror(program);
		exit(-1);
	}

	listen(sfd, 1);
	while (1) {
		int len = sizeof(client_info);
		if ( (nsfd = accept(sfd, (struct sockaddr *) &client_info, &len)) < 0 ) {
			perror(program);
			exit(-1);
		}

		serves_client(nsfd); // ITERATIVO
	}
}

int main(int argc, char* argv[]) {
	char ip[15];
	int port;

	strcpy(ip, DEFAULT_IP);
	port = DEFAULT_PORT;

	server(ip, port, argv[0]);

	return 0;
}
