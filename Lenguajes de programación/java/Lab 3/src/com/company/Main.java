package com.company;

/*
 *		LAB 3
    By Victor Hugo Torres
    A01701017
 */

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class Main {
    public static Grey grey1, grey2, grey3, grey4;
    public static BufferedImage img;
    public static int numRows, halfRows;
    public static int numCols, halfCols;
    public static void main(String[] args) throws IOException {

        img = ImageIO.read(new File("natalie.jpg"));
        numRows = img.getHeight();
        numCols = img.getWidth();
        halfRows = numRows >>> 1;
        halfCols = numCols >>> 1;

        grey1 = new Grey(img, 0, halfRows, 0, halfCols);
        grey2 = new Grey(img, 0, halfRows, halfCols, numCols);
        grey3 = new Grey(img, halfRows, numRows, 0, halfCols);
        grey4 = new Grey(img, halfRows, numRows, halfCols, numCols);

        grey1.start();
        grey2.start();
        grey3.start();
        grey4.start();

        try{
            grey1.join();
            grey2.join();
            grey3.join();
            grey4.join();
        }catch(InterruptedException e){}


        ImageIO.write(img,"png", new File("negative_natalie.png"));
        System.out.print("Finished");
        System.out.printf("Sum: %d", sum);
    }
}
