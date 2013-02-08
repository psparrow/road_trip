require 'spec_helper'

describe ItineraryFinder do

  subject { ItineraryFinder.new(user) }

  let(:user) {
    double("user", contributors: [
      double("contributor", itinerary: "one"),
      double("contributor", itinerary: "two")
  ])}

  context "#all" do
    it "returns all itineraries for which a user is a contributor" do
      subject.all.should == ["one", "two"]
    end
  end

end
