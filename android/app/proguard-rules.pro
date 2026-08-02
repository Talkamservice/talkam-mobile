# SLF4J's binding classes are resolved reflectively at runtime; when no
# concrete logger (slf4j-simple, logback, etc.) is on the classpath, SLF4J
# just no-ops instead of throwing. R8 can't see that fallback statically, so
# without this rule it treats the missing reference as a build error.
-dontwarn org.slf4j.impl.StaticLoggerBinder
