class CreateNewItinerary

  attr_reader :user, :itinerary

  def initialize(itinerary, user)
    @user      = user
    @itinerary = itinerary
  end

  def perform
    itinerary.user_id = user.id

    itinerary.save && Contributor.new(
        user_id:      user.id,
        itinerary_id: itinerary.id,
        role_id:      ROLES.index(:administrator)
      ).save
  end

end
