Geocoder.configure(

  # street address geocoding service (default :nominatim)
  lookup: :google,

  # to use an API key:
  api_key: Rails.application.credentials.google[:google_api_key],

  # geocoding service request timeout, in seconds (default 3):
  timeout: 5,

  # set default units to kilometers:
  units: :km
)
