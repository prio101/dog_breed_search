require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomesHelper. For example:
#
# describe HomesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HomesHelper, type: :helper do
  describe "#breed_name_formatted" do
    it "returns the breed name formatted for url" do
      expect(breed_name_formatted("German Shepherd")).to eq("german-shepherd")
    end
  end
end
