require 'word_cruncher'

RSpec.describe WordCruncher do
  let(:strategy) { Strategy::Tempfile.new }
  let(:s) { strategy.create 'sequences' }
  let(:w) { strategy.create 'words' }

  subject { described_class.new s, w }

  after do
    s.close; s.unlink
    w.close; w.unlink
  end

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

    describe 'output contents' do
      before do
        subject.process dict
      end

      let(:s_content) { s.rewind; s.each.map(&:chomp) }
      let(:w_content) { w.rewind; w.each.map(&:chomp) }

      it "should include all possible sequences" do
        expect(s_content.size).to eq 3
        expect(s_content).to include "arro"
        expect(s_content).to include "rrow"
        expect(s_content).to include "rows"
      end

      it "should include words of sequences" do
        expect(w_content.size).to eq 3
        expect(w_content).to eq %w(arrows) * 3
      end

      context 'when a word is too short' do
        let(:dict) { %w(cat) }

        it "should not add it to sequences file" do
          expect {
            subject.process dict
          }.not_to change { s.size }
        end

        it "should not add it to words file" do
          expect {
            subject.process dict
          }.not_to change { w.size }
        end
      end

      context 'when a word has duplicate sequence' do
        let(:dict) { %w(soosoos) }

        it "should not include the sequence" do
          expect(s_content.size).to eq 2
          expect(s_content).not_to include "soos"
        end

        it "should have matching words" do
          expect(w_content.size).to eq 2
          expect(w_content).to eq %w(soosoos) * 2
        end
      end

      context 'when having duplicate sequences across words' do
        let(:dict) { %w(arrows carrots give me) }

        it "should not include the sequences" do
          expect(s_content).not_to include "arro"
        end

        it "should include non duplicate sequences" do
          expect(s_content.size).to eq 6
          expect(s_content).to include "rows"
          expect(s_content).to include "rrow"
          expect(s_content).to include "carr"
          expect(s_content).to include "rrot"
          expect(s_content).to include "rots"
          expect(s_content).to include "give"
        end

        it "should have matching words" do
          expect(w_content.size).to eq 6
          expect(w_content[0]).to eq "arrows"
          expect(w_content[1]).to eq "arrows"
          expect(w_content[2]).to eq "carrots"
          expect(w_content[3]).to eq "carrots"
          expect(w_content[4]).to eq "carrots"
          expect(w_content[5]).to eq "give"
        end
      end
    end
  end
end
