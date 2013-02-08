class ItinerarySecurity

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def can_add_stops?(itinerary_id)
    has_role_on_itinerary?(
      itinerary_id,
      :administrator,
      :contributor
    )
  end

  def can_view?(itinerary_id)
    has_role_on_itinerary?(
      itinerary_id,
      :administrator,
      :contributor,
      :read_only
    )
  end

  def has_role_on_itinerary?(itinerary_id, *role_symbols)
    user.contributors.any? { |contributor|
      contributor.itinerary_id == itinerary_id.to_i &&
        contributor_has_role?(contributor, role_symbols)
    }
  end

  def contributor_has_role?(contributor, role_symbols)
    role_symbols.find_index(
      ROLES.invert[contributor.role_id]
    )
  end

end
