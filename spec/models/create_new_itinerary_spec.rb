require 'spec_helper'
require 'ostruct'

describe CreateNewItinerary do

  subject { CreateNewItinerary.new(itinerary, user) }

  let(:user)        { double("user", id: 1) }
  let(:itinerary)   { OpenStruct.new(id: 42, save: true) }

  ROLES = [:administrator]

  context "#perform" do

    before do
      Contributor.stub(:create).and_return(true)
    end

    it "connects the itinerary to the user" do
      subject.perform
      itinerary.user.should == user
    end

    it "saves the itinerary" do
      itinerary.should_receive(:save)
      subject.perform
    end

    it "makes the user an administrator on the itinerary" do
      Contributor.should_receive(:create).with(
        role_id:      ROLES.find_index(:administrator),
        user_id:      user.id,
        itinerary_id: itinerary.id
      )

      subject.perform
    end
  end
end
