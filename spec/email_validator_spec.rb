# frozen_string_literal: true

require "spec_helper"

RSpec.describe EmailValidator do
  let(:validator) { described_class.new(attributes: %i[foo bar]) }
  let(:rfc_validator) { described_class.new(attributes: %i[foo bar], format: :rfc5322) }

  describe "basic format" do
    it "validates a plain email address" do
      expect(validator.valid?(nil, nil, "foo@bar.com")).to be(true)
    end

    it "accepts long TLDs (e.g. .blackfriday, .museum, .photography)" do
      expect(validator.valid?(nil, nil, "foo@bar.blackfriday")).to be(true)
      expect(validator.valid?(nil, nil, "foo@bar.museum")).to be(true)
      expect(validator.valid?(nil, nil, "foo@bar.photography")).to be(true)
    end

    it "validates a name + email pair" do
      expect(validator.valid?(nil, nil, "Foo Bar <foo@bar.com>")).to be(true)
    end

    it "rejects malformed addresses" do
      expect(validator.valid?(nil, nil, "foo@bar")).to be(false)
      expect(validator.valid?(nil, nil, "fo oo@bar.com")).to be(false)
      expect(validator.valid?(nil, nil, "foo@bar@bar.com")).to be(false)
      expect(validator.valid?(nil, nil, "foo@.com")).to be(false)
    end

    it "rejects malformed name + email pairs" do
      expect(validator.valid?(nil, nil, "Foo Bar <foo@bar>")).to be(false)
      expect(validator.valid?(nil, nil, "Foo Bar <fo oo@bar.com>")).to be(false)
      expect(validator.valid?(nil, nil, "Foo Bar <foo@bar@bar.com>")).to be(false)
      expect(validator.valid?(nil, nil, "Foo Bar <foo@.com>")).to be(false)
      expect(validator.valid?(nil, nil, "<foo@bar.com> Foo Bar")).to be(false)
    end

    # Regression: whitespace-only "names" used to be accepted by the
    # `\A.+\s+<...>\z` pattern. The fix tightens this to require at least one
    # non-whitespace character before the address.
    describe "name-pair regex (regression)" do
      it "rejects a whitespace-only name with angle-bracketed address" do
        expect(validator.valid?(nil, nil, "   <foo@bar.com>")).to be(false)
        expect(validator.valid?(nil, nil, "\t\t<foo@bar.com>")).to be(false)
        expect(validator.valid?(nil, nil, " <foo@bar.com>")).to be(false)
      end

      it "still accepts a single-character name" do
        expect(validator.valid?(nil, nil, "X <foo@bar.com>")).to be(true)
      end

      it "still accepts multi-word names" do
        expect(validator.valid?(nil, nil, "Foo Bar Baz <foo@bar.com>")).to be(true)
      end
    end
  end

  describe ":rfc5322 format" do
    it "validates addresses with quoted local parts and apostrophes" do
      expect(rfc_validator.valid?(nil, nil, "siobhan.o'malley@ex.ample.org")).to be(true)
    end

    it "validates ordinary addresses" do
      expect(rfc_validator.valid?(nil, nil, "foo@bar.com")).to be(true)
    end

    # Regression: the original regex had a corrupted byte range in the
    # IP-literal clause - `[\x21-\x5a\x53-\x7f]` should have been
    # `[\x21-\x5a\x5c-\x7f]` per the canonical Cal Henderson source.
    describe "IP-literal byte-range fix (regression)" do
      it "has the corrected \\x5c byte boundary in its source" do
        source = EmailValidator::RFC5322_REGEX.source
        expect(source).to include('\x21-\x5a\x5c-\x7f')
        expect(source).not_to include('\x21-\x5a\x53-\x7f')
      end

      it "still rejects clearly invalid addresses" do
        expect(rfc_validator.valid?(nil, nil, "not-an-email")).to be(false)
        expect(rfc_validator.valid?(nil, nil, "foo@")).to be(false)
        expect(rfc_validator.valid?(nil, nil, "@bar.com")).to be(false)
      end
    end
  end

  describe "VERSION" do
    it "is defined and is the 2.x line" do
      expect(EmailValidator::VERSION).to match(/\A2\.\d+\.\d+/)
    end
  end
end
