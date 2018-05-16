require 'ext/string'

RSpec.describe String do
  let(:n) { 4 }
  subject { "arrows" }

  it { is_expected.to respond_to(:each_cons).with(1).argument }

  it "should generate a list of n-character sequences" do
    generator = subject.each_cons(n)

    expect(generator.next).to eq subject[0, n]
    expect(generator.next).to eq subject[1, n]
    expect(generator.next).to eq subject[2, n]
  end
end
