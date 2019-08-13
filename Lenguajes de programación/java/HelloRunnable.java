
public class HelloRunnable implements Runnable {

  int id;

  public HelloRunnable(int nid){
    id = nid;
  }

  public void run() {
    System.out.println("Hello from a thread! " + id);
  }

  public static void main(String args[]){
    for(int i = 0; i < 5; i++){
      (new Thread(new HelloRunnable(i))).start();
    }
  }

}
