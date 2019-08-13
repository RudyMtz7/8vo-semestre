package com.company;

import java.util.Random;
public class Door extends Thread{

    //Variables
    private int inCount;
    private int outCount;
    private String access;
    private Random random = new Random();

    //Constructor
    public Door(int inCount, int outCount, String access){
        this.inCount = inCount;
        this.outCount = outCount;
        this.access = access;
    }

    public void run(){
        int flag;
        while(!isInterrupted()){
            try{
                //Sleep
                this.sleep(random.nextInt(1000)+100);
                flag = Main.accessEvent();
                if(flag > 0){
                    //Person enters
                    System.out.printf("A %s enters the battle\n", access);
                    this.inCount = this.inCount +1;
                }
                //Validates if there is a change in the number of people
                else if(flag < 0){
                    //Person exits
                    System.out.printf("%s died in battle\n", access);
                    this.outCount = this.outCount +1;
                }
            }catch(InterruptedException e){
                break;
            }
        }
    }


}
