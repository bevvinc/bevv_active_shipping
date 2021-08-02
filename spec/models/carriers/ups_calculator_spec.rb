require 'spec_helper'

describe Spree::Calculator::Shipping::Ups do
  let(:address) { FactoryBot.create(:address) }
  let(:variant_1) { FactoryBot.create(:variant, weight: 1) }
  let(:variant_2) { FactoryBot.create(:variant, weight: 2) }
  let!(:order) do
    FactoryBot.create(:order_with_line_items, ship_address: address, line_items_count: 2,
                       line_items_attributes: [{ quantity: 2, variant: variant_1}, { quantity: 2, variant: variant_2 }] )
  end

  let(:carrier) { ActiveShipping::UPS.new(login: 'test', password: 'test', key: 'test') }
  let(:calculator) { Spree::Calculator::Shipping::Ups::Ground.new }
  let(:package) { order.shipments.first.to_package }

  before(:each) do
    order.create_proposed_shipments
    Spree::ActiveShipping::Config.set(units: 'imperial')
    Spree::ActiveShipping::Config.set(unit_multiplier: 1)
    Spree::ActiveShipping::Config.set(handling_fee: 0)

    stub_request(:post, %r{https:\/\/wwwcie.ups.com\/ups.app\/xml\/Rate})
        .to_return(body: fixture(:normal_rates_request))

    # Since the response can be cached, we explicitly clear cache
    # so each test can be run from a clean slate
    Rails.cache.delete(calculator.send(:cache_key, package))
  end

  describe 'compute' do
    subject { calculator.compute(package) }

    it 'should use the carrier supplied in the initializer' do
      expect(subject).to eq 11.86
    end

    context 'with valid response' do
      it "should return rate based on calculator's service_code" do
        allow(calculator.class).to receive(:service_code) { '03' }
        expect(subject).to eq 11.86
      end

      it 'should include handling_fee when configured' do
        Spree::ActiveShipping::Config.set(handling_fee: 100)
        allow(calculator.class).to receive(:service_code) { '03' }
        expect(subject).to eq 12.86
      end
    end

    context 'with invalid response' do
      before do
        allow(calculator).to receive(:carrier).and_return(carrier)
        allow(carrier).to receive(:find_rates).and_raise(::ActiveShipping::ResponseError)
      end

      it 'should raise a Spree::ShippingError' do
        expect{ subject }.to raise_exception(Spree::ShippingError)
      end
    end
  end

  describe 'service_name' do
    it 'should return description when not defined' do
      expect(calculator.class.service_name).to eq calculator.description
    end
  end
end
