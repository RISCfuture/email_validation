require 'spec_helper'

describe EmailValidator do
  before :each do
    @validator = EmailValidator.new({ attributes: [ :foo, :bar ] })
  end
  
  it "should validate an email address" do
    expect(@validator.valid?(nil, nil, 'foo@bar.com')).to be_true
  end
  
  it "should validate a name and email pair" do
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar.com>')).to be_true
  end
  
  it "should not validate an improper email address" do
    expect(@validator.valid?(nil, nil, 'foo@bar')).to be_false
    expect(@validator.valid?(nil, nil, 'fo oo@bar.com')).to be_false
    expect(@validator.valid?(nil, nil, 'foo@bar@bar.com')).to be_false
    expect(@validator.valid?(nil, nil, 'foo@.com')).to be_false
  end
  
  it "should not validate an improper name and email pair" do
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar>')).to be_false
    expect(@validator.valid?(nil, nil, 'Foo Bar <fo oo@bar.com>')).to be_false
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@bar@bar.com>')).to be_false
    expect(@validator.valid?(nil, nil, 'Foo Bar <foo@.com>')).to be_false
    expect(@validator.valid?(nil, nil, '<foo@bar.com> Foo Bar')).to be_false
  end
end
