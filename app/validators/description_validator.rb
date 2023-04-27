class DescriptionValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        return unless value
        unless value.split.size.between?(5,10)
            record.errors.add attribute, "should between 5 and 10 words"
        end
    end
end