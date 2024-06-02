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
- [Android](https://developer.android.com/studio/publish/upload-bundle?hl=es-419)

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
   1. Instala `flutter_native_splash: ^1.2.0` (dev_dependencies) [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
   2. Configurar el archivo `pubspec.yaml`:
    ```yml
    flutter_native_splash:
        color: "#42a5f5"
        image: "assets/icons/splash.png"
        android: true
        ios: true
    ```
    3. Ejecutar el comando `dart run flutter_native_splash:create`

4. Build and release an Android app
   - [Build and release an Android](https://docs.flutter.dev/deployment/android)
    1. Ejecutar comando(en windows): 
       - `keytool -genkey -v -keystore C:\Users\<user>\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload` se puede colocar cualquier nombre en lugar de `upload-keystore.jks`
       - un warning The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using `keytool -importkeystore -srckeystore C:\Users\<user>\upload-keystore.jks -destkeystore C:\Users\<user>\upload-keystore.jks -deststoretype pkcs12`
        
    2. Configurar el archivo `android/key.properties`:
        ```properties
        storePassword=<password-from-previous-step>
        keyPassword=<password-from-previous-step>
        keyAlias=upload
        storeFile=<keystore-file-location>
        ```
        - la ruta del archivo `keystore` debe ser absoluta y si está en windows se debe colocar la ruta con `/` en lugar de `\`. 
    
    3. Configurar el archivo `android/app/build.gradle`:
        ```gradle

        def keystoreProperties = new Properties()
        def keystorePropertiesFile = rootProject.file('key.properties')
        if (keystorePropertiesFile.exists()) {
            keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
        }

        android {
            ...
        }

        .
        .
        .
        
        signingConfigs {
            release {
                keyAlias keystoreProperties['keyAlias']
                keyPassword keystoreProperties['keyPassword']
                storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
                storePassword keystoreProperties['storePassword']
            }
        }

        buildTypes {
            release {
                // TODO: Add your own signing config for the release build.
                // Signing with the debug keys for now, so `flutter run --release` works.
                // signingConfig signingConfigs.debug
                signingConfig signingConfigs.release
            }
        }
        ```
4. Otros pasos en [deployment](https://docs.flutter.dev/deployment/android)

5. Crear el App Bundle (creara un archivo .aab que se subira a Play Store)
   - `flutter build appbundle`