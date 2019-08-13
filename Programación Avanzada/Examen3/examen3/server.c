/*-----------------------------------------------------------

* Programación avanzada: Tercer examen

* Fecha: 30 de abril 2019

* Autor:  A01700309	Rodolfo Martínez Guevara

*------------------------------------------------------------*/

#include "header.h"
#include <string.h>

void serves_client(int nsfd) {
  int i, sfd;
	uchar cmd;
	ulong id, val;

	srand(getpid());
  read(nsfd, &cmd, sizeof(uchar));
  // printf("%u\n", cmd);

  read(nsfd, &id, sizeof(ulong));
  // printf("%lu\n", id);

  read(nsfd, &val, sizeof(ulong));
  // printf("%lu\n", val);

  if(cmd == 101){
    printf("Dato leido\n");
    printf("PID %i - cmd 201 - id = %lu - val = %lu\n", getpid(), id, val);
    sleep(1);
  }else if (cmd == 102) {
    printf("Valor actualizado\n");
    printf("PID %i - cmd 202 - id = %lu - val = %lu\n", getpid(), id, val);
    write(nsfd, &val, sizeof(ulong));
    sleep(5);
  }

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

		if ( (pid = fork()) < 0 ) {
			perror(program);
		} else if (pid == 0) {
			close(sfd);
			serves_client(nsfd);
			exit(0);
		} else {
			close(nsfd);
		}
	}
}

int main(int argc, char* argv[]) {
	char ip[15];
	int port;

	strcpy(ip, SERVER_IP);
	port = SERVER_PORT;
	if (argc == 3) {
		if (strcmp(argv[1], "-d") == 0) {
			strcpy(ip, argv[2]);
		} else if (strcmp(argv[1], "-p") == 0) {
			port = atoi(argv[2]);
			if (port < 5000) {
        		printf("%s: The port must be greater than 5000.\n", argv[0]);
        		return -1;
        	}
		} else {
			printf("usage: %s [-d dir] [-p port]\n", argv[0]);
			return -1;
		}
	} else if (argc == 5) {
		if (strcmp(argv[1], "-d") == 0) {
			strcpy(ip, argv[2]);
			if (strcmp(argv[3], "-p") == 0) {
				port = atoi(argv[4]);
				if (port < 5000) {
            		printf("%s: The port must be greater than 5000.\n", argv[0]);
            		return -1;
            	}
			} else {
				printf("usage: %s [-d dir] [-p port]\n", argv[0]);
				return -1;
			}
		} else if (strcmp(argv[1], "-p") == 0) {
			port = atoi(argv[2]);
			if (port < 5000) {
        		printf("%s: The port must be greater than 5000.\n", argv[0]);
        		return -1;
        	}
			if (strcmp(argv[3], "-d") == 0) {
				strcpy(ip, argv[4]);
			} else {
				printf("usage: %s [-d dir] [-p port]\n", argv[0]);
				return -1;
			}
		} else {
			printf("usage: %s [-d dir] [-p port]\n", argv[0]);
			return -1;
		}
	} else if (argc != 1) {
		printf("usage: %s [-d dir] [-p port]\n", argv[0]);
		return -1;
	}

	server(ip, port, argv[0]);

	return 0;
}
