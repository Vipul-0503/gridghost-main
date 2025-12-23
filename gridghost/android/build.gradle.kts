allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val rootBuildDir = layout.buildDirectory.asFile.get().parentFile.resolve("build")
subprojects {
    project.layout.buildDirectory.set(rootBuildDir.resolve(project.name))
}

subprojects {
    afterEvaluate {
        val project = this
        if (project.extensions.findByName("android") != null) {
            val android = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
            
            android.compileSdkVersion(34)

            android.compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }

            if (android.namespace == null) {
                android.namespace = "com.gridghost.${project.name.replace("-", ".")}"
            }
        }
    }

    // THIS IS THE VERSION-PROOF FIX
    // It uses a generic "property" set to avoid the jvmTarget error entirely
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        val compiler = this
        try {
            compiler.kotlinOptions.jvmTarget = "17"
        } catch (e: Exception) {
            // Fallback for newer versions that hide jvmTarget
            compiler.setProperty("jvmTarget", "17")
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}