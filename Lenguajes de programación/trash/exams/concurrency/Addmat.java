import java.util.concurrent.RecursiveAction;

public class Addmat extends RecursiveAction {
    int [][] mat1;  int [][] mat2;  int [][] mat3;
    int begin; int end; int rows;

    public Addmat(int[][] m1, int[][] m2, int[][] m3, int b, int e, int r){
        mat1 = m1;  mat2 = m2;  mat3 = m3;  begin = b;  end = e; rows = r;
    }

    protected void computeDirectly(){
        for(int j = 0; j< end; j++){
            mat3[begin][j] = mat3[begin][j] +  mat1[begin][j] + mat2[begin][j];
        }
    }

    // @Override
    // public void run() {
    //   for(int i = 0; i< end; i++){
    //     for(int j = 0; j< end; j++){
    //       mat3[i][j] = mat3[i][j] +  mat1[i][j]+mat2[i][j];
    //     }
    //   }
    // }
    protected void compute(){

        if (rows == 1){
            computeDirectly();
            return;
        }
        else{
          if (rows > 0){
            invokeAll(new Addmat(mat1, mat2, mat3, begin, end, 1), new Addmat(mat1, mat2, mat3, begin+1, end, rows-1));
          }
        }
    }

}
