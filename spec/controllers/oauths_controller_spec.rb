require 'rails_helper'

describe OauthsController, type: :controller do
  describe '#callback' do
      it 'logs in a linked user' do
        expect(OauthsController.any_instance).to receive(:login_from).with('github').and_return(Authentication.new)
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        get :callback, provider: 'github', code: '123'

        expect(flash[:success]).to be_present
      end

      it 'links the users github account if they are logged in' do
        OauthsController.any_instance.should_receive(:login_from).and_return(false)
        OauthsController.any_instance.should_receive(:add_provider_to_user).and_return(Authentication.new(user_id: '123', uid: '123', provider: 'github'))
        controller.instance_variable_set(:@user_hash, { user_info: { 'login' => 'alice.smith' } })

        alice = Fabricate(:user)
        session[:user_id] = alice.id
        get :callback, provider: 'github', code: '123'

        expect(flash[:success]).to be_present
      end

      it 'saves the users github login when it links the account' do
        OauthsController.any_instance.should_receive(:login_from).and_return(false)
        OauthsController.any_instance.should_receive(:add_provider_to_user).and_return(Authentication.create(user_id: '123', uid: '123', provider: 'github'))
        controller.instance_variable_set(:@user_hash, { user_info: { 'login' => 'alice.smith' } })

        alice = Fabricate(:user)
        session[:user_id] = alice.id
        get :callback, provider: 'github', code: '123'

        expect(assigns(:user).login).to eq('alice.smith')
      end

      it 'displays an error if there is a problem linking github account' do
        OauthsController.any_instance.should_receive(:login_from).and_return(false)
        OauthsController.any_instance.should_receive(:add_provider_to_user).and_return(false)

        alice = Fabricate(:user)
        session[:user_id] = alice.id
        get :callback, provider: 'github', code: '123'

        expect(flash[:danger]).to be_present
      end

      it 'displays an error if user is not logged in and their github account is not linked' do
        OauthsController.any_instance.should_receive(:login_from).and_return(false)

        get :callback, provider: 'github', code: '123'
        expect(flash[:danger]).to be_present
      end
    end

    describe "DELETE destroy" do
      context 'user is logged in' do
        let(:alice) { Fabricate(:user) }
        before { session[:user_id] = alice.id }

        it 'deletes linked account for logged in user' do
          Fabricate(:authentication, user: alice)

          delete :destroy, provider: 'github'
          expect(alice.authentications.count).to eq(0)
        end

        it 'displays a success message after unlinking the users oauth account' do
          Fabricate(:authentication, user: alice)

          delete :destroy, provider: 'github'
          expect(flash[:success]).to be_present
        end

        it 'displays an error if there is no linked account for the logged in user' do
          delete :destroy, provider: 'github'
          expect(flash[:danger]).to be_present
        end
      end

      context 'user is not logged in' do
        it 'does not delete any linked accounts' do
          alice = Fabricate(:user)
          Fabricate(:authentication, user: alice)
          delete :destroy, provider: 'github'
          expect(alice.authentications.count).to eq(1)
        end
      end
    end
end
