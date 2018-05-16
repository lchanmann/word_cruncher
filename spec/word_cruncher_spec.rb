require 'word_cruncher'
require 'strategy'

RSpec.describe WordCruncher do
  let(:strategy) { Strategy::Array.new }
  let(:sequences) { strategy.create 'sequences' }
  let(:words) { strategy.create 'words' }

  subject { described_class.new sequences, words }

  describe '#process' do
    let(:dict) { %w(arrows) }

    it "should write to sequences" do
      expect {
        subject.process dict
      }.to change { sequences.size }
    end

    it "should write to words" do
      expect {
        subject.process dict
      }.to change { words.size }
    end

    describe 'output contents' do
      before do
        subject.process dict
      end

      it "should include all possible sequences" do
        expect(sequences.size).to eq 3
        expect(sequences).to include "arro"
        expect(sequences).to include "rrow"
        expect(sequences).to include "rows"
      end

      it "should include words of sequences" do
        expect(words.size).to eq 3
        expect(words).to eq %w(arrows) * 3
      end

      context 'when a word is too short' do
        let(:dict) { %w(cat) }

        it "should not add it to sequences" do
          expect {
            subject.process dict
          }.not_to change { sequences.size }
        end

        it "should not add it to words" do
          expect {
            subject.process dict
          }.not_to change { words.size }
        end
      end

      context 'when a word has duplicate sequence' do
        let(:dict) { %w(soosoos) }

        it "should not include the sequence" do
          expect(sequences.size).to eq 2
          expect(sequences).not_to include "soos"
        end

        it "should have matching words" do
          expect(words.size).to eq 2
          expect(words).to eq %w(soosoos) * 2
        end
      end

      context 'when dictionary has duplicate sequences across words' do
        let(:dict) { File.new 'spec/support/dictionary.txt' }

        after do
          dict.close
        end

        it "should not include the sequences" do
          expect(sequences).not_to include "arro"
        end

        it "should include non duplicate sequences" do
          expect(sequences.size).to eq 6
          expect(sequences).to include "rows"
          expect(sequences).to include "rrow"
          expect(sequences).to include "carr"
          expect(sequences).to include "rrot"
          expect(sequences).to include "rots"
          expect(sequences).to include "give"
        end

        it "should have matching words" do
          expect(words.size).to eq 6
          expect(words[0]).to eq "arrows"
          expect(words[1]).to eq "arrows"
          expect(words[2]).to eq "carrots"
          expect(words[3]).to eq "carrots"
          expect(words[4]).to eq "carrots"
          expect(words[5]).to eq "give"
        end
      end
    end
  end
end
