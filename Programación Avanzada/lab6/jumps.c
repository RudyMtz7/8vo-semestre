/*----------------------------------------------------------------

*

* Programación avanzada: Manejando de señales

* Fecha: 12-Mar-2019

* Autor: A01700309 Rodolfo Martínez

*

*--------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/wait.h>

void handler(int signal){
  //Recibe señal
	switch(signal){
		case SIGHUP:
			printf("Punto de retorno 1\n");
			printf("Tabla de cuadrados\n");
			printf("Número Cuadrado\n");
			printf("1		1\n");
			printf("2		4\n");
			printf("3		9\n");
			printf("4		16\n");
			printf("5		25\n\n");
		case SIGINT:
			printf("Punto de retorno 2:\n");
			printf("Tabla de raíces cuadradas\n");
			printf("Número Raíz cuadrada\n");
			printf("1		1.00000\n");
			printf("2		1.41421\n");
			printf("3		1.73205\n");
			printf("4		2.00000\n");
			printf("5		2.23607\n\n");
		case SIGQUIT:
			printf("Punto de retorno 3:\n");
			printf("Tabla de logaritmos\n");
			printf("Número Logaritmo\n");
			printf("1		0.00000\n");
			printf("2		0.69315\n");
			printf("3		1.09861\n");
			printf("4		1.38629\n");
			printf("5		1.60944\n\n\n");
			break;
		default:
			printf("Senal invalida\n");
			break;
	}
}

int main(int argc, char* argv[]){

	signal(SIGHUP, handler);
	signal(SIGINT, handler);
	signal(SIGQUIT, handler);

  //Valida el uso
	if(argc != 1){
		printf("usage: jumps\n");
		return -1;
	}
  //Imprime tabla
	else{
		printf("Punto de retorno 1\n");
		printf("Tabla de cuadrados\n");
		printf("Número Cuadrado\n");
		printf("1		1\n");
		printf("2		4\n");
		printf("3		9\n");
		printf("4		16\n");
		printf("5		25\n");
		printf("Punto de retorno 2:\n");
		printf("Tabla de raíces cuadradas\n");
		printf("Número Raíz cuadrada\n");
		printf("1		1.00000\n");
		printf("2		1.41421\n");
		printf("3		1.73205\n");
		printf("4		2.00000\n");
		printf("5		2.23607\n");
		printf("Punto de retorno 3:\n");
		printf("Tabla de logaritmos\n");
		printf("Número Logaritmo\n");
		printf("1		0.00000\n");
		printf("2		0.69315\n");
		printf("3		1.09861\n");
		printf("4		1.38629\n");
		printf("5		1.60944\n");
		printf("PID = %i\n", getpid());
	}

	while(1){
		sleep(10);
	}

	//Es necesario enviar el comando 'kill' desde una nueva terminal

	return 0;
}
