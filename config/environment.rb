# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RoadTrip::Application.initialize!

ROLES = {
  administrator: 1,
  contributor:   2,
  read_only:     3
}
