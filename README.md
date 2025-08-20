# plant_plan

식물 관리 Flutter 애플리케이션

## 🚀 Getting Started

### 1. 개발 환경 설정

```bash
# Flutter SDK 설치 확인
flutter doctor

# 의존성 설치
flutter pub get
```

### 2. 보안 파일 설정 (필수)

이 프로젝트는 보안상 민감한 파일들을 별도 관리합니다.

#### 📁 디렉토리 구조
```
project_root/
├── secrets/                    # 🔐 로컬 전용 디렉토리
│   ├── android/
│   │   └── google-services.json     # Firebase Android 설정
│   ├── ios/
│   │   └── GoogleService-Info.plist # Firebase iOS 설정
│   ├── keys/
│   │   ├── upload-keystore.jks      # Android 릴리즈 키스토어
│   │   └── upload_certificate.pem   # 인증서 파일
│   └── .env.local                   # 환경변수 파일
└── scripts/
    └── copy-secrets.sh              # 빌드 전 파일 복사 스크립트
```

#### 🔧 초기 설정 단계

1. **환경변수 파일 생성**
```bash
cp .env.example .env.local
# .env.local 파일을 열어 실제 값으로 수정
```

2. **Firebase 설정 파일 배치**
- Firebase Console에서 `google-services.json` 다운로드
- `secrets/android/` 디렉토리에 배치
- iOS용 `GoogleService-Info.plist`도 `secrets/ios/`에 배치

3. **키스토어 파일 배치**
- Android 릴리즈용 키스토어 파일을 `secrets/keys/`에 배치
- 관련 인증서 파일도 동일 디렉토리에 배치

#### 🛠️ 빌드 전 준비

```bash
# 보안 파일들을 적절한 위치로 복사
./scripts/copy-secrets.sh

# 빌드 실행
flutter build apk --release
```

### 3. 개발 가이드

#### 주요 기능
- 식물 관리 및 일정 알림
- Firebase 인증 및 데이터베이스
- 이미지 업로드 및 관리
- 푸시 알림

#### 프로젝트 구조
```
lib/
├── add/          # 식물 추가 기능
├── common/       # 공통 컴포넌트
├── diary/        # 다이어리 기능
├── list/         # 식물 목록 관리
├── my_page/      # 사용자 프로필
├── services/     # 외부 서비스 연동
└── utils/        # 유틸리티 함수
```

## 🔐 보안 주의사항

- **절대 보안 파일을 Git에 커밋하지 마세요**
- `secrets/` 디렉토리의 모든 파일은 .gitignore에 의해 제외됩니다
- 새로운 팀원은 기존 팀원으로부터 보안 파일을 별도로 받아야 합니다
- 프로덕션 환경에서는 환경변수를 직접 설정하세요

## 🤝 팀 협업 가이드

### 새 팀원 온보딩 체크리스트

- [ ] Flutter SDK 설치 및 설정
- [ ] 프로젝트 클론
- [ ] `.env.local` 파일 생성 및 설정
- [ ] Firebase 설정 파일 배치
- [ ] 키스토어 파일 배치 (릴리즈 빌드 시)
- [ ] `./scripts/copy-secrets.sh` 실행 테스트
- [ ] 개발 서버 실행 확인

### 일반적인 개발 워크플로우

1. 개발 시작 전: `./scripts/copy-secrets.sh`
2. 코드 개발
3. 테스트 실행
4. 커밋 (보안 파일 제외 확인)
5. 푸시

## 📱 빌드 가이드

### 개발 빌드
```bash
flutter run
```

### 릴리즈 빌드
```bash
# 보안 파일 복사
./scripts/copy-secrets.sh

# Android APK 빌드
flutter build apk --release

# iOS 빌드 (macOS에서만)
flutter build ios --release
```

## 🆘 문제 해결

### 자주 발생하는 문제

1. **Firebase 설정 오류**
   - `google-services.json` 파일 위치 확인
   - 패키지명 일치 여부 확인

2. **키스토어 관련 오류**
   - `key.properties` 파일 설정 확인
   - 키스토어 파일 경로 및 패스워드 확인

3. **빌드 실패**
   - `./scripts/copy-secrets.sh` 실행 여부 확인
   - 필요한 모든 보안 파일 존재 여부 확인

