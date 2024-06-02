# cinemapedia

# Dev

1. Copiar el .env.template y renombrarlo a .env
2. Cambiar las variables de entorno (The MovieDB)
3. Cambios en la entidad, hay que ejecutar el comando
```
flutter pub run build_runner build
```

# Prod
Para cambiar el nombre de la app:
```
flutter pub run change_app_package_name:main com.new.package.name
flutter pub run change_app_package_name:main com.josedeveloper.cinemapedia
```

## Pasos para subir a Play Store

1. Cambiar el nombre del paquete de la app
   1. añadir `change_app_package_name: ^1.1.0` al dev_dependencies en el archivo `pubspec.yaml`
   2. Ejecutar el comando `flutter pub run change_app_package_name:main com.<new.package>.name`
2. Cambiar el ícono de la app:
   - Crear un ícono en [appicon](https://appicon.co/)
   - [bing](https://www.bing.com/images/create)