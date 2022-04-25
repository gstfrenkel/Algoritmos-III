# Ejercicio Nº1 - Preguntas

### **1) Los tests 01, 02 y 03 demuestran la funcionalidad de cómo se incrementa la cantidad de huevos de avispas a medida que los van dejando. Cuando los implementaste, ¿esos tests pasaron (los tres) de una? ¿podrías haber implementado esta funcionalidad de a partes, haciendo que pase el 01, luego el 01 y el 02 y por último el 01, 02 y 03? ¿se te ocurre cómo? Y si lograste hacerlo, ¿qué pensas de implementar esa funcionalidad de esa forma?**

El primer test, la primera vez que fue ejecutado, fue el único en pasar las pruebas ya que nuestro mensaje `cantidadDeHuevosDeAvispas` se encargaba únicamente de devolver 0. Esto fue cambiado más adelante a un colaborador interno que iba aumentando a medida que alguna de las avispas recibía el mensaje `intentarReproducirse` (más adelante, este colaborador fue descartado en detrimento de un diccionario para las firmas genéticas). La forma en la que encaramos los test 02 y 03 para que pasen las pruebas a la vez fue que, al querer actualizar la `cantidadDeHuevosDeAvispas`, el valor se actualizaba sumándole 1 cada vez que una avispa recibía el mensaje `intentarReproducirse`.

De la misma forma que simplemente devolvíamos 0 para pasar el test 01, podríamos haber implementando el `intentarReproducirse` para que asigne como valor de 1 al colaborador `cantidadDeHuevosDeAvispas`. De esta forma, se estarían pasando los tests 01 y 02, pero no el 03. Finalmente, para que pasen todos a la vez, se podría haber implementado una funcionalidad parecida a la del párrafo anterior, en la que `intentarReproducirse` no asigne un valor específico, sino que vaya aumentando progresivamente de a uno.


### **2) ¿Les quedó código repetido? ¿dónde? ¿Se animan a adivinar qué cosa del dominio les faltó representar (y por eso tienen código repetido)? Responsabilidad de dejar un huevo consumiendo otro insecto ¿Quién les quedó, en su modelo, que es el responsable de ver si hay suficientes polillas u orugas y entonces dejar un huevo? ¿el insecto (Polly, Oriana, etc) o el hábitat? ¿por qué? ¿por qué tendría sentido que fuera de la otra forma? ¿con cuál nos quedamos?**

Hay secciones de código que se parecen bastante, como son los mensajes de `aumentarCantidadDeHuevosConLaFirmaGeneticaDe...` o `cantidadDeHuevosConLaFirmaGeneticaDe...`. De ser posible pasar como parámetro al mensaje la clave del diccionario a la que se quiere aumentar o buscar el valor, no habría necesidad de tener tantos mensajes.

En cuanto al responsable de buscar si hay orugas o polillas disponibles, consideramos que, al ser estos parte del hábitat, debían ser contados por el hábitat mismo. Por ende, el hábitat es el responsable en nuestra implementación de informar al resto de objetos si hay polillas u orugas disponibles. Quizás, la forma más correcta hubiese sido que las avispas le pregunten al hábitat a partir de un mensaje cuantas polillas u orugas hay disponibles, y que este, a partir del colaborador interno, devuelva la cantidad.


### **3) Con lo que vimos en la clase del Jueves (en la parte teórica, prototipos vs clases) ¿cómo sacarían este código? Sobre la implementación ¿cómo resolvieron guardar los huevos? ¿Usaron colecciones? ¿Diccionarios? ¿Uno, varios? ¿con qué indexaban? Pero la pregunta más importante: ¿es lo más sencillo que hacía falta? ¿o se podía hacer menos y todo andaba?**

En un principio, para guardar los huevos habíamos utilizado colaboradores internos. El problema surgió en que terminamos con demasiados colaboradores (uno para los huevos en general, y uno para cada firma genética) por lo que pasamos estos colaboradores a un diccionario que contenga las firmas genéticas y, para la cantidad de huevos total, utilizamos una colección.

Haber pasado los colaboradores internos a un diccionario simplificó bastante la implementación, y quizás se podría haber hecho algo similar para las orugas y polillas. No se nos ocurre una forma más sencilla para simplificar las cosas más que lo recién mencionado.