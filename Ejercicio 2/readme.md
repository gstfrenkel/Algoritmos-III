# Ejercicio Nº1 - Preguntas

### **1) En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?**

En ambos tests se repetía la evaluación de un par de mensajes para luego comparar con cierto tiempo de ejecución. Como en esta abstracción algunos detalles cambiaban entre ambos tests (para ser más precisos el código a ejecutar y el tiempo de ejecución con el que comparar), decidimos pasar estas diferencias como parámetros. De esta forma, es que finalmente llegamos a una abstracción en la que se ejecuta un closure para evaluar en cuanto tiempo se realiza.

Pasando a un punto de vista más cercano a la realidad, esta abstracción puede verse a través de un usuario que quiere medir el tiempo que le lleva alguna acción en un libro de clientes. El concepto de tiempo de ejecución quizás puede verse más simplemente por el lado computacional y no tenga tanto sentido en la realidad, pero eso no quita que pueda ser llevado a este plano.


### **2) ¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?**

El más claro de todos sería un objeto. Tan solo con definirlo con un nombre adecuado podría ser suficiente para representar a un ente de la realidad (aunque probablemente necesite algo de funcionalidad: colaboradores, mensajes y métodos, etc). A su vez, partiendo de la base de que todo es un objeto, podría decirse que cualquier cosa (bien definida) en Smalltalk tiene potencial de representar algo de la realidad. Elaborando un poco más, un mensaje puede representar una acción perteneciente a una clase u objeto (como el arranque de un auto); una clase puede representar un conjunto de entes que comparten ciertos aspectos (como un vehículo); y una instancia puede representar una particularidad de la clase (como un modelo de auto).


### **3) ¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?**

En base a la construcción de un modelo (según propone Naur) es que el programador puede explicar cada parte del programa que escribe y por qué es como es, defendiendo con algún tipo de justificación. A su vez, es capaz de explicar con qué aspecto de la realidad se relaciona cada estructura, y es este tipo de conocimiento el que puede llevar a una abstracción del código con la realidad. Es a partir de esta abstracción que el programador puede ser capaz de identificar (y solucionar) partes donde exista código repetido con mayor simpleza.