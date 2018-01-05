module Spree
  module Calculator::Shipping
    module Ups
      class WorldwideExpedited < Spree::Calculator::Shipping::Ups::Base
        def self.description
          Spree.t("ups.worldwide_expedited")
        end
      end
    end
  end
end
