require 'spec_helper'

describe CheckIn do

  describe ".user_last_check_in" do
    before(:each) do
      3.times do
        Timecop.travel(61.minutes)
        create(:check_in, user: "Rose Tyler")
      end
    end

    it "should be the user's last check in" do
      expect(CheckIn.first.user_last_check_in).to eq(CheckIn.last)
    end
  end

  describe "has validations for minimum time constraint" do
    before(:each) do
      Timecop.freeze
      create(:check_in, user: "Rose Tyler")
    end

    context 'and the user tries to check in twice in an hour' do
      it "should fail validation" do
        expect(build :check_in, user: "Rose Tyler").to be_invalid
      end
    end
  end

end