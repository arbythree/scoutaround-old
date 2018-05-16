require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'yields a proper Google Maps link' do
    location = "17 Deer Run Rd, Cimarron, NM 87714"
    expect(google_maps_link(location)).to eq("https://www.google.com/maps/place/#{location.gsub(' ', '+')}")    
  end
end
