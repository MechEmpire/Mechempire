require 'rails_helper'

RSpec.describe "users/new", :type => :view do
  before(:each) do
    assign(:user, User.new(
      :name => "",
      :email => "",
      :motto => "",
      :avarar_address => ""
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_motto[name=?]", "user[motto]"

      assert_select "input#user_avarar_address[name=?]", "user[avarar_address]"
    end
  end
end
