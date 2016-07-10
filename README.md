#HackBook

### ¿Donde guardarías los datos de imagenes y pdf?
Los he guardado en el directorio documents. No me parecía correcto usar NSUserdefault para guardar tanta información.

No le he cambiado a la los datos la url, porque en la proxima versión solo me descargaría los que el usuario estuviera leyendo o quisiera descargarse.

### ¿Como implementar favoritos?
Lo he implementado como un array guardado NSUserDefault. No es el metodo más optimo pero como serán pocos valores puede servir.

### ¿Como enviar AGTBook a AGTTAbleViewController?

La comunición del controlador AGTBOOK y AGTLibreryTable view controller la he realizado con notificaciones. Tambíen podría haber implementado un delegado. Me ha parecido mejor las notificaciones por que AGTBOOk ya era delegado de Librery

### Metodo REload
Sólo recarga aquellas celdas que estan visualizandose.

Otra alternativa es el pull refresh, que cargaría nuevos datos cuando el usuario tirara hacia abajo de la tabla. Merece la pena usarlo cuando puede haber datos nuevos desde un origen.

### Funcionalidad antes de subir.

Lo implementaría en una base de datos

Podría utilizar la aplicación como un lector de prospectos sanitarios
Y pondría banner de publicidad




