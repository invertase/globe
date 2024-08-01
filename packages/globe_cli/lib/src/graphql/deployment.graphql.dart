// ignore_for_file: type=lint
enum Enum$DeploymentStatus {
  triggered,
  build_api_error,
  github_api_error,
  queue_api_error,
  deployed,
  pending,
  queued,
  working,
  success,
  status_unknown,
  failure,
  internal_error,
  timeout,
  cancelled,
  expired,
  $unknown;

  factory Enum$DeploymentStatus.fromJson(String value) =>
      fromJson$Enum$DeploymentStatus(value);

  String toJson() => toJson$Enum$DeploymentStatus(this);
}

String toJson$Enum$DeploymentStatus(Enum$DeploymentStatus e) {
  switch (e) {
    case Enum$DeploymentStatus.triggered:
      return r'triggered';
    case Enum$DeploymentStatus.build_api_error:
      return r'build_api_error';
    case Enum$DeploymentStatus.github_api_error:
      return r'github_api_error';
    case Enum$DeploymentStatus.queue_api_error:
      return r'queue_api_error';
    case Enum$DeploymentStatus.deployed:
      return r'deployed';
    case Enum$DeploymentStatus.pending:
      return r'pending';
    case Enum$DeploymentStatus.queued:
      return r'queued';
    case Enum$DeploymentStatus.working:
      return r'working';
    case Enum$DeploymentStatus.success:
      return r'success';
    case Enum$DeploymentStatus.status_unknown:
      return r'status_unknown';
    case Enum$DeploymentStatus.failure:
      return r'failure';
    case Enum$DeploymentStatus.internal_error:
      return r'internal_error';
    case Enum$DeploymentStatus.timeout:
      return r'timeout';
    case Enum$DeploymentStatus.cancelled:
      return r'cancelled';
    case Enum$DeploymentStatus.expired:
      return r'expired';
    case Enum$DeploymentStatus.$unknown:
      return r'$unknown';
  }
}

Enum$DeploymentStatus fromJson$Enum$DeploymentStatus(String value) {
  switch (value) {
    case r'triggered':
      return Enum$DeploymentStatus.triggered;
    case r'build_api_error':
      return Enum$DeploymentStatus.build_api_error;
    case r'github_api_error':
      return Enum$DeploymentStatus.github_api_error;
    case r'queue_api_error':
      return Enum$DeploymentStatus.queue_api_error;
    case r'deployed':
      return Enum$DeploymentStatus.deployed;
    case r'pending':
      return Enum$DeploymentStatus.pending;
    case r'queued':
      return Enum$DeploymentStatus.queued;
    case r'working':
      return Enum$DeploymentStatus.working;
    case r'success':
      return Enum$DeploymentStatus.success;
    case r'status_unknown':
      return Enum$DeploymentStatus.status_unknown;
    case r'failure':
      return Enum$DeploymentStatus.failure;
    case r'internal_error':
      return Enum$DeploymentStatus.internal_error;
    case r'timeout':
      return Enum$DeploymentStatus.timeout;
    case r'cancelled':
      return Enum$DeploymentStatus.cancelled;
    case r'expired':
      return Enum$DeploymentStatus.expired;
    default:
      return Enum$DeploymentStatus.$unknown;
  }
}

enum Enum$DeploymentState {
  pending,
  working,
  deploying,
  success,
  error,
  cancelled,
  $unknown;

  factory Enum$DeploymentState.fromJson(String value) =>
      fromJson$Enum$DeploymentState(value);

  String toJson() => toJson$Enum$DeploymentState(this);
}

String toJson$Enum$DeploymentState(Enum$DeploymentState e) {
  switch (e) {
    case Enum$DeploymentState.pending:
      return r'pending';
    case Enum$DeploymentState.working:
      return r'working';
    case Enum$DeploymentState.deploying:
      return r'deploying';
    case Enum$DeploymentState.success:
      return r'success';
    case Enum$DeploymentState.error:
      return r'error';
    case Enum$DeploymentState.cancelled:
      return r'cancelled';
    case Enum$DeploymentState.$unknown:
      return r'$unknown';
  }
}

Enum$DeploymentState fromJson$Enum$DeploymentState(String value) {
  switch (value) {
    case r'pending':
      return Enum$DeploymentState.pending;
    case r'working':
      return Enum$DeploymentState.working;
    case r'deploying':
      return Enum$DeploymentState.deploying;
    case r'success':
      return Enum$DeploymentState.success;
    case r'error':
      return Enum$DeploymentState.error;
    case r'cancelled':
      return Enum$DeploymentState.cancelled;
    default:
      return Enum$DeploymentState.$unknown;
  }
}

enum Enum$DeploymentEnvironment {
  production,
  preview,
  $unknown;

  factory Enum$DeploymentEnvironment.fromJson(String value) =>
      fromJson$Enum$DeploymentEnvironment(value);

  String toJson() => toJson$Enum$DeploymentEnvironment(this);
}

String toJson$Enum$DeploymentEnvironment(Enum$DeploymentEnvironment e) {
  switch (e) {
    case Enum$DeploymentEnvironment.production:
      return r'production';
    case Enum$DeploymentEnvironment.preview:
      return r'preview';
    case Enum$DeploymentEnvironment.$unknown:
      return r'$unknown';
  }
}

Enum$DeploymentEnvironment fromJson$Enum$DeploymentEnvironment(String value) {
  switch (value) {
    case r'production':
      return Enum$DeploymentEnvironment.production;
    case r'preview':
      return Enum$DeploymentEnvironment.preview;
    default:
      return Enum$DeploymentEnvironment.$unknown;
  }
}
