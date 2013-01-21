require 'spec_helper'

describe UserInviter do

  subject             { UserInviter }
  let(:email)         { "test@test.com" }
  let(:inviter)       { FactoryGirl.create(:user) }
  let(:existing_user) { FactoryGirl.create(:user) }

  describe "#find_or_invite_by_email" do

    context "invitee already exists" do
      let(:invitee) {
        subject.find_or_invite_by_email(
          existing_user.email,
          inviter
        )
      }

      it "returns an object that references the existing user" do
        invitee.should == existing_user
      end

      it "returns an object that responds to exists? and returns true" do
        invitee.exists?.should == true
      end
    end

    context "invitee does not exist" do

      let(:invitee) {
        subject.find_or_invite_by_email(email, inviter)
      }

      it "returns an object that references the newly invited user" do
        invitee.email.should   == email
      end

      it "returns an object that responds to exists? and returns false" do
        invitee.exists?.should == false
      end
    end

  end

end
