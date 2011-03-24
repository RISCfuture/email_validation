require 'spec_helper'

describe EmailValidator do
  before :each do
    @validator = EmailValidator.new({ attributes: [ :foo, :bar ] })
  end
  
  it "should validate an email address" do
    @validator.valid?(nil, nil, 'foo@bar.com').should be_true
  end
  
  it "should validate a name and email pair" do
    @validator.valid?(nil, nil, 'Foo Bar <foo@bar.com>').should be_true
  end
  
  it "should not validate an improper email address" do
    @validator.valid?(nil, nil, 'foo@bar').should be_false
    @validator.valid?(nil, nil, 'fo oo@bar.com').should be_false
    @validator.valid?(nil, nil, 'foo@bar@bar.com').should be_false
    @validator.valid?(nil, nil, 'foo@.com').should be_false
  end
  
  it "should not validate an improper name and email pair" do
    @validator.valid?(nil, nil, 'Foo Bar <foo@bar>').should be_false
    @validator.valid?(nil, nil, 'Foo Bar <fo oo@bar.com>').should be_false
    @validator.valid?(nil, nil, 'Foo Bar <foo@bar@bar.com>').should be_false
    @validator.valid?(nil, nil, 'Foo Bar <foo@.com>').should be_false
    @validator.valid?(nil, nil, '<foo@bar.com> Foo Bar').should be_false
  end
end