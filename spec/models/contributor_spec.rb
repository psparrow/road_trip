require 'spec_helper'

describe Contributor do

  describe "validations" do
    context "invalid" do
      before { subject.valid? }
      it { should have(1).error_on(:itinerary_id) }
      it { should have(1).error_on(:user_id) }
      it { should have(1).error_on(:role_id) }
    end

    context "valid" do
      specify { FactoryGirl.build(:contributor).should be_valid }
    end
  end

end
