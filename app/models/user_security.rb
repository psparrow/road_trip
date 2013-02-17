class UserSecurity

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def method_missing(meth, *args)
    if user.respond_to?(meth)
      user.send(meth, *args)
    else
      super
    end
  end

  def respond_to?(meth)
    user.respond_to?(meth)
  end

  def can_edit?(itinerary_id)
    has_role_on_itinerary?(
      itinerary_id,
      :administrator
    )
  end

  alias_method :can_invite_to?, :can_edit?

  def can_add_stops?(itinerary_id)
    has_role_on_itinerary?(
      itinerary_id,
      :administrator,
      :contributor
    )
  end

  alias_method :can_reorder_stops?, :can_add_stops?

  def can_view?(itinerary_id)
    has_role_on_itinerary?(
      itinerary_id,
      :administrator,
      :contributor,
      :read_only
    )
  end

  def has_role_on_itinerary?(itinerary_id, *role_symbols)
    user.contributors.find(:first, conditions: {
      itinerary_id: itinerary_id,
      role_id:      role_symbols.map { |symbol| ROLES[symbol] }
    })
  end

end
