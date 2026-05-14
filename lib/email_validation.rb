# frozen_string_literal: true

require "localized_each_validator"
require "email_validation/version"

# Validates email addresses. Uses the `invalid_email` error message key.
#
# @example
#   validates :email_address, email: true
#
# Options
# -------
#
# |                |                                                                                                                                                                                                                                                                     |
# |:---------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
# | `:format`      | By default, uses a simple email regex that matches most email addresses. If `:rfc5322`, uses a full RFC 5322 email regex that will match common typos as well. If `:rfc5322_simple`, uses a simplified version of the previous regex to ignore some common typos. |
# | `:message`     | A custom message to use if the email is invalid.                                                                                                                                                                                                                    |
# | `:allow_nil`   | If true, `nil` values are allowed (inherited from {LocalizedEachValidator}).                                                                                                                                                                                        |
# | `:allow_blank` | If true, blank values are allowed (inherited from {LocalizedEachValidator}).                                                                                                                                                                                        |

class EmailValidator < LocalizedEachValidator
  # Full RFC 5322 regex (Cal Henderson). Matches the vast majority of valid email
  # addresses including quoted local parts and IP-literal domains.
  RFC5322_REGEX = %r{(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x5c-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])}i.freeze

  # Simplified RFC 5322 regex - rejects common typos like quoted local parts and
  # IP-literal domains, but otherwise follows RFC 5322 closely.
  RFC5322_SIMPLE_REGEX = %r{[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?}i.freeze

  # A loose regex that catches the most common email address formats.
  BASIC_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/i.freeze

  error_key :invalid_email

  # @private
  def valid?(_, _, value)
    regex = case options[:format]
            when :rfc5322 then RFC5322_REGEX
            when :rfc5322_simple then RFC5322_SIMPLE_REGEX
            else BASIC_REGEX
            end
    (value =~ /\A#{regex}\z/i || value =~ /\A\S.*?\s+<#{regex}>\z/i) != nil
  end
end
