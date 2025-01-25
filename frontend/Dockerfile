# Étape de base commune
FROM flutter:stable AS base

WORKDIR /app

# 1. Copier les fichiers de dépendances (optimisation du cache Docker)
COPY pubspec.yaml pubspec.lock ./

# 2. Récupérer les dépendances Dart/Flutter
RUN flutter pub get

# 3. Copier tout le code source (après les dépendances pour le cache)
COPY . .

# ========= BUILD WEB =========
FROM base AS web-build
RUN flutter build web --release

# ========= BUILD WINDOWS =========
FROM base AS windows-build

# Installer les dépendances pour Windows
RUN apt-get update && \
    apt-get install -y \
        clang \
        cmake \
        ninja-build \
        pkg-config \
        libgtk-3-dev

# Activer le support Windows et builder
RUN flutter config --enable-windows-desktop
RUN flutter build windows --release

# ========= BUILD ANDROID =========
FROM base AS android-build

# Accepter les licences Android et installer les outils
RUN yes | sdkmanager --licenses && \
    flutter doctor --android-licenses

# Builder l'APK Android
RUN flutter build apk --release

# ========= ÉTAPE DE SORTIE =========
FROM alpine:latest AS output

WORKDIR /build_output

# Copier les artefacts de build
COPY --from=web-build /app/build/web ./web
COPY --from=windows-build /app/build/windows ./windows
COPY --from=android-build /app/build/app/outputs/apk/release/app-release.apk ./android/

# Optionnel : serveur web pour tester les builds
RUN apk add --no-cache python3
EXPOSE 8000

CMD ["python3", "-m", "http.server", "--directory", "/build_output", "8000"]
