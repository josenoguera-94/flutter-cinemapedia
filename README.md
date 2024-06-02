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

- [flutter deployment](https://docs.flutter.dev/deployment/android)

1. Cambiar el nombre del paquete de la app
   1. añadir `change_app_package_name: ^1.1.0` al dev_dependencies en el archivo `pubspec.yaml`
   2. Ejecutar el comando `flutter pub run change_app_package_name:main com.<new.package>.name`
2. Cambiar el ícono de la app, se recomienda que la imagen sea de 1024 x 1024 px:
   - Crear un ícono en [appicon](https://appicon.co/)
   - [bing](https://www.bing.com/images/create)
   1. instala `flutter_launcher_icons: ^0.13.1` para configurar los íconos [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) (dev_dependencies)

    configurar el archivo `pubspec.yaml`:
    ```yml
    flutter_launcher_icons:
        android: "launcher_icon"
        ios: true
        image_path: "assets/icons/app-icon-1.jpeg"
        min_sdk_android: 21 # default is 20
    ```
    2. Ejecutar el comando `flutter pub run flutter_launcher_icons`
3. Splash Screen:
   - `flutter_native_splash: ^1.2.0` (dev_dependencies) [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)