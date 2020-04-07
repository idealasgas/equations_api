require File.expand_path '../spec_helper.rb', __FILE__

describe "Equations Application" do
  it "should allow accessing the home page" do
    post '/', {equation: "x-6=0"}.to_json

    expect(last_response).to be_ok
  end
end
