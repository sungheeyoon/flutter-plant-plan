#!/bin/bash

# copy-secrets.sh
# 빌드 전 보안 파일들을 적절한 위치로 복사하는 스크립트

set -e  # 에러 발생 시 스크립트 중단

echo "🔐 보안 파일 복사를 시작합니다..."

# 프로젝트 루트 디렉토리로 이동
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# secrets 디렉토리 존재 확인
if [ ! -d "secrets" ]; then
    echo "❌ secrets 디렉토리가 존재하지 않습니다."
    echo "   secrets/ 디렉토리를 생성하고 필요한 파일들을 배치해주세요."
    exit 1
fi

# Android google-services.json 복사
if [ -f "secrets/android/google-services.json" ]; then
    echo "📱 Android google-services.json 복사 중..."
    cp "secrets/android/google-services.json" "android/app/"
    echo "✅ google-services.json 복사 완료"
else
    echo "⚠️  secrets/android/google-services.json 파일이 없습니다."
fi

# iOS GoogleService-Info.plist 복사
if [ -f "secrets/ios/GoogleService-Info.plist" ]; then
    echo "🍎 iOS GoogleService-Info.plist 복사 중..."
    cp "secrets/ios/GoogleService-Info.plist" "ios/Runner/"
    echo "✅ GoogleService-Info.plist 복사 완료"
else
    echo "⚠️  secrets/ios/GoogleService-Info.plist 파일이 없습니다."
fi

# 키스토어 파일 복사
if [ -f "secrets/keys/upload-keystore.jks" ]; then
    echo "🔑 키스토어 파일 복사 중..."
    cp "secrets/keys/upload-keystore.jks" "./"
    echo "✅ upload-keystore.jks 복사 완료"
else
    echo "⚠️  secrets/keys/upload-keystore.jks 파일이 없습니다."
fi

# 인증서 파일 복사
if [ -f "secrets/keys/upload_certificate.pem" ]; then
    echo "📜 인증서 파일 복사 중..."
    cp "secrets/keys/upload_certificate.pem" "./"
    echo "✅ upload_certificate.pem 복사 완료"
else
    echo "⚠️  secrets/keys/upload_certificate.pem 파일이 없습니다."
fi

# key.properties 파일 복사 (있는 경우)
if [ -f "secrets/key.properties" ]; then
    echo "🔐 key.properties 파일 복사 중..."
    cp "secrets/key.properties" "./"
    echo "✅ key.properties 복사 완료"
else
    echo "⚠️  secrets/key.properties 파일이 없습니다."
fi

echo ""
echo "🎉 보안 파일 복사가 완료되었습니다!"
echo ""
echo "📝 참고사항:"
echo "   - 이 스크립트는 빌드 전에 실행해주세요"
echo "   - 복사된 파일들은 .gitignore에 의해 버전 관리에서 제외됩니다"
echo "   - 새로운 팀원은 secrets/ 디렉토리에 필요한 파일들을 배치해야 합니다"
echo ""