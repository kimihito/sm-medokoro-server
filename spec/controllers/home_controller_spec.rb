require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    context "Movieモデルが１つもない場合" do
      it "リクエストが成功する" do
        get 'index'
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'errors/emptyが表示される' do
        get 'index'
        expect(response).to render_template('errors/empty')
      end
    end

    context "Movieモデルが存在する場合" do
      pending
    end
  end
end
