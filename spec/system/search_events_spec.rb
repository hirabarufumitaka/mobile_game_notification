require 'rails_helper'

RSpec.describe "SearchEvents", type: :system do
  describe 'イベント検索機能' do
    let!(:event_app_1 ) { create(:event, name: 'アプリ1') }
    let!(:event_app_2) { create(:event, name: 'アプリ2') }
    context '名前であいまい検索する' do
      it 'キーワードに一致する名前の店舗が表示される' do
        visit events_path
        fill_in('q[name_or_description_cont]', with: '1')
        click_button '検索する'
        expect(page).to have_content(event_app_1.name), 'アプリ1が表示されていません'
        expect(page).not_to have_content(event_app_2.name), 'アプリ2が表示されてしまっている'
      end
    end
  end
end
