errors {

  # Network or connectivity-related transient failures
  retry "network_errors" {
    retryable_errors = [
      ".*read: connection reset by peer.*",
      ".*TLS handshake timeout.*",
      ".*connection refused.*",
      ".*i/o timeout.*",
      ".*connection timed out.*",
      ".*dial tcp: lookup .*: no such host.*",
      ".*EOF.*"
    ]
    max_attempts       = get_env("RETRY_MAX_ATTEMPTS", "3")
    sleep_interval_sec = get_env("RETRY_SLEEP_INTERVAL_SEC", "10")
  }

  # Backend / API errors that might resolve with retry
  retry "backend_service_errors" {
    retryable_errors = [
      ".*timeout while waiting for state.*",
      ".*503 Service Unavailable.*",
      ".*rate limit exceeded.*"
    ]
    max_attempts       = get_env("RETRY_MAX_ATTEMPTS", "3")
    sleep_interval_sec = get_env("RETRY_SLEEP_INTERVAL_SEC", "5")
  }

  # Git or source-fetch related transient failures
  retry "source_fetch_errors" {
    retryable_errors = [
      ".*unable to verify checksum.*",
      ".*unable to clone repository.*",
      ".*failed to download module.*",
      ".*failed to download provider.*"
    ]
    max_attempts       = get_env("RETRY_MAX_ATTEMPTS", "3")
    sleep_interval_sec = get_env("RETRY_SLEEP_INTERVAL_SEC", "5")
  }

  # Git authentication failures — may retry in CI due to race/secret loading delays
  retry "git_auth_errors" {
    retryable_errors = [
      ".*remote: Repository not found.*",
      ".*remote: Invalid username or password.*",
      ".*remote: Access denied to repository.*",
      ".*Authentication failed.*"
    ]
    max_attempts       = get_env("RETRY_MAX_ATTEMPTS", "2")
    sleep_interval_sec = get_env("RETRY_SLEEP_INTERVAL_SEC", "10")
  }
}