require_relative '../day_06/customs_00'
require_relative '../helpers'


# How are you going to do this? Part One:
# 1) Separate input into group array with member hashes for answers
#    example: group[2][3] = 'c'
#
# 2) Create a main array of empty letter hashes with a-z keys,
#    and int values for the sum of each group
#    example: group[1] = {a: 1, b: 1, c: 1}
#
# 3) Iterate over each member in each group, adding to the
#    appropriate group letter key's sum
#
# 4) Iterate over each group, incrementing an a-z hash each time a
#    letter is answered by anyone in the group, but only once for
#    the group.
#
# 4) Profit

# Plane class
# CustomsGroup class
# Member class
# A Plane has many CustomsGroups
# A CustomsGroup has many Members
# A Member has one answers string

testdata = get_data('day_06/test_input.txt')
# Each line is one person within a group.
# Group breaks where there are two newlines

RSpec.describe 'Plane class' do
  it 'sums the answers of all groups, returns a hash '
end

RSpec.describe 'CustomsGroup class' do
  it 'converts raw input into member answers' do
    # expect(testgroup.members)
  end

  it 'sums the answers of group members, returns a hash' do
    # expect(testgroup.sum)
  end

  it 'returns a hash of letters answered at least once' do
    # expect(testgroup.uniq)
  end
end

RSpec describe 'Member class' do
  it 'returns a hash of letters' do
    # expect(testmember.answers).to eq({a})
  end
end
