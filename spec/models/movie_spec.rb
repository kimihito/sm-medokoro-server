require 'spec_helper'

describe Movie, "Movie モデルを作成する場合" do
  describe "Movie.createするときのバリデーションチェック" do
    it "タイトルが空欄の場合：バリデーションで失敗すること" do
      movie = Movie.create(url: "http://www.youtube.com/", provider: "youtube")
      movie.errors.messages[:title].should include("can't be blank")
      movie.should_not be_valid
    end
    it "動画のURLが空欄の場合：バリデーションで失敗すること" do
      movie = Movie.create(title: "hogehoge", provider: "youtube")
      movie.errors.messages[:url].should include("can't be blank")
      movie.should_not be_valid
    end
    describe "動画のURLのバリデーション" do
      before :each do
        @movie = build(:movie, title: "movie-title", provider: "youtube")
      end
      it "動画のURLがhttp形式ない場合：保存されないこと" do
        @movie.url = "hoooo"
        @movie.save
        @movie.should_not be_valid
      end
      it "動画のURLがhttp形式である場合：保存されること" do
        @movie.url = "http://www.youtube.com/watch?v=x3rjxpQ0EP4"
        @movie.save
        @movie.should be_valid
      end
    end
    it "どのサイトのものが空欄の場合：バリデーションで失敗すること" do
      movie = Movie.create(title: "hogehoge",url: "http://www.youtube.com/")
      movie.errors.messages[:provider].should include("can't be blank")
      movie.should_not be_valid
    end
  end

end
