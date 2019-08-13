// Mexico City’s botanical garden is open to the public.
// Any person can go in through one of two doors.
// By Victor Hugo Torres Rivera
// A01701017

import java.util.Random;

public class GardenMain{
  public static int humans = 0;
  public static int exite = 0;
  public static int exitw = 0;
  public static Door east_door;
  public static Door west_door;
  public static Random rand = new Random();
  public static void main(String args[]){
    east_door = new Door("East Door", 0, 0);
    west_door = new Door("West Door", 0, 0);

    east_door.start();
    west_door.start();

    try {
    Thread.sleep(10000);
    } catch(InterruptedException e) {
        System.out.println("got interrupted!");
    }

    east_door.interrupt();
    west_door.interrupt();

    try{
      east_door.join();
      west_door.join();
    }
    catch (InterruptedException e) {
      System.out.printf("Wrong");
    }
    System.out.printf("%d humans were still in at closing hours.\n", humans);
    exite = rand.nextInt(humans);
    exitw = humans - exite;
    System.out.printf("%d humans were forced to exit through the East door.\n", exite);
    System.out.printf("%d humans were forced to exit through the West door.\n", exitw); 

  }

  public static synchronized int usedoor(){
    System.out.printf("%d humans are inside\n", humans);
    int inorout = 0;
    if (humans > 0){
      inorout = rand.nextInt(3) - 1;
    }
    else{
      inorout = 1;
    }
    humans = humans + inorout;
    return inorout;
  }
}
