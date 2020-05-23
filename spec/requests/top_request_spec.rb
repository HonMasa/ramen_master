require 'rails_helper'

RSpec.describe 'Tops', type: :request do
  describe 'GET #index' do
    #正常にレスポンスを返すこと
    it 'responds successfully' do
      get root_path
      expect(response).to be_successful
    end
    #200レスポンスを返すこと
    it 'returns a 200 response' do
      get root_path
      expect(response).to have_http_status "200"
    end

  end
end
