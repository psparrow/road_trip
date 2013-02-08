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

end
