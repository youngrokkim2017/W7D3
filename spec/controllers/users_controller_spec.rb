require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) do
    User.create(  
      username: 'Tobias',
      password: 'password'
    )
  end



  describe 'GET #new' do
    it 'renders new users' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'shows a user' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'redirects to the user\'s show page' do
        post :create, params: { user: { username: 'Tobias', password: "password" } }
        expect(response).to redirect_to(user_url(User.find_by(username: 'Tobias')))
      end
    end

    context 'with invalid params' do
      it 'validates the presence of password and renders the new template with errors' do
        post :create, params: { user: { username: 'Tobias', password: "" } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
      it 'validates password length is a minimum of 6' do
        post :create, params: { user: { username: 'Tobias', password: "a" } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe 'PATCH #update' do
    it 'updates a user' do
      patch :update
      expect(response).to render_template(:update)
    end
  end

  # describe 'GET #edit' do
  #   it 'edits a user' do
  #     get :edit
  #     expect(response).to render_template(:edit)
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   it 'destroys a user' do
  #     get :destroy
  #     expect(response).to render_template(:destroy)
  #   end
  # end

  # describe 'GET #index' do
  #   it 'returns an index of all users' do
  #     get :index
  #     expect(response).to be_success
  #     expect(response).to render_template(:index)
  #   end
  # end



end
