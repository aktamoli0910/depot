class UrlValidator < ActiveModel::EachValidator
    VALID_URL_FORMAT = /\.(gif|png|jpg)/i
    def validate_each(record, attribute, value)
      unless value =~ VALID_URL_FORMAT
        record.errors.add attribute, (options[:message] || "is not a valid url")
      end
    end
end