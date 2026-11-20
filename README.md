# Kairo-frontend · App móvil

Aplicación Flutter de Kairo (proyecto de Base de Datos en la Nube). Solo se
comunica con `kairo-backend`; nunca con la base de datos directamente.

## Requisitos

- Flutter 3.47.6 (la misma versión que usa el CI)
- Android 7.0 (API 24) o superior

## Configuración

La URL de la API no se escribe en el código. Se pasa al compilar con
`--dart-define`:

```bash
cp dart_defines.example.json dart_defines.json
```

Edita `dart_defines.json` con la URL del backend. Ese archivo está en
`.gitignore` y no se sube al repositorio.

| Variable  | Descripción                                         |
|-----------|-----------------------------------------------------|
| `API_URL` | URL base del backend, sin barra final (`https://…`) |

## Instalar y correr

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define-from-file=dart_defines.json
```

`build_runner` genera los archivos `*.freezed.dart` y `*.g.dart` de los modelos.
Se vuelve a correr cada vez que se crea o cambia un modelo, y los archivos
generados se suben al repositorio para que el CI no tenga que generarlos.

## Estructura

Feature-First con MVVM sobre Riverpod. Las carpetas se crean solo cuando hay
algo que poner en ellas.

```
lib/
├── app/                 widget raíz (tema, idioma y rutas)
├── core/
│   ├── api/             cliente dio, interceptores, modelos y salud del servidor
│   ├── errors/          tipos de error con mensajes en español
│   ├── router/          go_router, guard de sesión y secciones
│   ├── storage/         token en flutter_secure_storage y estado de la sesión
│   ├── theme/           colores, tipografía Inter y espaciado (claro y oscuro)
│   └── widgets/         componentes compartidos del sistema de diseño
└── features/
    └── <feature>/
        ├── data/        llamadas a la API y modelos
        ├── domain/      entidades y reglas
        └── presentation/ pantallas, widgets y providers
```

- **Sesión:** el token se guarda solo en `flutter_secure_storage`. El
  interceptor lo agrega como `Authorization: Bearer` y, si el backend responde
  401 a una petición con token, borra la sesión y la app regresa al inicio de
  sesión.
- **Guard de rutas:** sin sesión solo se puede ver el inicio de sesión; con
  sesión se abren las cinco secciones (Inicio, Actividades, Tiempo, Metas y Más).
- **Errores:** cada error de red se convierte en un `AppException` con un
  mensaje en español. Si el backend manda `detalle`, se muestra ese texto.
- **Idioma:** textos de interfaz y formatos de fecha en español de México
  (`es_MX`).

## Verificación de código y CI

Antes de abrir un PR, corre en local:

```bash
dart format .
flutter analyze
flutter test
```

El workflow `.github/workflows/ci.yml` corre estos mismos pasos en cada PR hacia
`main` y `develop`. Si el código no está formateado, tiene avisos de análisis o
alguna prueba falla, el PR no se puede mergear. Las pruebas corren sin emulador.

## Cómo contribuir

- Ramas desde `develop`: `feat/txx-nombre`, `fix/txx-nombre` o `docs/txx-nombre`.
- Commits en formato convencional.
- Un PR por issue, enlazado con `Closes #n`, aprobado por otra persona.
- No subir secretos, tokens ni contraseñas; todo por variables de entorno.

## Créditos

Tipografía [Inter](https://github.com/rsms/inter), bajo licencia SIL Open Font
License 1.1 (`assets/fonts/OFL.txt`).
