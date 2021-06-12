# Finance App

Flutter project to see data of stocks

## Criação do projeto

Flutter SDK version: 2.2.2<br>
Environment SDK: ">=2.13.0 <3.0.0"

```dart
flutter create finance_app
```

## Configurações do linter

Para editar as regras do linter basta adicionar ao arquivo `analysis_options.yaml` a regra que deseja e seu valor boleano para habilitar ou desabilitar, lembrando que a lista de regras disponíveis para o Dart e Flutter se encontra no site do [Effetive Dart](https://dart.dev/guides/language/effective-dart).

## Dependências de produção

- [Flutter SVG - ^0.22.0](https://pub.dev/packages/flutter_svg)
- [GetX - ^4.1.4](https://pub.dev/packages/get)
- [Google Fonts - ^2.1.0](https://pub.dev/packages/google_fonts)
- [Lottie - ^1.0.1](https://pub.dev/packages/lottie)

## Dependências de desenvolvimento

- [Flutter Launcher Icons - ^0.9.0](https://pub.dev/packages/flutter_launcher_icons)
- [Lint - ^1.5.3](https://pub.dev/packages/lint)

## Gerando o launcher icon do aplicativo para iOS e Android

Para gerar o launcher icon para cada plataforma foi utilizado a biblioteca do [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons).
Após definir o ícone do apliticativo e coloca-lo em alguma pasta do projeto modifique o seu `pubspec.yaml`.

```dart
...

flutter_icons:
  android: true
  ios: true
  image_path: "lib/ui/assets/launcher_icon/icon.png"
```

Agora é só executar o seguinte comando no seu terminal para gerar os icones para ambas as plataformas:
`flutter pub run flutter_launcher_icons:main`

## Configurações para o Android

Aqui estarão algumas configurações relacionadas a plataforma Android.

### Alterando a sdk mínima do Android para o projeto

Alterado a minSdkVersion level para 21, essa mudança é realizada no arquivo dentro do diretório `android/app/src/build.gradle`.
```
...
minSdkVersion 21
targetSdkVersion 30
```

### Atualizando o nome do aplicativo

Para alterar o nome do seu aplicativo no Android é bem simples, basta alterar o manifest, trocando o valor do `android:label`.<br>
O arquivo se encontra no diretório `android/app/src/main/AndroidManifest.xml`.

```
...

<application
        android:label="Fi-Nance"
        android:icon="@mipmap/ic_launcher">
        ...
```

### Adicionando permissões necessárias para app

As permissões que serão necessárias pelo app também são alteras no manifest do Android, sendo incluídas acima do nível da aplicação.

`android/app/src/main/AndroidManifest.xml`
```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.finance_app">
    
    <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:label="Fi-Nance"
        ...
```

Nesse caso adicionamos a permissão para que o app utilize a internet do dispositivo.

## Configurações para o iOS


## Desenvolvedores

- [Gabriel Scotá](https://github.com/gabrielscota)