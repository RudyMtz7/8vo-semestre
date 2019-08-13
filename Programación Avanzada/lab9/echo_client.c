//Includes
#include "header.h"

//Main function
int main(int argc, char* argv[]) {

    //Variable Declaration
    int sfd, number, answer, continuE;
	int port;
	struct sockaddr_in server_info;

	//Checks if the usage of the file is correct (string then ipport)
	if (argc != 3) {
	    printf("usage: %s ip port\n", argv[0]);
	    return -1;
	}

	//change from string to integer
	port = atoi(argv[2]);

	//No estoy seguro
	if (port < 5000) {
		printf("%s: The port must be greater than 5000.\n", argv[0]);
		return -1;
	}

	//Error detection when creating a socket
	if ( (sfd = socket(AF_INET, SOCK_STREAM, 0)) < 0 ) {
		perror(argv[0]);
		return -1;
	}

	//Get information from the client now
	server_info.sin_family = AF_INET;    //Family
	server_info.sin_addr.s_addr = inet_addr(argv[1]);   //IP Address
	server_info.sin_port = htons(port);   //Port connecting

	//Error detection when connecting to the server
	if ( connect(sfd, (struct sockaddr *) &server_info, sizeof(server_info)) < 0 ) {
		perror(argv[0]);
		return -1;
	}


	//VARIABLES NO DECLARADAS
	//text and continuE
	char text[200];

	do{
	    //Get info from the user by terminal
	    printf("Give me a text please");
			scanf("%i", &number);

			write(sfd, &number, sizeof(number));
			read(sfd, &answer, sizeof(answer));


	    // write(sfd, &DEFAULT_IP, sizeof(DEFAULT_IP));

	    printf("DONE. Do you want to continuE? (0/1)");
	    scanf("%i", &continuE);
	}while (continuE == 1);

	//Close connection
	close(sfd);

	//Return 0
	return 0;
}
