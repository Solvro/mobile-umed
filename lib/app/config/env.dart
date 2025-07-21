import "package:envied/envied.dart";

part "env.g.dart";

@Envied(path: ".env", obfuscate: true, useConstantCase: true, requireEnvFile: true)
abstract class Env {
  @EnviedField()
  static final String apiUrl = _Env.apiUrl;

  @EnviedField()
  static final String bugsinkDsn = _Env.bugsinkDsn;
  static final String wiredashProjectId = _Env.wiredashProjectId;

  @EnviedField()
  static final String wiredashSecretKey = _Env.wiredashSecretKey;
}
