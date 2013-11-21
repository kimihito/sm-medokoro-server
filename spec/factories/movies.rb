FactoryGirl.define do
  factory :movie do
    title "hoge-movie-title"
    url "http://www.youtube.com/"
    provider "twitter"
  end
end
