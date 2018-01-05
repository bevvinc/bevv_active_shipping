require_dependency 'spree/calculator'

module Spree
  module Calculator::Shipping
    module CanadaPostPws
      class Expedited < Spree::Calculator::Shipping::CanadaPostPws::Base
        def self.description
          Spree.t('canada_post_pws.expedited')
        end
      end
    end
  end
end
