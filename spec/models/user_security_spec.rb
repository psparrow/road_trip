require 'spec_helper'

describe UserSecurity do

  subject    { UserSecurity.new(user) }

  let(:user) { double("user", name: "Bob") }

  ROLES = { role1: 1, role2: 2, role3: 3 }

  let(:contributors) {[
    double("contributor", itinerary_id: 42, role_id: ROLES[:role2]),
    double("contributor", itinerary_id: 43, role_id: ROLES[:role3])
  ]}

  context "#has_role_on_itinerary?" do
    before do
      user.stub(:contributors).and_return(contributors)
    end

    it "checks if the user has the role/itinerary" do
      contributors.should_receive(:find).with(
        :first,
        conditions: {
          itinerary_id: 42,
          role_id:      [ROLES[:role2]]
        }
      )

      subject.has_role_on_itinerary?(42, :role2)
    end

    it "checks if the user has any of the roles on the itinerary" do
      contributors.should_receive(:find).with(
        :first,
        conditions: {
          itinerary_id: 42,
          role_id:      [ROLES[:role1], ROLES[:role2], ROLES[:role3]]
        }
      )

      subject.has_role_on_itinerary?(42, :role1, :role2, :role3)
    end

    it "passes other messages to the user object" do
      subject.name.should == user.name
    end

  end

end
