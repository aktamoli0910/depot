class PermalinkValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        return unless value
        if value.split('-').size < 3
          record.errors.add attribute, "should atleast be 3"
        end
    end
end