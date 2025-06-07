import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    // Include other languages as well, because it will otherwise not build.
    implementation("com.google.mlkit:text-recognition-chinese:16.0.1")
    implementation("com.google.mlkit:text-recognition-devanagari:16.0.1")
    implementation("com.google.mlkit:text-recognition-japanese:16.0.1")
    implementation("com.google.mlkit:text-recognition-korean:16.0.1")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "nl.reneax.statiescan"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "nl.reneax.statiescan"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (project.hasProperty("keyAlias") &&
                project.hasProperty("keyPassword") &&
                project.hasProperty("storeFile") &&
                project.hasProperty("storePassword")
            ) {
                keyAlias = project.property("keyAlias") as String
                keyPassword = project.property("keyPassword") as String
                storeFile = file(project.property("storeFile") as String)
                storePassword = project.property("storePassword") as String
            }
        }
    }

    buildTypes {
        getByName("release") {
            val signingConfig = signingConfigs.findByName("release")

            if (signingConfig?.keyAlias != null) {
                this.signingConfig = signingConfig
            } else {
                println("No signing properties provided. Build will be unsigned.")
            }
        }
    }
}

flutter {
    source = "../.."
}
