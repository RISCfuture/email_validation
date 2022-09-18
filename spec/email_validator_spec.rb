require 'spec_helper'

RSpec.describe EmailValidator do
  before :each do
    @validator = EmailValidator.new({ attributes: [ :foo, :bar ] })
  end

  it "should validate an email address" do
    expect(@validator.valid?(nil, nil, 'foo@bar.com')).to eql(true)
    expect(@validator.valid?(nil, nil, 'foo@bar.blackfriday')).to eql(true)
  end

  it "should validate a name and email pair" do
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar.com>')).to eql(true)
  end

  it "should use a full RFC 5322 syntax when configured" do
    @validator = EmailValidator.new(attributes: [:foo, :bar], format: :rfc_5322)
    expect(@validator.valid?(nil, nil, "siobhan.o'malley@ex.ample.org")).to eql(true)
  end

  it "should not validate an improper email address" do
    expect(@validator.valid?(nil, nil, 'foo@bar')).to eql(false)
    expect(@validator.valid?(nil, nil, 'fo oo@bar.com')).to eql(false)
    expect(@validator.valid?(nil, nil, 'foo@bar@bar.com')).to eql(false)
    expect(@validator.valid?(nil, nil, 'foo@.com')).to eql(false)
  end

  it "should not validate an improper name and email pair" do
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar>')).to eql(false)
    expect(@validator.valid?(nil, nil, 'Foo Bar <fo oo@bar.com>')).to eql(false)
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar@bar.com>')).to eql(false)
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@.com>')).to eql(false)
    expect(@validator.valid?(nil, nil, '<foo@bar.com> Foo Bar')).to eql(false)
  end
end
