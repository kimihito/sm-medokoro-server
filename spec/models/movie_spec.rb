require 'spec_helper'

describe Movie do
  describe "validation" do
    context "正常なデータを入れた場合" do
      subject{ build(:movie)}
      it {expect(subject).to be_new_record}
      it {should be_valid}
    end

    context "異常なデータを入れた場合" do
      describe "validates :title, :url, :provider, presence: true" do
        context "タイトルが空欄" do
          subject { build(:movie, title: "") }
          it "失敗する" do
            expect(subject).to have(1).errors_on(:title)
          end
          it {should_not be_valid}
        end

        context "URLが空欄" do
          subject { build(:movie, url: "")}
          it "失敗する" do
            expect(subject).to have(2).errors_on(:url)
          end

          it {should_not be_valid}
        end

        context "providerが空欄" do
          subject { build(:movie, provider: "")}
          it "失敗する" do
            expect(subject).to have(1).errors_on(:provider)
          end

          it {should_not be_valid}
        end
      end


      describe "validates :url, specific_url: true" do
        context "URLが特定のものである" do
          context "URLがYoutubeである" do
            before(:each) do
              @movie = build(:url_youtube)
            end
            it {expect(@movie).to be_new_record}
            it {@movie.should be_valid}
          end
          context "URLがニコニコ動画である" do
            before(:each) do
              @movie = build(:url_niconico)
            end
            it {expect(@movie).to be_new_record}
            it {@movie.should be_valid}
          end
          context "URLがVimeoである" do
            before(:each) do
              @movie = build(:url_vimeo)
            end
            it {expect(@movie).to be_new_record}
            it {@movie.should be_valid}
          end
          context "URLがfc2である" do
            before(:each) do
              @movie = build(:url_fc2)
            end
            it {expect(@movie).to be_new_record}
            it {@movie.should be_valid}
          end
        end
        context "URLが特定のものではない" do
          subject{build(:invalid_url)}
          it "失敗する" do 
            expect(subject).to have(1).errors_on(:url)
          end
          it {should_not be_valid}
        end
      end
    end
  end
end
