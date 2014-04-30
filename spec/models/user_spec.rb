require 'spec_helper'

describe User do
 subject { FactoryGirl.build(:user) }

  describe "validations" do
    it "validates the files can be attached" do
      subject.step = 2
      subject.should have_attached_file(:avatar)
    end

    it "validates the presence of attachment" do
      subject.step = 2
      subject.should validate_attachment_presence(:avatar)
    end

    it "validates the content type of the attachment" do
      subject.step = 2
      subject.should validate_attachment_content_type(:avatar).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml')
    end

    it "validates password length" do
      subject.password = '12abc'
      subject.should have(1).error_on(:password)
    end

    it "validates password confirmation" do
      subject.password_confirmation = '12a'
      subject.should have(1).error_on(:password_confirmation)
    end

    it "validates email" do
      subject.email = 'abcd'
      subject.should have(1).error_on(:email)
    end

    it "validates presence of age" do
      subject.age = ""
      subject.should have(1).error_on(:age)
    end

    it "validates presence of gender" do
      subject.gender = ""
      subject.should have(1).error_on(:gender)
    end

    it "validates presence of screen name" do
      subject.screen_name = ""
      subject.should have(1).error_on(:screen_name)
    end

    it "validates format of first name" do
      subject.first_name = "abc123G"
      subject.should have(1).error_on(:first_name)
    end

    it "validates format of last name" do
      subject.last_name = "234gjg"
      subject.should have(1).error_on(:last_name)
    end

    it "validates presence of about me on create" do
      subject.about_me = ""
      subject.step = 2
      subject.should have(1).error_on(:about_me)
    end
  end

  describe "#step?" do
    it "returns true when the user step is equal to the argument" do
      subject.step?(1).should eq true
    end

    it "returns false when the user step is not to the argument" do
      subject.step?(2).should eq false
    end
  end

  describe "#second_step" do
    it "returns true when step is equal to 2" do
      subject.step = 2
      subject.second_step.should eq true
    end

    it "returns false when step is equal to 1" do
      subject.second_step.should eq false
    end
  end

  describe "#increment_step" do
    it "increments the step by 1" do
      subject.increment_step
      subject.step.should eq 2
    end
  end

  describe "#callbacks" do
    it "increments the step by 1 after saving" do
      subject.save
      subject.step.should eq 2
    end
  end
end
