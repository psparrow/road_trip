require 'spec_helper'

describe ItinerarySecurity do

  subject    { ItinerarySecurity.new(user) }

  let(:user) { double("user") }

  ROLES = [:role1, :role2, :role3]

  let(:contributors) {[
    double("contributor", itinerary_id: 42, role_id: ROLES.find_index(:role2)),
    double("contributor", itinerary_id: 43, role_id: ROLES.find_index(:role3))
  ]}

  context "#has_role_on_itinerary?" do
    before do
      user.stub(:contributors).and_return(contributors)
    end

    it "finds all contributors for the user" do
      user.should_receive(:contributors)
      subject.has_role_on_itinerary?(123, :test)
    end

    it "returns true if the user has the role/itinerary" do
      subject.has_role_on_itinerary?(42, :role2).should == true
    end

    it "returns true if the user has at least one role" do
      subject.has_role_on_itinerary?(42, :role1, :role2, :role3).should == true
    end

    it "returns false if the user does not have the role" do
      subject.has_role_on_itinerary?(42, :role1).should == false
    end

  end

end
