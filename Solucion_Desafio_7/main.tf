# Create a App Engine
resource "google_app_engine_application" "app" {
  project     = var.PROJECT_ID
  location_id = var.REGION
}

# Create a Cloud Endpoint
resource "google_endpoints_service" "openapi_service" {
  service_name   = "api-name.endpoints.${var.PROJECT_ID}.cloud.goog"
  project        = var.PROJECT_ID
  openapi_config = file("./api/openapi_spec.yml")
}
