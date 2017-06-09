require 'rails_helper'

RSpec.describe Bug, type: :model do

  it { should belong_to(:state) }

  it { should validate_presence_of(:appToken) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:priority) }
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:state_id) }

  it { should validate_uniqueness_of(:number).scoped_to(:appToken) }

end
