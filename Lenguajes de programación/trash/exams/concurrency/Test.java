import java.util.concurrent.ForkJoinPool;
public class Test {
    public static void main(String args[]){
        // filling the matrix to test the code
        int start = 0 , end = 6;
        int[][]  matA= new int[end][end];
        int[][]  matB= new int[end][end];
        int[][]  matResult= new int[end][end];
        ForkJoinPool pool = new ForkJoinPool();

        for(int i = 0; i< end; i++){
            for(int j = 0; j< end; j++){
                matA[i][j]= 1; matB[i][j]= 1;  matResult[i][j] = 0;
            }
        }
        // filling the matrix to test the code
        Addmat add = new Addmat(matA, matB, matResult, 0, end, end);

        pool.invoke(add);

        for(int i = 0; i< end; i++){
            for(int j = 0; j< end; j++){
                System.out.print(" " + matResult[i][j]);
            }
            System.out.print("\n");
        }
    }
}
