# Partsflow 🛠️🚗
**Sistema de Gestión de Pedidos de Autopartes**

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20Layered-green?style=for-the-badge)
![Testing](https://img.shields.io/badge/Testing-Unit%20%26%20Widget-orange?style=for-the-badge)

## 📖 Descripción General

**Partsflow** es una aplicación móvil robusta desarrollada en Flutter, diseñada para revolucionar la gestión logística de proveedores de autopartes. La aplicación implementa una metodología **Kanban** para visualizar y administrar el ciclo de vida de los pedidos, desde su creación hasta su entrega, facilitando la toma de decisiones rápida y eficiente.

El objetivo principal es eliminar la fricción en el seguimiento de pedidos, proporcionando una interfaz limpia, actualizaciones en tiempo real y una experiencia de usuario fluida y segura.

---

## 🚀 Características Clave y Funcionalidades

### 1. Tablero Kanban Interactivo
El corazón de la aplicación es su tablero Kanban, que permite:
*   **Visualización Inteligente:** Los pedidos se renderizan como "tarjetas" con información crítica (ID del pedido, Cliente, Vehículo, Fecha).
*   **Códigos de Color:** Priorización visual mediante colores (Oro, Plata, Bronce) según la categoría del cliente o urgencia.
*   **Filtrado Avanzado:** Capacidad de filtrar pedidos por Estado (Ej. "Cotizado", "En Proceso") o criterio de ordenamiento (Fecha, Prioridad).
*   **Actualización Automática:** "Polling" inteligente cada 5 segundos para asegurar que el inventario y los estados estén siempre sincronizados con el servidor.

### 2. Gestión de Seguridad y Sesión (Persistencia)
*   **Login Seguro:** Autenticación robusta contra una API RESTful.
*   **Auto-Login (Persistencia):** Implementación de `shared_preferences` para almacenar tokens de sesión cifrados y datos de perfil. El usuario no necesita loguearse cada vez que abre la app.
*   **Manejo de Sesión:** Opción de "Cerrar Sesión" fácilmente accesible desde el menú lateral (Drawer), limpiando de forma segura los datos locales.

### 3. Detalles de Pedido Profundos
*   **Vista Detallada:** Al seleccionar una tarjeta, se accede a una vista profunda con:
    *   **Datos del Cliente:** Nombre, Rut, Dirección completa.
    *   **Datos del Vehículo:** Marca, Modelo, Año, Patente.
    *   **Lista de Productos:** Desglose itemizado de repuestos solicitados con cantidades y precios.

### 4. Creación de Pedidos
*   **Formularios Validados:** Interfaz para crear nuevos pedidos con validación de campos en tiempo real para asegurar la integridad de los datos antes de enviarlos al servidor.
*   **Integración con API:** Envío de datos POST a endpoints seguros.

### 5. Experiencia de Usuario (UX)
*   **Navegación Fluida:** Transiciones suaves entre pantallas gestionadas por `go_router`.
*   **Feedback Híptico:** Uso del motor de vibración del dispositivo para alertar al usuario sobre errores (ej. credenciales inválidas) sin necesidad de leer.
*   **Menú de Acceso Rápido:** Botón flotante (Speed Dial) para acciones rápidas como "Crear Nuevo Pedido".

---

## 🏗️ Arquitectura y Diseño Técnico

El proyecto sigue una **Arquitectura en Capas (Layered Architecture)** estricta para garantizar la escalabilidad, testabilidad y mantenibilidad del código.

### Diagrama de Capas
1.  **Presentation Layer (UI):** Pantallas y Widgets. No contiene lógica de negocio compleja.
2.  **Domain/Service Layer:** Lógica de negocio, orquestación de llamadas y manejo de estado de sesión.
3.  **Data Layer:** Modelos de datos (DTOs), repositorios y comunicación pura con la API.

### Estructura de Directorios (`/lib`)

```
lib/
├── core/                       # Núcleo de la aplicación
│   ├── colors/                 # Paleta de colores centralizada (PartsflowColors)
│   ├── components/             # Widgets reutilizables (Inputs, Botones)
│   ├── globals/                # Variables globales y de entorno (Env)
│   └── utils/                  # Funciones utilitarias
├── data/                       # Capa de Datos
│   └── models/                 # Modelos serializables (JSON <-> Dart)
│       ├── users/              # Modelo de Usuario
│       ├── order/              # Modelo de Pedido y Productos
│       └── clients/            # Modelo de Cliente
├── screens/                    # Capa de Presentación (Vistas)
│   ├── login/                  # Pantalla de Login
│   └── orders/                 # Flujo de Pedidos
│       ├── kanban/             # Tablero Kanban y Widgets
│       └── create_order/       # Formulario de Creación
├── services/                   # Capa de Lógica y Servicios
│   ├── auth_service.dart       # Gestión de Autenticación
│   ├── user_service.dart       # Lógica de Usuario y Perfil
│   ├── local_storage_service.dart # Servicio de Persistencia Local
│   ├── orders_service.dart     # Lógica de Pedidos
│   └── ...
└── main.dart                   # Punto de entrada y Configuración de Rutas
```

---

## 🛠️ Stack Tecnológico

*   **Framework:** [Flutter](https://flutter.dev/) (UI Toolkit de Google).
*   **Lenguaje:** [Dart](https://dart.dev/) (Optimizado para UI).
*   **Navegación:** `go_router` (Manejo de rutas declarativo y deep linking).
*   **Red (Networking):** `http` (Cliente REST ligero).
*   **Persistencia:** `shared_preferences` (Almacenamiento Clave-Valor para sesión).
*   **UI Components:** `flutter_speed_dial` (FAB expandible), `dropdown_search`.
*   **Nativo:** `vibration` (Feedback háptico) `Wifi` (Conexión a internet).
*   **Variables de Entorno:** `flutter_dotenv` (Gestión segura de configuración).
*   **Testing:** `flutter_test`, `mocktail` (Mocking de dependencias).

---

## 🧪 Estrategia de Testing y Calidad

El proyecto prioriza la estabilidad mediante una suite de pruebas automatizadas:

### 1. Pruebas Unitarias (Unit Tests)
Validan la lógica de negocio aislada. Se utilizan **Mocks** (`mocktail`) para simular la API y el almacenamiento local.
*   **Archivos Clave:** `user_service_test.dart`, `client_service_test.dart`, `orders_service_test.dart`.
*   **Cobertura:** Verificación de códigos de estado HTTP (200, 400, 401, 500), parseo de JSON y manejo de excepciones.

### 2. Pruebas de Widget (Widget Tests)
Verifican que la UI se renderice correctamente y responda a las interacciones.
*   **Enfoque:** Simulación de taps, scrolls y entrada de texto. Verificación de presencia de widgets.
*   **Archivos Clave:** `login_screen_test.dart`, `kanban_orders_screen_test.dart`.

**Comando para ejecutar pruebas:**
```bash
flutter test
```

---

## 📲 Guía de Inicio Rápido (Instalación)

Sigue estos pasos para levantar el entorno de desarrollo:

### Prerrequisitos
*   Git instalado.
*   Flutter SDK (v3.x o superior).
*   Android Studio o VS Code configurado.

### Pasos
1.  **Clonar el Repositorio**
    ```bash
    git clone https://github.com/tu-usuario/partsflow.git
    cd partsflow
    ```

2.  **Configurar Entorno**
    Crea un archivo `.env` en la raíz del proyecto para definir la URL de la API:
    ```env
    PARTSFLOW_API_URL=https://api-staging.partsflow.com
    ```

3.  **Instalar Dependencias**
    Descarga las librerías necesarias definidas en `pubspec.yaml`:
    ```bash
    flutter pub get
    ```

4.  **Ejecutar la Aplicación**
    Inicia la app en tu emulador o dispositivo conectado:
    ```bash
    flutter run
    ```
    *(Nota: Asegurate de tener un dispositivo Android/iOS corriendo)*

---

## 👥 Autor

Este proyecto es mantenido por el equipo de desarrollo de Partsflow.
*   **Franco Carraco**


---
© 2024 Partsflow. Todos los derechos reservados.
