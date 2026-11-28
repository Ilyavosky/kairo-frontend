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

Edita `dart_defines.json` con la URL del backend y el usuario del bot. Ese archivo está en
`.gitignore` y no se sube al repositorio.

| Variable       | Descripción                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `API_URL`      | URL base del backend, sin barra final (`https://…`)                         |
| `TELEGRAM_BOT` | Usuario del bot de Telegram sin `@`. Si falta, la app muestra el código para enviarlo a mano |

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
  mensaje en español. Si el backend manda `detalle`, se muestra ese texto,
  salvo en los errores de validación de campos (`codigo: validacion`), que
  traen un detalle técnico y se cambian por un mensaje general. El límite de
  solicitudes (429) tiene su propio aviso.
- **Reportes:** en Más → Reportes, con gráficas hechas con `fl_chart`: carga
  por materia, entregas contra descanso, progreso de metas y el resumen
  redactado. El resumen se pide una vez por sesión para respetar el límite del
  backend.
- **Eventos:** la agenda de Inicio muestra los eventos personales (clase,
  examen, entrega, reunión o personal). Se crean con **Agregar evento** y se
  editan tocándolos en la agenda.
- **Etiquetas:** al editar una actividad se le pueden asignar etiquetas
  existentes, crear nuevas o quitarlas.
- **Mi cuenta:** se abre desde el ícono de perfil y muestra el nombre, el
  correo, la zona horaria y el estado de Telegram.
- **Zona horaria:** la app usa la hora del teléfono para decidir el día y la
  semana actuales en la agenda y en los reportes, mientras que el backend usa
  la zona de la cuenta. Las dos deben coincidir; la zona de la cuenta se ve en
  Mi cuenta y por ahora no se puede cambiar desde la app.
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

## Regresión en teléfono real

Antes de la entrega se hace una pasada completa en un teléfono Android real con
la lista de [`docs/regresion.md`](docs/regresion.md). Cada error encontrado se
abre como issue con la etiqueta `bug`.

## Pendientes conocidos

Lo siguiente queda aplazado de forma explícita para después de la entrega:

| Pendiente | Motivo |
|---|---|
| Desvincular Telegram desde la app | El backend todavía no tiene un endpoint para quitar la vinculación |
| `/reportes/pipeline` y `/capturas/metricas` | Opcionales; la app no los usa |
| Notificaciones push y modo sin conexión (T48) | Opcional |
| Actualizaciones mayores de dependencias (`freezed` 4, `flutter_secure_storage` 11, `flutter_timezone` 5, `cupertino_icons` 2, `actions/checkout` 7) | Cambian código generado o APIs; se evalúan después del congelamiento |
| Firma del APK con llave propia | El APK de la demo se firma con la llave de debug; la llave propia se configura fuera del repositorio |

Los errores que se encuentren en la regresión y no se corrijan antes de la
demo se agregan a esta tabla con su issue.

## Cómo contribuir

- Ramas desde `develop`: `feat/txx-nombre`, `fix/txx-nombre` o `docs/txx-nombre`.
- Commits en formato convencional.
- Un PR por issue, enlazado con `Closes #n`, aprobado por otra persona.
- No subir secretos, tokens ni contraseñas; todo por variables de entorno.

## Créditos

Tipografía [Inter](https://github.com/rsms/inter), bajo licencia SIL Open Font
License 1.1 (`assets/fonts/OFL.txt`).
