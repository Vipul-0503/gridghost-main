android {
    namespace "com.example.gridghost"
    compileSdkVersion 34

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = '17'
    }

    defaultConfig {
        applicationId "com.example.gridghost"
        minSdkVersion 24 
        targetSdkVersion 34
        versionCode 1
        versionName "1.0"
    }
}