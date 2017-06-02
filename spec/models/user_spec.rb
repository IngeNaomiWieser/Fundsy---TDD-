require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires an email' do
      # GIVEN... WHEN... THEN...

      # GIVEN: A user with no email
      u = User.new

      # WHEN: run validations
      u.valid?

      # THEN: error on the email field
      expect(u.errors).to have_key(:email)
    end

    it 'requires a unique email' do
      # FactoryGirl.create will instantly create an instance of the model
      # and save to the database
      u = FactoryGirl.create(:user)

      # FactoryGirl.build will only return instance of the model that hasn't been
      # saved to the database yet
      # For a list of FactoryGirl methods go to:
      # http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md#Using_factories
      u1 = FactoryGirl.build(:user, email: u.email)
      u1.valid?

      expect(u1.errors).to have_key(:email)
    end
  end
end
