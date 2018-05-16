require 'output_strategy'

RSpec.describe OutputStrategy do
  let(:filename) { '.testing' }
  let(:strategy) { OutputStrategy::File.new }

  subject { strategy.create filename }

  context 'when use array strategy' do
    let(:strategy) { OutputStrategy::Array.new }

    it "should create array instance" do
      is_expected.to be_a Array
    end

    it { is_expected.to respond_to(:puts) }
    it { is_expected.to respond_to(:path) }
    it { is_expected.to respond_to(:close) }
  end

  context 'when use file strategy' do
    after do
      subject.close
      File.delete filename
    end

    it "should create file instance" do
      is_expected.to be_a File
    end
  end

  context 'when use tempfile strategy' do
    let(:strategy) { OutputStrategy::Tempfile.new }

    after do
      subject.close
      subject.unlink
    end

    it "should create tempfile instance" do
      is_expected.to be_a Tempfile
    end
  end
end
