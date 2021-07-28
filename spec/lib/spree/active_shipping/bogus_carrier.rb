module Spree
  module ActiveShipping
    # Bogus carrier useful for testing.  For some reasons the plugin version of this class does not work
    # properly (it fails to return a RateResponse)
    class BogusCarrier < ::ActiveShipping::Carrier

      def name
        "BogusCarrier"
      end

      # We're stubbing the rates because actual RateEstimate are too elaborate
      def find_rates(origin, destination, packages, options = {})
        ::ActiveShipping::RateResponse.new(true, "success!", {}, :rates => [::ActiveShipping::RateEstimate.new(nil, nil, nil, 'Bogus Calculator', { total_price: 999, currency: 'USD' })], :xml => "")
      end
    end
  end
end
