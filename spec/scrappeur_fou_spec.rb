require_relative '../lib/scrappeur_fou'


describe "the perform method" do
  it "Should not be empty" do
    expect(perform).to_not be_empty
  end

  it "Should return an array of strings" do
    expect(perform).to be_instance_of Array
  end

end