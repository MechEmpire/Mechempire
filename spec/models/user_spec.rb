require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before { @user = User.new(name: "Tairy", email: "tairyguo@gamil.com")}

  subject {@user}

  it{ should respond_to(:name)}
  it{ should respond_to(:email)}
  it{ should respond_to(:motto)}
  it{ should respond_to(:avatar_address)}
  it{ should respond_to(:password)}

  describe "when name is not present" do
    before { @user.name = "" }
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before {@user.email = ""}
    it {should_not be_valid}
  end

  describe "when password is not present" do
    before {@user.password = ""}
    it {should_not be_valid}
  end

  describe "when name is to long" do
    before { @user.name = "a" * 51 }
    it {should_not be_valid}
  end 
end
