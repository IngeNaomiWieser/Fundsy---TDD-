require 'rails_helper'


# We use Rspec describe to define the subject of our test which is in this case the Campain model. We can also shorten it for 'describe' and you can also use it to set a group of tests as we will see below.
RSpec.describe Campaign, type: :model do


  #it's a good idea to group related tests together using 'describe' or 'context' which are functionaly the same but semantically different.
  describe 'validations' do

    # To define a test in RSpec we use 'it' or 'specify' methods and we should give them descriptive texts. The 'it' and 'specify' methotds take in a block of code which contain your actual test code. We all this a test example or test scenario.
    it 'requires a title' do
      #GIVEN: a new campain with no title
      c = Campaign.new
      #WHEN you invoke validations on the campaign
      c.valid?
      #THEN: There is an error attached on the title of the campaign.

      # We use 'expect' to theck the outcome of tests in RSpec
      # We usually call 'to' on the 'expect' with a 'matcher', in this case the matcher is 'have_key' which checks if a Hash has a particular key. RSpec and RSpec Rails come with many matchers that make checking outcome easier.
      #Note : eq is an equality matcher.
      expect(c.errors).to have_key(:title)
      # expect(c.errors[:title].present?).to eq(true)      -> different syntax, but the same.
      # you can also do: expect(c).to be_invalid
    end

    it 'require a unique title' do
      # GIVEN: a campaign in the base with a title and a new Campaign object
      #        instantiated with the same title
      Campaign.create({ title: 'abc', body: 'hello', goal: 100 })
      c = Campaign.new({ title: 'abc' })
      # WHEN: we invoke validations
      c.valid?
      # THEN: There is an error on the title field
      expect(c.errors).to have_key(:title)
    end

    it 'requires the goal to be $10 or more' do
     c = Campaign.new title: 'abc', body: 'xyz', goal: 9
     c.valid?
     expect(c.errors).to have_key(:goal)
   end

  end




end
