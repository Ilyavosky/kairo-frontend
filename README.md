# Kairo-frontend · App móvil

Aplicación Flutter de Kairo (proyecto de Base de Datos en la Nube).

## Requisitos

- Flutter 3.47.6 (la misma versión que usa el CI)

## Instalar y correr

```bash
flutter pub get
flutter run
```

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