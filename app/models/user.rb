#---
# Excerpted from "Agile Web Development with Rails 6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails6 for more book information.
#---
class User < ApplicationRecord
  ADMIN_EMAIL = 'admin@depot.com'
  VALID_EMAIL_FORMAT = /\A[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\z/
  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_FORMAT, message: "is not in the standard email format" }

  after_destroy :ensure_an_admin_remains
  after_create_commit :send_welcome_email
  before_destroy :check_if_admin_destroyed
  before_update :check_if_admin_updated
  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end

    def send_welcome_email
      UserMailer.welcome_email(self).deliver_later
    end

    def check_if_admin_destroyed
      if email == ADMIN_EMAIL
        errors.add :base, "Cannot destroy admin user"
        throw :abort
      end
    end

    def check_if_admin_updated
      if email == ADMIN_EMAIL
        errors.add :base, "Cannot update admin user"
        throw :abort
      end
    end
end
