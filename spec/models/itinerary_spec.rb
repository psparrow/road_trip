require 'spec_helper'

describe Itinerary do

  describe "validations" do
    context "invalid itinerary" do
      before { subject.valid? }
      it { should have(1).error_on(:user_id) }
      it { should have(1).error_on(:title) }
    end

    context "valid itinerary" do
      specify { FactoryGirl.build(:itinerary).should be_valid }
    end
  end

  describe "#find_for_user" do

    before do
      @creator = FactoryGirl.build(:user)
      @creator.save
      @invitee = FactoryGirl.build(:user)
      @invitee.save
    end

    subject {
      itinerary = FactoryGirl.build(:itinerary)
      itinerary.user = @creator
      itinerary.invitees.build({ user_id: @invitee.id})
      itinerary.save
      itinerary
    }
    context "itinerary created by user" do
      it "should return the itinerary" do
        Itinerary.find_for_user(subject.id, @creator).id.should eq subject.id
      end
    end

    context "itinerary user has been invited to" do
      it "should return the itinerary" do
        Itinerary.find_for_user(subject.id, @invitee).id.should eq subject.id
      end
    end

    context "itinerary user should not have access to" do
      it "raises an error" do
        outsider = FactoryGirl.build(:user)
        outsider.save
        expect {
          Itinerary.find_for_user(subject.id, outsider)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
