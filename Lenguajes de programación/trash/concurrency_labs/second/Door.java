import java.util.Random;

public class Door extends Thread{
  private int in;
  private int out;
  private String name;
  private Random rand = new Random();

  public Door(String name, int in, int out){
    this.in = in;
    this.out = out;
    this.name = name;
  }

  public void run(){
    int inorout;
    while(!isInterrupted()){
      try{
        this.sleep(rand.nextInt(1000)+100);
        inorout = GardenMain.usedoor();
        if (inorout > 0){
          System.out.printf("A human entered through %s\n", name);
          this.in = this.in + 1;
        }
        else if (inorout < 0) {
          System.out.printf("A human exit the room through %s\n", name);
          this.out = this.out + 1;
        }
      }
      catch (InterruptedException e) {
        break;
      }
    }
  }
}
