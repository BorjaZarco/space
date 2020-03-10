# Practica 4 - Modelos Cámara

> 🔴 Para el correcto funcionamiento del programa es posible que haya que instalar la librería Sound 🔴

> 🔴 Por el uso de sonido y texturas, es posible que el programa tarde unos segundos en cargar 🔴

**Hecho por Borja Zarco Cerezo**

## Índice
- [Introducción](#introducción) 
- [Desarrollo](#desarrollo)
    - [Cuerpos Celestes](##cuerpos-celestes)
    - [Cámara](##cámara)
- [Uso](#uso)
- [Resultado](#resultado)
- [Referencias](#referencias)

## Introducción

El objetivo de esta práctica consiste en permitir la navegación de forma interactiva sobre un sistema planetario. Esta práctica sería una segunda iteración sobre la práctica anterior en la que ya se tenía el sistema solar desarrollado. Por tanto, en esta ocasión el desarrollo se centrará en la navegación iteractiva. Se deberá permitir al usuario modificar no únicamente a la posición de la vista, sino también a la vertical y punto al que se mira, influyendo por tanto en su dirección de movimiento.

## Desarrollo

Se ha conseguido desarrollar la vista como se exigía, con todos los grados de libertad posibles el usuario puede moverse libremente por el espacio, alterando no solo la posición del cuerpo observador en los ejes X, Y y Z. Sino que también puede cambiar la dirección de la vista de dicho cuerpo con total libertad. Esto, además implica que el vector director del movimiento cambie, lo cual es un comportamiento que se espera.

### Cuerpos Celestes

Para el dibujo de los cuerpos celestes se han reutilizado la práctica anterior. Existen tres clases: `Star`, `Planet`, `Satellite`. Estas tres clases bien podrían heredar de una clase `Celestial Body` pues tienen muchas características similares. Todas ellas contenían al menos el nombre y la figura, que sería rotada y trasladada al pintarla usando el método `repaint`. Este método también sería el encargado de pintar los cuerpos celestes que orbitan a su alrededor. Esta supuesta clase padre quedaría de la siguiente manera:

```java
class CelestialBody {
    String name;    
    PShape planet;
    ArrayList<CelestialBody> satellites;

    public void repaint();
    public void addCelestialBody();
}
```


Desde el `setup` se crean los distintos cuerpos celestiales que se van a mostrar.  

### Cámara

Para el desarrollo de la cámara, o cuerpo observador, se ha creado una clase `Spaceship` que almacena la posición dirección en la que se mueve la cámara. Para ello se utilizan tres puntos `PVector`. Dicha clase quedaría de manera resumida de la siguiente manera:

```java
class CelestialBody {
    PVector bodyPos;
    PVector targetPos;
    PVector upPos;

    public void updateEye() {
        yaw += newEyeX * 0.1;
        pitch += newEyeY * 0.1;
        
        targetPos.x = cos(radians(yaw)) * cos(radians(pitch));
        targetPos.y = sin(radians(pitch));
        targetPos.z = sin(radians(yaw)) * cos(radians(pitch));
        targetPos.normalize();
    }

    public void updatePos() {
        if (dirX != 0) {
            bodyPos.add(PVector.mult(targetPos.cross(upPos), 10 * dirX));
        }
        if (dirY != 0) {
            bodyPos.add(PVector.mult(upPos, 10 * dirY));
        }
        if (dirZ != 0) {
            bodyPos.add(PVector.mult(targetPos, 10 * dirZ));
        }
    }
}
```

- `bodyPos` representa la posición del centro del cuerpo observador.
- `targetPos` representa la posición del centro de la escena que se observa, es decir, lo que está mirando el objeto.
- `upPos` representa un punto que está justo encima del observador.

Con estas tres coordenadas se obtiene una especie de ejes Z e Y (`targetPos` y `upPos`, respectivamente), siendo el `bodyPos` el centro de ese eje de coordenadas. Para calcular el eje X restante solo necesitaríamos hacer el producto vectorial de ambos vectores. Por tanto, como se muestra en el código, para decidir el movimiento del observador, simplemente hay que sumarle al centro de coordenadas `bodyPos` el vector del eje en el que se ha de desplazar multiplicado por una cierta velocidad.

Para modificar la dirección de la vista vamos a usar un método que parece ser más preciso que una transformación del vector `targetPos` usando el método del sólido de revolución. 

Este método más preciso se basa en los ángulos de Euler, usados en la navegación de los aviones. Se basa en tres ángulos básicos **pitch**, **yaw** y **roll**. Estos ángulos representan la rotación del objeto sobre los ejes X, Y y Z respectivamente. Por ello en el método `updateEye` usa las variables **pitch** y **yaw** y se actualizan el vector de visión operando con dichas variables. **Roll** se descarta e esta ocasión debido a que no se ha implementado la rotación de la nave sobre su eje Z al considerarse inservible para esta práctica.

## Uso

* `Click y Arrastrar el Ratón ` - Desplaza la dirección de visión
* `Mantener ESPACIO` - Muestra la vista general.
* `I` - Muestra/Oculta la pantalla de instrucciones.
* `A` - Mueve el cuerpo observador hacia la izquierda por el eje X.
* `D` - Mueve el cuerpo observador hacia la derecha por el eje X.
* `S` - Mueve el cuerpo observador hacia atrás por el eje Z.
* `W` - Mueve el cuerpo observador hacia delante por el eje Z.
* `Flecha UP` - Mueve el cuerpo observador hacia arriba por el eje Y.
* `Flecha DOWN` - Mueve el cuerpo observador hacia abajo por el eje Y.


## Resultado

Aqui dejo una demo de la aplicación resultante: 

![Demo Aplicación](./assets/space-animation.gif)

## Referencias

* [Guion de prácticas](https://cv-aep.ulpgc.es/cv/ulpgctp20/pluginfile.php/126724/mod_resource/content/22/CIU_Pr_cticas.pdf)
* [GifAnimation](https://github.com/extrapixel/gif-animation)
* [Documentación Processing](https://processing.org/)
* [Datos del Sistema Solar](https://nssdc.gsfc.nasa.gov/planetary/factsheet/)
* [Texturas espaciales](https://www.solarsystemscope.com/textures/)
* [Movimiento de la cámara](https://learnopengl.com/Getting-started/Camera)
* [BSO Star Wars](https://archive.org/details/StarWarsThemeSongByJohnWilliams)