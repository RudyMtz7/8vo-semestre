import java.util.Random;

public class Animal extends Thread {
  private int sleepingLow;
  private int sleepingHigh;
  private int position;
  private int speedLow;
  private int speedHigh;
  private int goal;
  private String name;
  private Random rand = new Random();

  public Animal(String name, int sleepingLow, int sleepingHigh, int speedLow, int speedHigh, int goal){
    this.sleepingLow = sleepingLow;
    this.sleepingHigh = sleepingHigh;
    this.speedHigh = speedHigh;
    this.speedLow = speedLow;
    this.position = 0;
    this.name = name;
    this.goal = goal;
  }

  public void run(){
    int speed;
    int sleep;
    while (position < goal && !isInterrupted()){
      try {
        speed = rand.nextInt(speedHigh - speedLow) + speedLow;
        position = position + speed;
        System.out.printf("%s moves to position %d \n", name, position);
        if (position >= goal){
          EpicRaceMain.win(name);
        }
        if(name == "rabbit"){
          sleep = rand.nextInt(sleepingHigh - sleepingLow) + sleepingLow;
          System.out.printf("%s will sleep for %d ms\n", name, sleep);
          this.sleep(sleep);
        }
      }
      catch (InterruptedException e) {
        break;
      }
    }
  }

  public void setPosition(int position){
    this.position = position;
  }

  public int getPosition(){
    return this.position;
  }

}
