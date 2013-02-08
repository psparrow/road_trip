require 'spec_helper'
require 'ostruct'

describe AddContributorToItinerary do

  subject { AddContributorToItinerary.new(contributor, itinerary) }

  let(:itinerary)   { double("itinerary", add_contributor: true) }
  let(:user)        { double("user", email: "frank@booth.com" ) }
  let(:mailer_mock) { double("mailer", deliver: true) }
  let(:contributor) {
    OpenStruct.new(role_id: 1, email: "frank@booth.com", save: true)
  }

  describe "#perform" do

    before do
      InvitationMailer.stub(:existing_user).and_return(mailer_mock)
      InvitationMailer.stub(:new_user).and_return(mailer_mock)
    end

    context "When the user already exists" do

      before do
        User.stub(:find_by_email).and_return(user)
      end

      it "finds the user" do
        User.should_receive(:find_by_email).with(contributor.email)
        subject.perform
      end

      it "sets the user reference" do
        subject.perform
        subject.user.should == user
      end

      it "sets new_user to false" do
        subject.perform
        subject.new_user.should == false
      end

      it "adds the user to the contributor" do
        subject.perform
        contributor.user.should == user
      end

      it "adds the itinerary to the contributor" do
        subject.perform
        contributor.itinerary.should == itinerary
      end

      it "sends a existing user message to the user" do
        InvitationMailer.should_receive(:existing_user).with(user, itinerary)
        mailer_mock.should_receive(:deliver)
        subject.perform
      end

    end

    context "When the user does not exist" do
      before do
        User.stub(:find_by_email).and_return(nil)
        User.stub(:invite_by_email).and_return(user)
      end

      it "invites the user" do
        User.should_receive(:invite_by_email).with(contributor.email)
        subject.perform
      end

      it "sets the user reference" do
        subject.perform
        subject.user.should == user
      end

      it "sets new_user to true" do
        subject.perform
        subject.new_user.should == true
      end

      it "adds the user to the contributor" do
        subject.perform
        contributor.user.should == user
      end

      it "adds the itinerary to the contributor" do
        subject.perform
        contributor.itinerary.should == itinerary
      end

      it "sends a new user message to the user" do
        InvitationMailer.should_receive(:new_user).with(user, itinerary)
        mailer_mock.should_receive(:deliver)
        subject.perform
      end
    end
  end
end
