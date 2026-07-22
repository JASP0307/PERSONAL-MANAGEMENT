## Modelo Genérico de Control de 3 Dispositivos con Rotación y PID
Este documento detalla la estructura y las consideraciones de ingeniería para la conversión de un modelo de control específico de Schneider Electric (diseñado originalmente para bombas de agua) en una plantilla estándar y genérica aplicable a cualquier sistema de tres dispositivos que requiera control PID y alternancia de desgaste.

---
## 1. Descripción del Modelo

El objetivo principal del modelo es controlar **tres (3) dispositivos** basándose en una única variable de control.

- **Algoritmo PID:** Define la necesidad dinámica de activar o desactivar equipos para mantener el punto de consigna (_setpoint_).
- **Lógica de Rotación:** Distribuye de manera equitativa el desgaste mecánico y eléctrico de los equipos mediante una secuencia de alternancia preestablecida.
---
## 2. Consideraciones de Implementación y Migración

### 2.1. Criterio de Transición (Stage Up / Stage Down)

El modelo de referencia utiliza variadores de frecuencia (VFD) para mantener la variable constante. La velocidad comandada por el PID al VFD activo es el parámetro que determina las transiciones:

- **Stage Up:** Se activa cuando la velocidad del equipo actual llega a su límite superior y la demanda no se satisface.
- **Stage Down:** Se activa cuando la velocidad disminuye lo suficiente, indicando un exceso de capacidad instalada para la carga actual.

Partiendo de allí, se dejó el modelo con un nombre genérico (SysCtrlCmdVar) para aludir a esa "velocidad" original en porcentaje (%). Que puede llegar a ser por ejemplo una apertura de válvula de agua helada.
### 2.2. Unidades de Variables/Tendencias/Alarmas

Se creó una búsqueda predefinida llamada "- Unit Change Search" que permite ver todos los objetos del desarrollo que poseen una unidad asociada  y que pueden ser ajustadas de forma masiva, seleccionando los objetos del mismo tipo dentro de la búsqueda.

*Nota: Es posible que algunos Function blocks posean una unidad asignada para sus entradas/salidas, estas pueden ser buscadas con facilidad en la ventana inferior dentro del editor, donde están ubicadas todas las variables del programa.*

### 2.3. Dirección de Acción del PID

El bucle PID debe configurarse específicamente según la naturaleza de la aplicación física:

- **Control de Presión (Acción Inversa):** Si la variable supera el _setpoint_, se comanda la disminución de velocidad o el apagado de equipos.
- **Control de Temperatura (Acción Directa):** Si la variable supera el _setpoint_ hacia arriba, se comanda el encendido o incremento de etapas (ej. compresores).

Esta configuración se debe realizar dentro del programa **Sys - v1.1**, una dentro del bloque *System Controlled Variable High Limit* y otra denro del bloque *Device Speed*.
### 2.4. Acondicionamiento de Señales

Dependiendo de la aplicación particular, puede ser necesario añadir programas lógicos complementarios al modelo genérico para adecuar la variable del proceso.

- _Ejemplo:_ Implementar un programa intermedio tipo `P_Pressure_Calc` para preparar y normalizar la variable de control antes de que entre a la estructura de la lógica principal.

### 2.5 Interfaz Gráfica

Dependiendo de la aplicación particular cambiará, pero es recomendable mantener los componentes de values principales para aprovechar esos binds. De igual forma, existe el binding template llamado *"PMBT - Standard Model"*.

---
## 3. Reemplazo de Nomenclatura

Para personalizar el modelo según la aplicación, los campos de descripción de todo el desarrollo contienen los siguientes términos reemplazables:

| Término Genérico | Ejemplo de Término Personalizado |
| ---------------- | -------------------------------- |
| `*System_01*`    | `*Cuarto_Frio_01*`               |
| `*Device_01*`    | `*Compresor_01*`                 |
| `*Device_02*`    | `*Compresor_02*`                 |
| `*Device_03*`    | `*Compresor_03*`                 |

