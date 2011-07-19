require 'localized_each_validator'

# Validates email addresses. Uses the @invalid_email@ error message key.
#
# @example
#   validates :email_address, email: true
#
# h2. Options
#
# | @:message@ | A custom message to use if the email is invalid. |
# | @:allow_nil@ | If true, @nil@ values are allowed. |

class EmailValidator < LocalizedEachValidator
  # Regular expression describing valid emails
  EMAIL_REGEX = "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}"
  
  error_key :invalid_email

  # @private
  def valid?(_, _, value)
    value =~ /^#{EMAIL_REGEX}$/i || value =~ /^.+\s+<#{EMAIL_REGEX}>$/i
  end
end
