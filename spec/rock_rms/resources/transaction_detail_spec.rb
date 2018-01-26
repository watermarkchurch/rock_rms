require 'spec_helper'

RSpec.describe RockRMS::Client::TransactionDetail, type: :model do
  include_context 'resource specs'

  describe '#list_transaction_details' do
    it 'returns a array' do
      resource = client.list_transaction_details
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#find_transaction_detail(id)' do
    it 'returns a hash' do
      expect(client.find_transaction_detail(123)).to be_a(Hash)
    end

    it 'queries ' do
      expect(client).to receive(:get).with('FinancialTransactionDetails/123')
        .and_call_original

      resource = client.find_transaction_detail(123)

      expect(resource[:id]).to eq(345)
    end

    it 'formats with TransactionDetail' do
      response = double
      expect(RockRMS::Responses::TransactionDetail).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_transaction_detail(123)
    end
  end

  describe '#update_transaction_detail' do
    subject(:resource) do
      client.update_transaction_detail(
        123,
        fund_id: 2,
      )
    end

    it 'returns nothing' do
      expect(client.update_transaction_detail(123, fund_id: 5)).to eq(nil)
    end

    it 'passes options' do
      expect(client).to receive(:patch)
        .with(
          'FinancialTransactionDetails/123',
          'AccountId' => 2
        ).and_call_original
      resource
    end
  end
end