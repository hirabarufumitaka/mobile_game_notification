require 'rails_helper'

RSpec.describe "event_details", type: :system do
  describe 'イベント詳細機能' do
    let!(:event) { create(:event) }
    context 'event#showへアクセスする' do
      it 'イベント情報が表示されている' do
        visit event_path(event)
        expect(page).to have_content(event.name), 'イベント名が表示されていません'
        expect(page).to have_content(event.description), '詳細が表示されていません'
      end
    end
  end
end
