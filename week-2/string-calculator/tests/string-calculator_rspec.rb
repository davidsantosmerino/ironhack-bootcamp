require "rspec"
require ".././string-calculator"

RSpec.describe "String calculator" do

  before :all do
    @calculator = StringCalculator.new
  end

  it "return 0 for an empty string" do
    expect(@calculator.add("")).to eq(0)
  end

  it "return 2 when only that number" do
    expect(@calculator.add("2")).to eq(2)
  end

  it "return 8 when passing 4 4" do
    expect(@calculator.add("4 4")).to eq(8)
  end

  it "return 10 when passing 4 5 1" do
    expect(@calculator.add("4 5 1")).to eq(10)
  end

  it "return a fixnum" do
    expect(@calculator.add("3")).to be_a_kind_of(Fixnum)
  end

end
