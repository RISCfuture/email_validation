require 'spec_helper'

RSpec.describe EmailValidator do
  before :each do
    @validator = described_class.new(attributes: %i[foo bar])
  end

  it "should validate an email address" do
    expect(@validator.valid?(nil, nil, 'foo@bar.com')).to be(true)
    expect(@validator.valid?(nil, nil, 'foo@bar.blackfriday')).to be(true)
  end

  it "should validate a name and email pair" do
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar.com>')).to be(true)
  end

  it "should use a full RFC 5322 syntax when configured" do
    @validator = described_class.new(attributes: %i[foo bar], format: :rfc5322)
    expect(@validator.valid?(nil, nil, "siobhan.o'malley@ex.ample.org")).to be(true)
  end

  it "should not validate an improper email address" do
    expect(@validator.valid?(nil, nil, 'foo@bar')).to be(false)
    expect(@validator.valid?(nil, nil, 'fo oo@bar.com')).to be(false)
    expect(@validator.valid?(nil, nil, 'foo@bar@bar.com')).to be(false)
    expect(@validator.valid?(nil, nil, 'foo@.com')).to be(false)
  end

  it "should not validate an improper name and email pair" do
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar>')).to be(false)
    expect(@validator.valid?(nil, nil, 'Foo Bar <fo oo@bar.com>')).to be(false)
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar@bar.com>')).to be(false)
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@.com>')).to be(false)
    expect(@validator.valid?(nil, nil, '<foo@bar.com> Foo Bar')).to be(false)
  end
end
