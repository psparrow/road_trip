# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RoadTrip::Application.initialize!

unless ENV['test']
  ROLES = Role.all.each_with_object([]) do |role, roles|
    roles[role.id] = role.title
  end
end
