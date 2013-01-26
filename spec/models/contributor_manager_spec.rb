require 'spec_helper'

describe ContributorManager do

  let(:itinerary)   { double("itinerary", :add_invitee => true) }
  let(:user)        { double("user", :email => "frank@booth.com" ) }
  let(:mailer_mock) { double("mailer", :deliver => true) }
  subject { ContributorManager.new(itinerary) }

  describe "#add_by_email" do

    before do
      InvitationMailer.stub(:existing_user).and_return(mailer_mock)
      InvitationMailer.stub(:new_user).and_return(mailer_mock)
    end

    context "When the user already exists" do

      before do
        User.stub(:find_by_email).and_return(user)
      end

      it "finds the user" do
        User.should_receive(:find_by_email).with(user.email)
        subject.add_by_email(user.email)
      end

      it "sets the user reference" do
        subject.add_by_email(user.email)
        subject.user.should == user
      end

      it "sets new_user to false" do
        subject.add_by_email(user.email)
        subject.new_user.should == false
      end

      it "adds the user to the itinerary" do
        itinerary.should_receive(:add_invitee).with(user)
        subject.add_by_email(user.email)
      end

      it "sends an message to the user" do
        InvitationMailer.should_receive(:existing_user).with(user, itinerary)
        subject.add_by_email(user.email)
      end

    end

    context "The user does not exist" do
      before do
        User.stub(:find_by_email).and_return(nil)
        User.stub(:invite_by_email).and_return(user)
      end

      it "invites the user" do
        User.should_receive(:invite_by_email).with(user.email)
        subject.add_by_email(user.email)
      end

      it "sets the user reference" do
        subject.add_by_email(user.email)
        subject.user.should == user
      end

      it "sets new_user to true" do
        subject.add_by_email(user.email)
        subject.new_user.should == true
      end

      it "adds the user to the itinerary" do
        itinerary.should_receive(:add_invitee).with(user)
        subject.add_by_email(user.email)
      end

      it "sends an message to the user" do
        InvitationMailer.should_receive(:new_user).with(user, itinerary)
        subject.add_by_email(user.email)
      end
    end
  end
end
