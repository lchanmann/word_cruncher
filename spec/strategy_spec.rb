require 'strategy'

RSpec.describe Strategy do
  let(:filename) { '.testing' }
  let(:strategy) { Strategy::File.new }

  subject { strategy.create filename }

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
    let(:strategy) { Strategy::Tempfile.new }

    after do
      subject.close
      subject.unlink
    end

    it "should create tempfile instance" do
      is_expected.to be_a Tempfile
    end
  end
end
