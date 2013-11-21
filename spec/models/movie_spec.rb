require 'spec_helper'

describe Movie, "Movie モデルが設定されていない場合" do
  it "タイトルがない場合：バリデーションで失敗すること" do
    build(:movie, title: nil).should_not be_valid
  end
  it "動画のURLがない場合：バリデーションで失敗すること" do
    build(:movie, url: nil).should_not be_valid
  end
  it "どのサイトのものがない場合：バリデーションで失敗すること" do
    build(:movie, provider: nil).should_not be_valid
  end
end
