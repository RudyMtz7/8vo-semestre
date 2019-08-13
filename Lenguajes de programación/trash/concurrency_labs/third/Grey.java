import java.awt.image.BufferedImage;

public class Grey extends Thread{
  int ancho0;
  int altura0;
  int anchoF;
  int alturaF;
  BufferedImage img;

  public Grey(BufferedImage img, int altura0, int alturaF, int ancho0, int anchoF){
    this.img = img;
    this.altura0 = altura0;
    this.alturaF = alturaF;
    this.ancho0 = ancho0;
    this.anchoF = anchoF;
  }

  public void run(){
    //Recorre imagen
    for (int i = altura0; i < alturaF; i++) {
      for (int j = ancho0; j < anchoF; j++) {
        //La variable RGB contiene los valores de cada color
        int rgb = img.getRGB(j, i);

        //Obtenemos cada color por separado
        int red = (rgb>> 16) & 0xFF;
        int green = (rgb>> 8) & 0xFF;
        int blue = (rgb>> 8) & 0xFF;

        //Cambiamos el valor del pixel a su opuesto
        rgb = ~rgb;

        // 'Seteamos' los pixeles
        img.setRGB(j, i, rgb);

      }
    }
  }

}
