require 'spec_helper'

describe Project do
=begin
  bedore(:all) do
    @project = FactoryGirl()
  end
=end

it { should validate_presence_of(:name) }


end
