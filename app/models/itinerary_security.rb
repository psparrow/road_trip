class ItinerarySecurity

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def can_add_stops?(itinerary_id)
    has_role_on_itinerary?(
      itinerary_id,
      :administrator, :contributor
    )
  end

  def can_view?(itinerary_id)
    has_role_on_itinerary?(
      itinerary_id,
      :administrator, :contributor, :read_only
    )
  end

  def has_role_on_itinerary?(itinerary_id, *role_titles)
    0 < user.contributors.count(
      :all,
      conditions: [
        "role_id IN (?) AND itinerary_id = ?",
        role_titles.map { |title| ROLES.index(title) },
        itinerary_id
      ]
    )
  end

end
