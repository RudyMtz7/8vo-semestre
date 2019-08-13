//Rodolfo Martínez Guevara
//A01700309

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class Main {
    public static Grey colorA, colorB, colorC, colorD;
    public static BufferedImage img;
    public static int filas, filasAux, cols, colsAux;
    public static void main(String[] args) throws IOException {

        //Reemplazar path con imagen para modificar otra
        // img = ImageIO.read(new File("PATH"));
        img = ImageIO.read(new File("alex.jpg"));
        filas = img.getHeight();
        cols = img.getWidth();
        filasAux = filas >>> 1;
        colsAux = cols >>> 1;

        colorA = new Grey(img, 0, filasAux, 0, colsAux);
        colorB = new Grey(img, 0, filasAux, colsAux, cols);
        colorC = new Grey(img, filasAux, filas, 0, colsAux);
        colorD = new Grey(img, filasAux, filas, colsAux, cols);

        colorA.start();
        colorB.start();
        colorC.start();
        colorD.start();

        try{
            colorA.join();
            colorB.join();
            colorC.join();
            colorD.join();
        }catch(InterruptedException e){}


        ImageIO.write(img,"png", new File("satanic_alex.png"));
        System.out.print("Done\n");
    }
}
