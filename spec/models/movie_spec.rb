require 'spec_helper'

describe Movie do
  context "タイトルが空欄のところ" do
    subject { build(:movie, title: "") }
    it "タイトルがないことで失敗する" do
      expect(subject).to have(1).errors_on(:title)
    end

    it {should_not be_valid}
  end

  context "URLが空欄である" do
    subject { build(:movie, url: "")}
    it "URLがないことで失敗する" do
      expect(subject).to have(1).errors_on(:url)
    end

    it {should_not be_valid}
  end

  context "providerが空欄である" do
    subject { build(:movie, provider: "")}
    it "providerがないことで失敗する" do
      expect(subject).to have(1).errors_on(:provider)
    end

    it {should_not be_valid}
  end
end
