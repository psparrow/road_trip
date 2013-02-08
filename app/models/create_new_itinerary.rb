class CreateNewItinerary

  attr_reader :user, :itinerary

  def initialize(itinerary, user)
    @user      = user
    @itinerary = itinerary
  end

  def setup_administrator
    Contributor.create(
      role_id:      ROLES.find_index(:administrator),
      user_id:      user.id,
      itinerary_id: itinerary.id
    )
  end

  def perform
    itinerary.user = user

    itinerary.save && setup_administrator
  end

end
