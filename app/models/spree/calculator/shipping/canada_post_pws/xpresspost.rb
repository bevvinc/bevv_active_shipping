require_dependency 'spree/calculator'

module Spree
  module Calculator::Shipping
    module CanadaPostPws
      class Xpresspost < Spree::Calculator::Shipping::CanadaPostPws::Base
        def self.description
          Spree.t('canada_post_pws.xpresspost')
        end
      end
    end
  end
end
