require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let :user { FactoryGirl.create(:user) }           #:user is a method
  #the above is equivalent to doing:
  #def user
    #@user || FactoryGirl.create(:user)
  # end
  # This technique is called memoization. It means that the first time a function (or method) is called, its return value is cached. Every future call of that function will return the cached value instead of recalculating it. It saves a lot of computations. So it makes it a bit faster. You don't have to create the user again every time, you just use the same one again.

  def valid_post
    post :create, params: { campaign: FactoryGirl.attributes_for(:campaign) }
  end

  describe '#new' do

    context 'with no user signed in' do
      it 'redirects to the sign in page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with sign in user' do
      # this is the equavalen of a user signing in.
      before do
        request.session[:user_id] = FactoryGirl.create(:user).id
      end
      it 'renders the new template' do
        # Rspec for Rails comes with utility methods to make virtual requests to controllers in your project. Inside a controller test, Rspec will know which controller to make a request to by looking at the line 'RSpec.describe CampaignsController, type: controller do'. Putting all of this together means that the 'get :new' method call below will do a get request to the new action of the CampaignsController
        # We need our helpermethods to sort of make a fake request to the controller
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns a campaign instance variable to a new campaign' do
        get :new
        # assigns is a helper method for Rspec tests. It takes a symbol that refers to the name of an instance variable inside of a controller. So this assigns gets the variable, @campaign from the new action
        expect(assigns(:campaign)).to(be_a_new(Campaign))
      end
    end
  end

  describe '#create' do
     context 'without a signed user' do
       it 'redirects to the sign in page' do
         post :create
         expect(response).to redirect_to(new_session_path)
       end
     end

     context 'with a signed in user' do
       before { request.session[:user_id] = user.id }

       context 'with valid attributes' do
       it 'creates a new campaign in the database' do
         count_before = Campaign.count
        #  post :create, params: { campaign: FactoryGirl.attributes_for(:campaign) }
        valid_post
         count_after = Campaign.count

         expect(count_after).to eq(count_before + 1)
       end

       it 'redirect to the campaign show page ' do
        #  post :create, params: { campaign: FactoryGirl.attributes_for(:campaign) }
        valid_post
        expect(response).to redirect.to(campaign_path(Campaign.last)) 
       end
     end

     context 'with invalid attributes' do
       it 'does not create a campagin in the database'
       it 'renders new template'
       it 'alerts the user that there was an error'
     end
   end
 end
end
