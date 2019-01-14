require 'oystercard'

RSpec.describe OysterCard do
  before(:each) do
    @oystercard = OysterCard.new
  end
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it "initializes with balance of 0" do
          expect(subject.balance).to eq(0)
      end

      describe '#top_up' do
          it "increases balance of card" do
              expect(subject.top_up(15)).to eq(15)
          end

          it "confirms balance is updated as expected" do
              @oystercard.top_up(15)
              expect(@oystercard.balance).to eq(15)
          end

          it 'raises error if new balance exceeds maximum balance' do
              maximum_balance = OysterCard::MAXIMUM_BALANCE
              subject.top_up(maximum_balance)
              expect { subject.top_up(1) }.to raise_error "ERROR!! The Maximum balance is £#{OysterCard::MAXIMUM_BALANCE}"
          end
      end

      describe '#deduct' do
        it "reduces balance by specified amount" do
          subject.top_up(10)
          expect(subject.deduct(10)).to eq(0)
        end

        it "raises error if amount deducted is greater than balance" do
          subject.top_up(5)
          expect { subject.deduct(10) }.to raise_error "Insufficient Funds"
        end
      end
end
