require 'spec_helper'

describe Steam do

  it 'should do things' do
    user = Steam::User.new(steamid: 76561197993276293)
    user.friends(:all).should be_nil 

    # req = client.get_friends(key: @apikey, steamid: 76561197993276293, relationship: :all)
  end

end
