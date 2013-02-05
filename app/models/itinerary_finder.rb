class ItineraryFinder

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def all
    user.contributors.map { |contributor|
      contributor.itinerary
    }
  end

end
