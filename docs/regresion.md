# Regresión manual en teléfono real

Lista para la pasada completa antes de la entrega (T43c). Se corre con la app
instalada en un teléfono Android real, conectada al backend desplegado y con
una cuenta nueva.

Cómo instalar para la prueba:

```bash
flutter run --release --dart-define-from-file=dart_defines.json
```

Marca cada paso. Si algo falla, abre un issue con la etiqueta `bug`, indica el
paso, lo que esperabas y lo que pasó, y agrega una captura.

## Datos de la pasada

| Campo | Valor |
|---|---|
| Fecha | |
| Teléfono y versión de Android | |
| Versión de la app (commit) | |
| Persona que prueba | |

## 1. Registro e inicio de sesión

- [ ] Crear cuenta con nombre, correo, contraseña y zona horaria
- [ ] Un correo ya registrado muestra un mensaje claro, sin texto técnico
- [ ] Cerrar sesión desde Mi cuenta y volver a entrar
- [ ] Cerrar la app y abrirla de nuevo conserva la sesión
- [ ] Mi cuenta muestra el nombre, el correo y la zona horaria correctos

## 2. Materias y actividades

- [ ] Crear una materia
- [ ] Crear una actividad con materia, categoría y fecha de entrega
- [ ] La actividad aparece en Actividades y en la agenda de Inicio
- [ ] Editarla y marcarla como completada; dejar de verla en la agenda
- [ ] Un formulario vacío marca los errores sin enviar nada

## 3. Temporizador y registros de tiempo

- [ ] Iniciar el temporizador con una categoría
- [ ] Cerrar la app y abrirla: el temporizador sigue corriendo
- [ ] Detenerlo y ver el registro en la lista del día
- [ ] Crear un registro manual de sueño y otro de ejercicio
- [ ] Editar un registro sin cambiar nada no marca error

## 4. Metas

- [ ] Crear una meta de tiempo y otra de registros
- [ ] El progreso coincide con los registros hechos
- [ ] Cambiar el objetivo y desactivar una meta
- [ ] La meta desactivada aparece en el historial

## 5. Captura de texto libre

- [ ] Escribir un aviso, interpretarlo y confirmarlo; aparece en la app
- [ ] Corregir un campo antes de guardar; se guarda con la corrección
- [ ] Rechazar una propuesta
- [ ] Compartir texto desde WhatsApp o Chrome a Kairo abre la captura con el texto
- [ ] Sin servicio de interpretación se abre el formulario manual con el texto

## 6. Recordatorios y Telegram

- [ ] Vincular Telegram desde Más → Telegram; el estado cambia al volver
- [ ] Crear un recordatorio de una actividad para dentro de unos minutos
- [ ] El aviso llega al bot a la hora indicada y aparece en Enviados
- [ ] Quitar un recordatorio pendiente
- [ ] Crear una actividad desde el bot y verla en la app
- [ ] Un evento creado desde el bot aparece en la agenda de Inicio

## 7. Autoevaluación y reportes

- [ ] Evaluar la semana; al volver a entrar se edita en lugar de duplicarse
- [ ] Reportes muestra la carga por materia de la semana con el selector
- [ ] Con menos de 3 semanas de datos aparece «Necesitas más semanas de datos»
- [ ] El resumen redactado aparece o explica por qué no se pudo
- [ ] Las cifras de las gráficas coinciden con el detalle en texto

## 8. Revisión general

- [ ] Ninguna pantalla muestra texto en inglés ni mensajes técnicos
- [ ] Sin internet, cada pantalla muestra el error con Reintentar
- [ ] El teclado no tapa los campos de los formularios
- [ ] Los botones se pueden tocar con facilidad
- [ ] Una segunda cuenta no ve los datos de la primera

## Resultado

| Flujo | Resultado | Issue |
|---|---|---|
| Registro e inicio de sesión | | |
| Materias y actividades | | |
| Temporizador y registros | | |
| Metas | | |
| Captura de texto libre | | |
| Recordatorios y Telegram | | |
| Autoevaluación y reportes | | |
| Revisión general | | |
