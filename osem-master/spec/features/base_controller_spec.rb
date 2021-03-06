require 'spec_helper'

feature 'BaseController' do
  let(:conference) { create(:conference) }
  let(:user) { create(:user) }

  let!(:organizer_role) { create(:role, name: 'organizer', resource: conference) }
  let!(:volunteers_coordinator_role) { create(:role, name: 'volunteers_coordinator', resource: conference) }
  let!(:cfp_role) { create(:role, name: 'cfp', resource: conference) }
  let!(:info_desk_role) { create(:role, name: 'info_desk', resource: conference) }
  let!(:speaker_role) { create(:role, name: 'speaker', resource: conference) }

  describe 'GET #verify_user_admin' do
    context 'when user is a guest' do
      it 'redirects to sign in page' do
        visit admin_conference_index_path
        expect(current_path).to eq new_user_session_path
      end
    end

    context 'when user is ' do
      before(:each) do
        sign_in(user)
      end

      it 'not an admin it redirects to root_path' do
        user.is_admin = false
        visit admin_conference_index_path
        expect(current_path).to eq root_path
        expect(flash).to eq 'You are not authorized to access this area!'
      end

      it 'a speaker it redirects to the root_path' do
        user.is_admin = false
        user.role_ids = speaker_role.id
        visit admin_conference_index_path
        expect(current_path).to eq root_path
        expect(flash).to eq 'You are not authorized to access this area!'
      end

      it 'an admin he can access the admin area' do
        user.is_admin = true
        visit admin_conference_index_path
        expect(current_path).to eq admin_conference_index_path
      end

      it 'an organizer he can access the admin area' do
        user.is_admin = false
        user.role_ids = organizer_role.id
        visit admin_conference_index_path
        expect(current_path).to eq admin_conference_index_path
      end

      it 'a volunteers_coordinator he can access the admin area' do
        user.is_admin = false
        user.role_ids = volunteers_coordinator_role.id
        visit admin_conference_index_path
        expect(current_path).to eq admin_conference_index_path
      end

      it 'a cfp he can access the admin area' do
        user.is_admin = false
        user.role_ids = cfp_role.id
        visit admin_conference_index_path
        expect(current_path).to eq admin_conference_index_path
      end

      it 'an info_desk he can access the admin area' do
        user.is_admin = false
        user.role_ids = info_desk_role.id
        visit admin_conference_index_path
        expect(current_path).to eq admin_conference_index_path
      end
    end
  end
end
