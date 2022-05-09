# Ejercicio Nº3 - Preguntas

### **1) En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?**

El primero de los llamados te aporta el método para resolver el problema en cuestión mientras que el otro aporta la conexión hacia otra clase la cual se encargará de resolver el problema con un método similar. A modo de ejemplo (y pensando en el ejercicio resuelto), nuestra implementación de `beAddedToAnEntero` y `beAddedToAFraccion` resuelve la problemática de como sumar enteros con enteros, enteros con fracciones, y fracciones con fracciones sin la necesidad de utilizar `ifs` y evitando complejizar el polimorfismo. Por un lado, `beAddedToAnEntero` resuelve sumar un entero con un entero (en caso de que el colaborador sea un entero) mientras que `beAddedToAFraccion` resuelve sumar una fracción con una fracción (en caso de que el colaborador sea una fracción). Por el otro lado, se hace uso del conocimiento del objeto que recibe el mensaje para llamar a `beAddedToAnEntero` o `beAddedoToAFraccion` en función de la clase del colaborador (la cual es desconocida).


### **2) Con lo que vieron y saben hasta ahora, ¿dónde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?**

Consideramos que el método encargado de instanciar objetos debería estar definido dentro de los mensajes de cada clase, ya que es la misma clase la que debería encargarse de crear instancias de si misma en caso de ser necesario. Si se toma como ejemplo el ejercicio Nº1 (de las avispas), resultaba invasivo (además de que rompía el encapsulamiento) que una avispa busque en el `HabitatDeAvispas`si hay orugas suficientes por su cuenta, cuando esta responsabilidad debería recaer sobre el hábitat mismo (ya que es este el que se encarga de contabilizar las orugas).

Dentro de lo posible, se debería evitar instanciar un objeto desde diferentes lugares lo más posible por lo explicado en el punto anterior. En caso de ser inevitable tener una sola forma o lugar desde donde instanciar, lo que se puede implementar es un llamado por mensaje a la clase para que esta instancie un nuevo objeto de cierta forma. Ejemplificando, si se necesita instanciar una fracción dentro de la clase entero, el entero debería recurrir a un mensaje que le pida a la clase de fracción instanciar un nuevo objeto de cierta forma.


### **3) Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?**

En caso de ser métodos que no deberían ser llamados por fuera de las implementaciones que posee la clase, siempre llevan el nombre de `private`. Acompañando esta idea, intentamos clasificar los métodos en base a su funcionamiento o colaboradores con los que interactúa. En este ejercicio agrupamos en base a operaciones (principalmente aritméticas) mientras que para las avispas en base a los distintos objetos con los que trabajaban (huevos, orugas, polillas, las distintas avispas, etc) aunque también incluimos cierta funcionalidad (la categoría de reestablecimiento).


### **4) Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?**

Si bien `self subclassResponsibility` podría ser considerado opcional (aunque no completamente) debido a que un mensaje intenta ser respondido primero a partir de las subclases, en caso de crear una nueva subclase y que el programador se olvide de implementar un método para esta nueva subclase, el `self subclassResponsibility` arrojará una excepción. En caso de no haber implementado el `self subclassResponsibility`, el programa "crashearía" debido a que no sabe responder a dicho mensaje. A su vez, sirve para dejar implícito para otros programadores que la clase en cuestión no es responsable de responder al mensaje, sino sus subclases.


### **5) ¿Por qué está mal o qué problemas trae romper encapsulamiento?**

El problema de romper el encapsulamiento es que se rompe la privacidad existente entre objetos y colaboradores. En vez de acceder directamente al colaborador de un objeto (lo cual es posible pero incorrecto), una mejor opción sería la de pedirle acceso y permiso al objeto dueño del colaborador para poder cambiarlo.