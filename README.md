# Partsflow - Automotive Parts Order Management System

## 1. Descripción General del Proyecto

Partsflow es una aplicación móvil diseñada para optimizar la gestión de pedidos de autopartes a través de un flujo de trabajo estilo Kanban. La aplicación aborda el desafío de coordinar la ejecución de pedidos, la comunicación con el cliente y el seguimiento del inventario para proveedores de autopartes. Esta interfaz móvil funcional, desarrollada en Flutter, permite a los usuarios ver y filtrar pedidos por estado, monitorear información detallada de pedidos incluyendo datos del cliente y especificaciones del vehículo, y rastrear el ciclo de vida completo del pedido con actualizaciones en tiempo real.

## 2. Aprendizajes Clave y Requisitos Demostrados

### Diseño Visual
*   **Interfaz Estructurada:** Implementa diseños basados en tarjetas con una clara jerarquía visual utilizando categorías codificadas por colores (oro, plata, bronce, papelera).
*   **Navegación:** Enrutamiento declarativo usando `go_router` con tres rutas principales: inicio de sesión, pedidos Kanban y detalles del pedido.
*   **Principios de Usabilidad:** Filtros desplegables, etiquetas de clasificación y visualización intuitiva de pedidos basada en tarjetas.
*   **Material Design:** Utiliza componentes de Material (Scaffold, AppBar, TextField, ElevatedButton).
*   ⚠️ **Nota:** El tema de Material 3 no está configurado explícitamente.

### Formularios y Validación
*   **Implementación Actual:** Formulario de inicio de sesión con campos de correo electrónico y contraseña, incluye íconos.
*   **Retroalimentación:** Notificaciones `SnackBar` para estados de éxito/error.
*   ⚠️ **Limitación:** La lógica de validación no está desacoplada de los componentes de la UI, está incrustada directamente en los métodos de la pantalla.
*   **Pendiente:** Validación en tiempo real por campo con mensajes de error debajo de los campos.

### Navegación Funcional
*   **Configuración de Rutas:** Flujo de navegación de tres niveles desde inicio de sesión → pedidos Kanban → detalles del pedido.
*   **Métodos de Navegación:** Utiliza `context.go()` para el reemplazo de rutas y `context.push()` para la navegación de pila.
*   **Paso de Parámetros:** Parámetros de ruta con tipado seguro (ej. extracción de ID de pedido).

### Gestión de Estado
*   **Implementación:** `StatefulWidget` integrado de Flutter con `setState()`.
*   **Seguimiento de Estado:** Estado de inicio de sesión (`_isLogin`), listas de pedidos, estados de filtro y preferencias de ordenación.
*   **Actualizaciones en Tiempo Real:** Actualización automática de pedidos cada 5 segundos usando `Timer.periodic`.
*   **Consistencia de la UI:** Los cambios de estado activan actualizaciones inmediatas de la UI a través de `setState()`.

### Almacenamiento Local (Persistencia)
*   ❌ **Estado: NO IMPLEMENTADO.**
*   **Enfoque Actual:** La aplicación depende completamente de las llamadas a la API para la recuperación de datos.
*   **Pendiente:** No hay uso de `shared_preferences`, `sqflite`, `hive` o paquetes de persistencia similares.

### Recursos Nativos del Dispositivo
La aplicación integra dos recursos nativos:

1.  **Acceso a Internet**
    *   **Permiso:** `<uses-permission android:name="android.permission.INTERNET"/>` en `AndroidManifest.xml`.
    *   **Implementación:** Peticiones HTTP a través del paquete `http` (v1.5.0).
    *   **Uso:** Comunicación API en servicios como `KanbanService.getKanbanOrders()` y `SupplierCarService.getClientCar()`.

2.  **Vibración**
    *   **Permiso:** `<uses-permission android:name="android.permission.VIBRATE"/>` en `AndroidManifest.xml`.
    *   **Implementación:** Paquete `vibration` (v3.1.0).
    *   **Uso:** Retroalimentación háptica en errores de inicio de sesión (vibración de 500ms).

### Animaciones
*   ⚠️ **Implementación Actual:** Retroalimentación háptica (vibración) para estados de error.
*   **Pendiente:** Animaciones visuales como transiciones, spinners de carga, efectos de botones o cambios de estado suaves.
*   **Estados de Carga:** Actualmente se muestra texto estático ("Cargando Pedidos") en lugar de indicadores animados.

## 3. Arquitectura y Estructura del Proyecto

### Patrón Arquitectónico: Arquitectura de Tres Capas
El proyecto sigue una arquitectura por capas con una clara separación de responsabilidades:

```
lib/
├── screens/ # Capa de Presentación (UI)
├── services/ # Capa de Servicios (Lógica de Negocio y API)
├── data/
│ └── models/ # Capa de Datos (Modelos de Dominio)
├── core/
│ ├── components/ # Widgets Reutilizables
│ ├── colors/ # Constantes de Tema
│ ├── globals/ # Configuración (Env, Globales)
│ └── utils/ # Funciones de Ayuda
```

### Componentes Clave

1.  **`Screens` (Capa de Presentación)**
    *   `LoginScreen`: Interfaz de autenticación.
    *   `KanbanOrdersScreen`: Lista principal de pedidos con filtros.
    *   `KanbanOrderDetailsScreen`: Vista detallada del pedido.

2.  **`Services` (Lógica de Negocio)**
    *   `KanbanService`: Recupera pedidos Kanban de la API.
    *   `SupplierCarService`: Recupera detalles del vehículo.
    *   Maneja la comunicación HTTP, el análisis de respuestas y el manejo de errores.

3.  **`Models` (Capa de Datos)**
    *   `OrderRepository`: Modelo base de pedido con 56 campos.
    *   `KanbanOrderRepository`: Modelo extendido con detalles anidados de cliente/coche.
    *   `ClientRepository`: Modelo de información del cliente.
    *   `ClientCarCarRepository`: Detalles del vehículo con especificaciones del coche.

4.  **`Configuration`**
    *   `Env`: Lee variables de entorno del archivo `.env` (URLs de API).
    *   `Globals`: Gestiona el estado en tiempo de ejecución (tokens de autenticación).

### Justificación Arquitectónica
La arquitectura de tres capas proporciona:
*   **Separación de Responsabilidades:** La UI, la lógica de negocio y los datos están aislados.
*   **Capacidad de Prueba:** Cada capa puede probarse independientemente.
*   **Mantenibilidad:** Los cambios en una capa no se propagan a otras.
*   **Escalabilidad:** Fácil de añadir nuevas características o modificar las existentes.

### Control de Versiones y Colaboración
*   **GitHub:** [Repository URL - *Añadir enlace a tu repositorio público aquí*]
*   **Gestión de Proyectos:** [Trello board link o herramienta alternativa - *Añadir enlace o descripción aquí*]

## 4. Instrucciones de Instalación y Ejecución

### Prerrequisitos
*   Flutter SDK ≥3.9.0
*   Dart SDK ≥3.9.0 <4.0.0
*   Android Studio o VS Code con extensiones de Flutter
*   Emulador de Android o dispositivo físico

### Pasos de Configuración
1.  **Clonar el repositorio:**
    ```bash
    git clone [YOUR_REPOSITORY_URL]
    cd partsflow
    ```
2.  **Crear archivo de entorno:**
    Crea un archivo `.env` en la raíz del proyecto:
    ```
    PARTSFLOW_URL=https://your-api-url.com
    ```
3.  **Instalar dependencias:**
    ```bash
    flutter pub get
    ```
4.  **Ejecutar la aplicación:**
    ```bash
    flutter run
    ```

### Dependencias Clave
*   `go_router` (v14.8.1): Navegación.
*   `http` (v1.5.0): Comunicación API.
*   `flutter_dotenv` (v5.2.1): Configuración de entorno.
*   `vibration` (v3.1.0): Retroalimentación háptica.

## 5. Guía para la Demostración (Lista de Verificación de Presentación)

### 1. Configuración del Entorno
*   ✅ Abrir el proyecto en el IDE.
*   ✅ Mostrar la configuración de `.env`.
*   ✅ Ejecutar `flutter pub get`.
*   ✅ Iniciar en emulador/dispositivo.
*   ✅ Verificar el inicio exitoso.

### 2. Estructura y Arquitectura
*   ✅ Explicar la arquitectura de tres capas (Screens → Services → Models).
*   ✅ Mostrar la organización de carpetas (`lib/screens/`, `lib/services/`, `lib/data/models/`).
*   ✅ Demostrar la separación de responsabilidades con ejemplos de código.
*   ✅ Explicar la configuración de enrutamiento en `main.dart`.

### 3. Diseño Visual y Usabilidad
*   ✅ Mostrar el flujo de navegación (Login → Kanban → Detalles).
*   ✅ Demostrar la jerarquía visual con tarjetas de pedido codificadas por colores.
*   ✅ Explicar la funcionalidad de filtro y clasificación.
*   ⚠️ **Nota:** El tema de Material 3 no está configurado explícitamente.

### 4. Formularios y Validación
*   ✅ Mostrar el formulario de inicio de sesión con campos de correo electrónico/contraseña.
*   ✅ Demostrar la retroalimentación de errores con `SnackBar`.
*   ⚠️ **Limitación:** La lógica de validación no está desacoplada de la UI.

### 5. Gestión de Estado y Respuesta Visual
*   ✅ Explicar el patrón `StatefulWidget` con `setState()`.
*   ✅ Mostrar actualizaciones en tiempo real con sondeo cada 5 segundos.
*   ✅ Demostrar cambios de estado de filtro.

### 6. Animaciones y Retroalimentación Visual
*   ✅ Mostrar la retroalimentación háptica en errores de inicio de sesión.
*   ❌ **Faltan:** Animaciones visuales (transiciones, loaders, efectos de botones).

### 7. Persistencia Local y Modularidad
*   ❌ **NO IMPLEMENTADO:** No hay mecanismo de almacenamiento local.
*   ✅ Modularidad demostrada a través de la arquitectura por capas.

### 8. Recursos Nativos del Dispositivo
*   ✅ **Internet:** Mostrar llamadas a la API en servicios.
*   ✅ **Vibración:** Demostrar la vibración de error.
*   ✅ Mostrar permisos en `AndroidManifest.xml`.

### 9. Demostración de Modificación en Tiempo Real
*   **Modificaciones sugeridas para demostrar (estar preparado para):**
    *   Añadir validación por campo al formulario de inicio de sesión.
    *   Extraer la lógica de validación a una clase de validador separada.
    *   Añadir una animación de spinner de carga.
    *   Implementar almacenamiento local básico para preferencias de usuario.

## 6. Equipo del Proyecto

*   [Nombre del Estudiante 1] - [Rol/Contribución]
*   [Nombre del Estudiante 2] - [Rol/Contribución]

## 7. Posibles Mejoras / Retroalimentación

### Mejoras Críticas
1.  **Persistencia de Datos Local (Requerida)**
    *   **Problema:** No hay implementación de almacenamiento local.
    *   **Recomendación:** Implementar `shared_preferences`, `sqflite`, `Hive`, `Isar` o similar para almacenar datos localmente.

### Otras Mejoras
*   **Desacoplamiento de Lógica de Validación:** Mover la lógica de validación de los formularios a clases o métodos separados para mejorar la modularidad y la capacidad de prueba.
*   **Animaciones Visuales:** Integrar animaciones para transiciones, estados de carga (spinners), efectos de botones o retroalimentación visual de cambios de estado para mejorar la experiencia del usuario.
*   **Temas de Material 3:** Configurar explícitamente el tema de Material 3 para aprovechar las últimas guías de diseño de Android.
*   **Gestión de Estado Centralizada:** Considerar soluciones de gestión de estado más robustas como Provider, Riverpod, BLoC o GetX para una aplicación de mayor escala, lo que podría simplificar las actualizaciones de UI y el manejo de datos.```
