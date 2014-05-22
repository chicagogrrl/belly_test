require 'spec_helper'

describe CheckIn do

  describe ".user_last_check_in" do
    before(:each) do
      3.times do
        Timecop.travel(61.minutes)
        create(:check_in)
      end
    end

    it "should be the user's last check in" do
      expect(CheckIn.first.user_last_check_in).to eq(CheckIn.last)
    end
  end

  describe "has validations for minimum time constraint" do
    before(:each) do
      Timecop.freeze
      create(:check_in)
    end

    context 'and the user tries to check in twice in an hour' do
      it "should fail validation" do
        expect(build :check_in).to be_invalid
      end
    end

    context 'and the user tries to check in to a different business within the hour' do
      it "should pass validation" do
        expect(build :check_in, business: 'Parliament').to be_valid
      end
    end
  end

end