require 'word_cruncher'
require 'strategy'

RSpec.describe WordCruncher do
  let(:strategy) { Strategy::Tempfile.new }
  let(:s) { strategy.create 'sequences' }
  let(:w) { strategy.create 'words' }

  subject { described_class.new s, w }

  describe '#process' do
    let(:dict) { %w(arrows) }

    it "should write to sequences file" do
      expect {
        subject.process dict
      }.to change { s.size }
    end

    it "should write to words file" do
      expect {
        subject.process dict
      }.to change { w.size }
    end

    describe 'sequences content' do
      before do
        subject.process dict
      end

      let(:content) { s.rewind; s.each.map(&:chomp) }

      it "should include all possible sequences" do
        expect(content.size).to eq 3
        expect(content).to include "arro"
        expect(content).to include "rrow"
        expect(content).to include "rows"
      end
    end

    describe 'words content' do
      before do
        subject.process dict
      end

      let(:content) { w.rewind; w.each.map(&:chomp) }

      it "should include words of sequences" do
        expect(content.size).to eq 3
        expect(content).to eq %w(arrows) * 3
      end
    end
  end
end
