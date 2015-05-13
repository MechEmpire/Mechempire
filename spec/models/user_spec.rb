require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before do 
    @user = User.new(name: "Tairy", 
                     email: "tairyguo@gamil.com", 
                     password: "1234567",
                     password_confirmation: "1234567")
  end

  subject {@user}

  it{ should respond_to(:name)}
  it{ should respond_to(:email)}
  it{ should respond_to(:motto)}
  it{ should respond_to(:avatar_address)}
  it{ should respond_to(:password_digest)}
  it{ should respond_to(:password_confirmation)}
  it{ should respond_to(:password)}
  it { should respond_to(:authenticate) }

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

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org test@foo. foo@foor_sse.com foo@foo+basd.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_user_a@F.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Tairys", 
                     email: "tairyguos@gamil.com", 
                     password: " ",
                     password_confirmation: " ")
    end
    it {should_not be_valid}
  end

  describe "when password is not match" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "with password is to short" do
    before {@user.password == @user.password_confirmation = "a"*5}
    it{should be_invalid}
  end

  # describe "return value of authenticate method" do
  #   before {@user.save}
  #   let(:found_user) {User.find_by(email: @user.email)}

  #   describe "with valid password" do
  #     it { should eq found_user.authenticate(@user.password) }
  #   end

  #   describe "with invalid password" do
  #     let(:user_with_invalid_password) {found_user.authenticate("invalid")}
  #     it {should_not eq user_with_invalid_password}
  #     specify { expect(user_with_invalid_password).to be_false}
  #   end
  # end
end
