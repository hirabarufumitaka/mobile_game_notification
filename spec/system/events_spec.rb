require 'rails_helper'

RSpec.describe "Events", type: :system do
  describe 'イベント一覧機能' do
    before do
      create_list(:event, 25)
    end
    context 'event#indexへアクセスする' do
      it 'イベントが20件表示されていること' do
        visit events_path
        expect(all('.event-card').count).to eq(20), '1ぺージに20件表示されていません'
      end
      it 'ページネーション次のページに5件表示されていること' do
        visit events_path
        click_link '2'
        sleep 1
        expect(all('.event-card').count).to eq(5), 'ぺージネーションが機能していません'
      end
    end
  end
end
