# require 'smarter_csv'

class MembershipImportsController < AuthenticatedController
  def index
  end

  def new
  end

  def create
    @memberships = []
    file = params[:roster_file]
    data = SmarterCSV.process(file.tempfile)
    data.each do |row|
      first_name = row[:first_name]
      last_name = row[:last_name]
      email = row[:email]
      phone = row[:phone]

      user = User.invite!(email: email, first_name: first_name, last_name: last_name, phone: phone)
      membership = @unit.memberships.create(user: user)
      @memberships << membership
    end
  end

  def import_params
    ap params.to_unsafe_h
    params.require(:import).permit(:file)
  end
end
