package com.company;

import java.util.concurrent.RecursiveAction;

public class Operation extends RecursiveAction{
    //Variables
    int [][] matrixA;
    int [][] matrixB;
    int [][] matrixResult;
    int [][] matrixResultS;
    int [][] matrixResultD;
    int [][] matrixResultM;
    int start;
    int end;
    int rows;

    //Constructor
    public Operation(int[][] mA, int[][] mB, int[][] mR, int[][] mRS, int[][] mRD, int[][] mRM, int zero, int f, int r){
     matrixA = mA;
     matrixB = mB;
     matrixResult = mR;
     matrixResultS = mRS;
     matrixResultD = mRD;
     matrixResultM = mRM;
     start = zero;
     end = f;
     rows = r;
    }

    public void computeDirectly(){
        for(int i = 0; i < end; i++){
            //Modify values
            matrixResult[start][i] = matrixA[start][i] + matrixB[start][i];
            matrixResultS[start][i] = matrixA[start][i] - matrixB[start][i];
            matrixResultD[start][i] = matrixB[start][i] / matrixA[start][i];
            matrixResultM[start][i] = matrixA[start][i] * matrixB[start][i];
        }
    }

    public void compute(){
        if(rows == 1){
            //Ensures it has reached the individual operation
            computeDirectly();
            return;
        }else{
            //Otherwise pulls with current start, end and row values until case matches
            if(rows > 0){
                invokeAll(new Operation(matrixA, matrixB, matrixResult, matrixResultS, matrixResultD, matrixResultM, start, end, 1),
                          new Operation(matrixA, matrixB, matrixResult, matrixResultS, matrixResultD, matrixResultM, start + 1, end, rows -1));
            }
        }
    }
}
