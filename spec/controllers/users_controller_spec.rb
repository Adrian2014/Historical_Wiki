require 'rails_helper'

describe UsersController do
  before do
    @user = User.create(DUMMY_USER_HASH)
  end

  it 'should have proper routes' do
    expect( get: 'users/new' ).to be_routable
    expect( get: 'users/show' ).to be_routable
    expect( post: 'users/create' ).to be_routable
    expect( get: 'users/login' ).to be_routable
    expect( post: 'users/login' ).to be_routable
    expect( get: 'users/show' ).to be_routable
    expect( get: 'users/logout' ).to be_routable
    expect( get: 'users/welcome' ).to be_routable
  end

  describe 'POST login' do
    it 'logs in user when a correct email and password are used' do
      post :login_post, user: DUMMY_USER_HASH
      expect(session['id']).to eq(@user.id)
    end

    it 'does not log in user when an incorrect username or password is used' do
      invalid = DUMMY_USER_HASH
      invalid[:password] = "invalid"
      post :login_post, user: invalid
      expect(session['id']).to be_nil
    end
  end
end
