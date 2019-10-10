require_relative '../lib/mairie_christmas'

describe "The get_townhalls_url method" do
  it "should return and array of hashes"
    expect(get_townhalls_url).to be_instance_of Array
  end

  it "should include http://annuaire-des-mairies.com/95/ableiges.html" do
    expect(get_townhalls_url).to include(http://annuaire-des-mairies.com/95/ableiges.html)
  end
end  

describe "The open_links method" do
  it "should return an array of hashes" do
    expect(open_links).to be_instance_of(array)
  end
end