require "rspec"
require ".././fizzbuzz"

RSpec.describe "FizzBuzz" do

  before :all do
    @fizzbuzz = FizzBuzz.new
  end

  it "return 'FizzBuzz' for a 0" do
    expect(@fizzbuzz.answer(0)).to eq("FizzBuzz")
  end

  it "return 8 for a 8" do
    expect(@fizzbuzz.answer(8)).to eq(8)
  end

  it "return 'Fizz' for a 3" do
    expect(@fizzbuzz.answer(3)).to eq("Fizz")
  end

  it "return 'Buzz' for a 5" do
    expect(@fizzbuzz.answer(5)).to eq("Buzz")
  end

  it "return 'FizzBuzz' for a 30" do
    expect(@fizzbuzz.answer(30)).to eq("FizzBuzz")
  end

end
