require 'spec_helper'

describe Movie, "Movie モデルが設定されていない場合" do
  before :each do
    @movie = create(:movie)
  end
  it "タイトルが空欄の場合：バリデーションで失敗すること" do
    @movie.title = ""
    @movie.should_not be_valid
  end
  it "動画のURLが空欄の場合：バリデーションで失敗すること" do
    @movie.url = ""
    @movie.should_not be_valid
  end
  it "どのサイトのものが空欄の場合：バリデーションで失敗すること" do
    @movie.provider = ""
    @movie.should_not be_valid
  end

  describe "動画のURLのバリデーション" do
    it "動画のURLがhttp形式じゃない場合：バリデーションで失敗すること" do
      build(:movie, url: "hogehoge").should_not be_valid
    end
    it "動画のURLがhttp形式である場合：成功すること" do
      build(:movie, url: "http://www.youtube.com/watch?v=x3rjxpQ0EP4").should be_valid
    end
  end
end
