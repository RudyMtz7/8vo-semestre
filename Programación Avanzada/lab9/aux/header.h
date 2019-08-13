#ifndef HEADER_H
#define HEADER_H

//Includes
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <unistd.h>

//Defines
#define CONTINUE	2
#define END		    -2

//Defaults Port and IP address
#define DEFAULT_PORT    5555
#define DEFAULT_IP      "127.0.0.1"

#endif
