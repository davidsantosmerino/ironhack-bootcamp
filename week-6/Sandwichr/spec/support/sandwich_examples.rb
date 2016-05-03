RSpec.shared_examples "an success" do
  it "renders json with code 200" do
    expect(response.content_type).to eq "application/json"
    expect(response.code).to eq "200"
  end
end

RSpec.shared_examples "an error handler" do
  it "renders json with code 404" do
    expect(response.content_type).to eq "application/json"
    expect(response.code).to eq "404"
  end
  it "renders an error message" do
    expect(response.body).to include "Sandwich with id #{invalid_id} not found"
  end
end
