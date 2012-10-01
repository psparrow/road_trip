require 'spec_helper'

describe User do

  describe "validations" do
    context "invalid user" do
      before { subject.valid? }
      it { should have(1).error_on(:username) }
      it { should have(1).error_on(:email) }
    end

    context "valid user" do
      specify { FactoryGirl.build(:user).should be_valid }
    end
  end

end
