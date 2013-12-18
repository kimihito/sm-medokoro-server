class SpecificUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    url = URI.parse(value)
    unless url.host =~ /(www.youtube.com)|(www.nicovideo.jp)|(vimeo.com)|(video.fc2.com)/
      record.errors[attribute] << (options[:message] || "is not specific url")
    end
  end
end