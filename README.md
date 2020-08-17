Gemma Code

Esta versión del código Gemma solo lee el archivo de entrada definido por el
usuario.

El archivo pinUO2.inp, es un archivo de entrada con las opciones actuales
definidas para el código Gemma.

Para compilar el código Gemma solo basta con escribir make en una consola ubicado
en la carpeta raíz donde se encuentran los archivos fuente ( *.d), es necesario
tener instalado el compilador DMD.
(https://dlang.org/download.html)

Si se compila en un sistema operativo base linux o base windows, se debe modificar el
archivo Makefile, modificando la opcion -version. Ejemplo:
 -version=windows, -version=linux

Al compilar el código Gemma, se genera un ejecutable llamado "gemma0.1.exe", y para
ejecuralo basta con escribir:

Windows:

 c:\>gemma0.1.exe -i <path/archivo/entrada>
ó
 c:\>gemma.0.1.exe -i=<path/archivo/entrada>

Linux:

  ~$ .\gemma.0.1.exe -i <path/archivo/entrada>
ó
  ~$ .\gemma.0.1.exe -i=<path/archivo/entrada>

Nota:
Esta actualización del código Gemma, solo esta enfocada a la lectura del archivo de entrada,
con la finalidad de encontrar errores durante la lectura del mismo, que puedan provocar
otros errores durante los cálculos de transporte.

---------------------------------------------------------------------------------------------------

Tareas por hacer:

- Verificación de universos definidos en las tarjetas "pin", "lattice" y "cell",
para evitar repeticiones de los mismos.

- Incluir lectura de secciones macroscopicas, en el caso que se defina la tarjeta macro.

    En esta parte, el código debe ser capaz de leer el archivo de entrada completamente y
    posteriormente de acuerdo a la opción "macro" o "lib" verificar la correcta definición
    de los materiales en la tarjeta "material".

    Nota: por el momento la opción "material", esta definida para ser usada con la opción "lib"

- Inluir lectura de tarjetas de quemado definidas en la tesis de Hirepan Palomares

- Si la opción "lib" es utilizada, leer las secciones microscopicas de los archivos *.lib y
generar las secciones macroscopicas, con la información proporcionada en "lib".

  En esta opción se debe tener cuidado al generar el espectro de fisión.
  Se debe generar un espectro inicial y posteriormente hacer un proceso iterativo
  para dicha variable, ya que depende del flujo escalar. (esta forma por el momento
   no se tiene programado)
