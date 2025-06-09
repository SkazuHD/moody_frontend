# Kotlin Serialization (falls benötigt)
-if @kotlinx.serialization.Serializable class **
-keepclassmembers class <1> {
    static <1>$Companion Companion;
}

# Just Audio Plugin
-keep class com.ryanheise.just_audio.** { *; }
-keep class com.ryanheise.audio_session.** { *; }

# Hardware-Beschleunigung native Methoden
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}

# Minimale ExoPlayer-Komponenten für HTTP-Streaming
-keep class com.google.android.exoplayer2.source.ProgressiveMediaSource { *; }
-keep class com.google.android.exoplayer2.upstream.DefaultHttpDataSource { *; }
-keep class com.google.android.exoplayer2.upstream.DefaultDataSource { *; }

# Flutter Plugin-Kommunikation (essentiell)
-keep class io.flutter.plugin.common.StandardMethodCodec { *; }
-keep class io.flutter.plugin.common.MethodChannel { *; }

# Debugging-Hilfe - kann entfernt werden, wenn alles stabil funktioniert
-keepattributes SourceFile,LineNumberTable
