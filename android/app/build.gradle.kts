plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // Flutter Gradle Plugin harus selalu di-load terakhir
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ocr_sederhana_nadyne"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        // Ganti Application ID sesuai project kamu
        applicationId = "com.example.ocr_sederhana_nadyne"
        minSdk = flutter.minSdkVersion         // ← min SDK diset ke 21 biar aman buat MLKit
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true  // ← penting untuk MLKit yang library-nya besar
    }

    buildTypes {
    getByName("release") {
        isMinifyEnabled = false
        isShrinkResources = false
        signingConfig = signingConfigs.getByName("debug")
        }
    }


    // Tambahkan ini supaya kompatibel dengan plugin lama yang belum define namespace
    lint {
        checkReleaseBuilds = false
        abortOnError = false
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Pastikan dependensi berikut ada
    implementation("androidx.multidex:multidex:2.0.1")
}
