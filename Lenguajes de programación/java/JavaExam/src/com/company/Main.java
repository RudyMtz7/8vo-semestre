package com.company;

//A01700309
//Rodolfo Martínez Guevara
//Matrix computation for basic operations (+, -, *, /)

import java.util.concurrent.ForkJoinPool;

public class Main {

    public static void main(String[] args) {
        //Variables:

        //Set start at 0 and the end will be the dimensions of the matrix
        int start = 0, end = 5;
        int [][] matrixA = new int[end][end];
        int [][] matrixB = new int[end][end];
        int [][] matrixResult = new int[end][end];
        int [][] matrixResultS = new int[end][end];
        int [][] matrixResultD = new int[end][end];
        int [][] matrixResultM = new int[end][end];

        ForkJoinPool pool = new ForkJoinPool();

        for(int i = 0; i < end ;i++){
            for(int j = 0; j < end ;j++){
                //Set initial values of Matrix A & B
                matrixA[i][j] = 2;
                matrixB[i][j] = 4;
                //Initialize result matrix in 0's
                matrixResult[i][j] = 0;
                matrixResultS[i][j] = 0;
                matrixResultD[i][j] = 0;
                matrixResultM[i][j] = 0;
            }
        }

        //Call the operation
        Operation calculate = new Operation(matrixA, matrixB, matrixResult, matrixResultS, matrixResultD, matrixResultM, 0, end, end);

        //Pool invoke
        pool.invoke(calculate);

        //Print out each matrix
        System.out.print("Addition: \n");

        for(int i = 0; i < end; i++){
            for(int j = 0; j < end; j++){
                System.out.print(" " + matrixResult[i][j]);
            }
            System.out.print("\n");
        }

        System.out.print("\n");
        System.out.print("Substraction: \n");

        for(int i = 0; i < end; i++){
            for(int j = 0; j < end; j++){
                System.out.print(" " + matrixResultS[i][j]);
            }
            System.out.print("\n");
        }

        System.out.print("\n");
        System.out.print("Division: \n");

        for(int i = 0; i < end; i++){
            for(int j = 0; j < end; j++){
                System.out.print(" " + matrixResultD[i][j]);
            }
            System.out.print("\n");
        }

        System.out.print("\n");
        System.out.print("Multiplication: \n");

        for(int i = 0; i < end; i++){
            for(int j = 0; j < end; j++){
                System.out.print(" " + matrixResultM[i][j]);
            }
            System.out.print("\n");
        }
    }
}
