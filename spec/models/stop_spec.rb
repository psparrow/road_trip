require 'spec_helper'

describe Stop do

  describe "validations" do
    context "invalid stop" do
      before { subject.valid? }
      it { should have(1).error_on(:user_id) }
      it { should have(1).error_on(:itinerary_id) }
      it { should have(1).error_on(:title) }
    end

    context "valid stop" do
      specify { FactoryGirl.build(:stop).should be_valid }
    end
  end

end
