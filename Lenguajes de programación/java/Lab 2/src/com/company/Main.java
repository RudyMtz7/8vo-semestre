package com.company;

//A01700309
//Rodolfo Martínez Guevara

import java.util.Random;


public class Main {
    public static int total = 0;
    public static int horses = 0;
    public static int drones = 0;
    public static Unit horseSide;
    public static Unit droneSide;
    public static int horseCount;
    public static int droneCount;
    public static Random random = new Random();

    public static void main(String args[]){
        horseSide = new Unit(0, 0, 0,"Horse");
        droneSide = new Unit(0, 0, 0, "Drone");

        //Creates threads
        horseSide.start();
        droneSide.start();

        try{
            //Period before sleep
            Thread.sleep(10000);
        }catch (InterruptedException e){
            System.out.println("Interrupt");
        }

        horseSide.interrupt();
        droneSide.interrupt();

        try{
            horseSide.join();
            droneSide.join();
        }catch(InterruptedException e){
            System.out.println("Interrupt");
        }
        //Counts numbers of units on each side and declares a winner
        horseCount = horseSide.totalCount;
        droneCount = droneSide.totalCount;
        System.out.printf("%d horse(s) remained battling.\n", horseCount);
        System.out.printf("%d drone(s) remained battling.\n", droneCount);
        if (horseCount > droneCount){
            System.out.println("Horses and Bayonets win!\n");
        }else if(droneCount > horseCount) {
            System.out.println("Drones and Missiles win!\n");
        }else {
            System.out.println("It's a draw.");
        }

    }

    public static synchronized int accessEvent(){
        System.out.printf("%d individuals at war\n", total);
        int flag = 0;
        if (total > 1){
            //Returns random between -1 and 1 to determine if a unit goes in or out
            flag = random.nextInt(3) - 1;
        //Validates if only one unit is in
        }else if (total == 1){
            flag = random.nextInt(2);
        }
        else{
            //If no one is inside, a unit enters by default.
            flag = 1;
        }
        //Keeps track of total amount of units.
        total = total + flag;
        return flag;
    }


}


