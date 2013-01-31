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
      @creator      = FactoryGirl.create(:user)
      @invited_user = FactoryGirl.create(:user)
      @role         = FactoryGirl.create(:contributor_role)
    end

    subject {
      itinerary = FactoryGirl.create(
        :itinerary,
        user: @creator )

      itinerary.contributors.create(
        user_id: @invited_user.id,
        role_id: @role.id
      )

      itinerary
    }

    context "itinerary created by user" do
      it "should return the itinerary" do
        itinerary = Itinerary.find_for_user(subject.id, @creator)
        itinerary.id.should eq subject.id
      end
    end

    context "itinerary user has been invited to" do
      it "should return the itinerary" do
        itinerary = Itinerary.find_for_user(subject.id, @invited_user)
        itinerary.id.should eq subject.id
      end
    end

    context "itinerary user should not have access to" do
      it "raises an error" do
        outsider = FactoryGirl.create(:user)

        expect {
          Itinerary.find_for_user(subject.id, outsider)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
