package com.company;

import java.util.Random;
public class Unit extends Thread{

    //Variables
    private int inCount;
    private int outCount;
    private String unit;
    private Random random = new Random();
    public int totalCount;

    //Constructor
    public Unit(int inCount, int outCount, int totalCount, String unit){
        this.inCount = inCount;
        this.outCount = outCount;
        this.totalCount = totalCount;
        this.unit = unit;
    }

    public void run(){
        int flag;
        while(!isInterrupted()){
            try{
                //Sleep
                this.sleep(random.nextInt(1000)+100);
                flag = Main.accessEvent();
                if(flag > 0){
                    //Unit enters
                    System.out.printf("A %s enters the battle\n", unit);
                    this.inCount = this.inCount +1;
                    this.totalCount = this.totalCount +1;
                }
                //Validates if there is a change in the number of units
                else if(flag < 0){
                    //Unit exits
                    if (this.totalCount > 0){
                        System.out.printf("%s died in battle\n", unit);
                        this.outCount = this.outCount +1;
                        this.totalCount = this.totalCount -1;

                    }
                }
            }catch(InterruptedException e){
                break;
            }
        }
    }


}
