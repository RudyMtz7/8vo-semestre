//Rodolfo Martínez Guevara
//A01700309

public class EpicRaceMain{
  public static Animal rabbit;
  public static Animal turtle;
  public static void main(String args[]){
    int goal;

    System.out.printf("First version.\n");
    goal = 1000;
    rabbit = new Animal("rabbit", 100, 200, 500, 1000, goal);
    turtle = new Animal("turtle", 0, 0, 3, 10, goal);
    rabbit.start();
    turtle.start();
    try{
      rabbit.join();
      turtle.join();
    }
    catch (InterruptedException e) {
      System.out.printf("Wrong");
    }


    System.out.printf("Second version, longer race.\n");
    goal = 10000;
    rabbit = new Animal("rabbit", 100, 200, 500, 1000, goal);
    turtle = new Animal("turtle", 0, 0, 3, 10, goal);
    rabbit.start();
    turtle.start();
    try{
      rabbit.join();
      turtle.join();
    }
    catch (InterruptedException e) {
      System.out.printf("Wrong");
    }


    System.out.printf("Second version, Faster Rabbit.\n");
    goal = 1000;
    rabbit = new Animal("rabbit", 100, 200, 900, 5000, goal);
    turtle = new Animal("turtle", 0, 0, 3, 10, goal);
    rabbit.start();
    turtle.start();
    try{
      rabbit.join();
      turtle.join();
    }
    catch (InterruptedException e) {
      System.out.printf("Wrong");
    }

    System.out.printf("Second version, Slower Turtle.\n");
    goal = 1000;
    rabbit = new Animal("rabbit", 100, 200, 500, 1000, goal);
    turtle = new Animal("turtle", 0, 0, 3, 4, goal);
    rabbit.start();
    turtle.start();
    try{
      rabbit.join();
      turtle.join();
    }
    catch (InterruptedException e) {
      System.out.printf("Wrong");
    }
  }

  public static synchronized void win(String winner){
    System.out.printf("%s won the race \n", winner);
    System.out.printf("--------------------------------------\n\n");
    turtle.interrupt();
    rabbit.interrupt();
  }
}
