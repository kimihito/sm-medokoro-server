require 'spec_helper'

describe Movie, "Movie モデルが設定されていない場合" do
  it "タイトルがない場合：バリデーションが失敗すること" do
    FactoryGirl.create(:movie).should be_vaild
  end
  it "動画のURLがない場合：バリデーションが失敗すること"
  it "どのサイトのものがない場合：バリデーションが失敗すること"
end
