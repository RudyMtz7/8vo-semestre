package com.company;

import java.awt.image.BufferedImage;

public class Grey extends Thread{
    int beginW;
    int beginH;
    int endW;
    int endH;
    BufferedImage img;
    int sum = 0;

    public Grey(BufferedImage img, int beginH, int endH, int beginW, int endW){
        this.img = img;
        this.beginH = beginH;
        this.endH = endH;
        this.beginW = beginW;
        this.endW = endW;
    }

    public void run(){
        for (int i = beginH; i < endH; i++) {
            for (int j = beginW; j < endW; j++) {
                int rgb = img.getRGB(j, i);  // rgb contian all number coded within a single integer concatenaed as red/green/blue

                //use this separation to explore with different filters and effects  you need to do the invers process to encode red green blue into a single value again

                //separation of each number
                int red = (rgb>> 16) & 0xFF;  // & uses  0000000111 with the rgb number to eliminate all the bits but the las 3 (which represent 8 position which are used for 0 to 255 values)
                int green = (rgb>> 8) & 0xFF;  // >> Bitwise shifts 8 positions  & makes  uses  0000000111 with the number and eliminates the rest
                int blue = (rgb>> 8) & 0xFF; // >> Bitwise shifts 16 positions  & makes  uses  0000000111 with the number and eliminates the rest


                //rgb = ~rgb; // ~ negation of the complete pixel value

                sum = sum + rgb;

                img.setRGB(j, i, rgb); // sets the pixeles to specified color  (negative image)

            }
        }
    }

}
