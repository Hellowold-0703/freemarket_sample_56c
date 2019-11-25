require 'rails_helper'

describe User do
  describe '#create' do
    it"is valid with a family_name,first_name, family_furigana,first_furigana,birth_year,email and password " do
      @user = FactoryBot.build(:user)
      expect(@user).to be_valid
    end
  end
end