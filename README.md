# cinemapedia

Puntualmente veremos:

1. Datasources
    - Abastracciones
    - Implementaciones

2. Repositorios
    - Abstracciones
    - Implementaciones

3. Modelos
   
4. Entidades
   
5. Riverpod
    - Provider
    - StateNotifierProvider
    - Notifiers

6. Mappers

## Conceptos
- Entidades: Son los objetos que representan los datos de la aplicación. Por ejemplo, una película, un actor, un director, etc. Entidades son atómicas. Relgas de negocio
- DataSources: Son las fuentes de datos de la aplicación. Por ejemplo, una base de datos, una API, un archivo, etc.
- Repositorios: Son los objetos que se encargan de obtener los datos de las fuentes de datos y devolverlos en forma de entidades.
- Mappers: Son los objetos que se encargan de transformar los datos de las fuentes de datos en entidades.
- Modelos: Son los objetos que representan los datos de la aplicación y que se utilizan para mostrar la información en la interfaz de usuario.
- Gestores de estado: Son los objetos que se encargan de gestionar el estado de la aplicación y de notificar a los componentes de la interfaz de usuario cuando el estado cambia.

## Estrucutra de carpetas

```
lib/
├── config/
│   ├── constants/
│   ├── router/
│   └── theme/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── datasources/
│
├── infrastructure/
│   ├── datasources/
│   ├── mappers/
│   ├── models/
│   └── repositories/
│
├── presentation/
│   ├── screens/
│   ├── widgets/
│   └── providers/
|
└── main.dart
```

## Jerarquía de importación

1. paquetes de dart
2. paquetes de material
3. paquetes de terceros
4. paquetes locales
# Dev

1. Copiar el .env.template y renombrarlo a .env
2. Cambiar las variables de entorno (The MovieDB)


## Source

- [Entities](https://gist.github.com/Klerith/aed8b1ad2f33dd7cb4cfeceab738ec74)
- [model](https://gist.github.com/Klerith/0fb41b8da98d66ab4415c89d7bf438a4)