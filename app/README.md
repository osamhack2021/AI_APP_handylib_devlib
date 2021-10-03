# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Flutter 프로젝트 생성 및 테스트

아래 명령으로 `myapp` 프로젝트를 생성하고, 테스트를 위해 웹 앱 형태로 실행합니다.
```bash
flutter create myapp
cd myapp
flutter run -d web-server --web-hostname=0.0.0.0 
``` 

본 저장소를 활용하여 생성된 Codespace 에는 Android SDK 도 같이 설정되어 있습니다.
별도 추가적인 절차 없이, 아래 명령줄로 Android 앱 APK 파일을 빌드할 수 있습니다.
```bash
flutter build apk
```

Flutter 프로젝트 개발환경 구축, 앱 개발, 빌드 테스트 등에 관한 자세한 사항은, 별도로 전달 받으신 가이드 문서와 [Flutter 공식 문서](https://flutter.dev/)를 참고해 주시기 바랍니다.
