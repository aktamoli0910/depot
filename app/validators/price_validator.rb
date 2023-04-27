class PriceValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if record.price < record.discount_price
        record.errors.add attribute, "should be greater than or equal to discount price as per custom validator"
      end
    end
end