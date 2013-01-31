# Seeded as:
# | id |    title      |
# | 1  | Administrator |
# | 2  | Contributor   |
# | 3  | Read Only     |
class Role < ActiveRecord::Base
  attr_accessible :title
end
