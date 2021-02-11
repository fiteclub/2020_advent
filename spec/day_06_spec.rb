require_relative '../day_06/customs_00'
require_relative '../helpers'

testdata = "abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb\n"
testplane = CustomsPlane.new(testdata)
testgroup = testplane.groups[1]


RSpec.describe 'CustomsPlane class' do
  it 'returns the original input string' do
    expect(testplane.plane).to eq(testdata)
  end

  it 'returns groups of passengers' do
    expect(testplane.groups.count).to eq(5)
    expect(testplane.groups[1].passengers).to eq(['a','b','c'])
  end

  it 'returns letters and sum of yes answers' do
    expect(testplane.totals).to eq({:a=>8, :b=>4, :c=>3})
  end

  it 'returns letters marked yes' do
    expect(testplane.saidyes).to eq(11)
  end

  it 'returns the sum of questions marked yes by all in each group' do
    expect(testplane.allsaidyes).to eq(6)
  end
end

RSpec.describe 'CustomsGroup class' do
  it 'returns passenger answers' do
    expect(testplane.groups[1].passengers).to eq(['a','b','c'])
  end 

  it 'returns a hash of the group answers' do
    expect(testplane.groups[1].totals).to eq({:a=>1, :b=>1, :c=>1})
  end

  it 'returns number of questions marked yes' do
    expect(testplane.groups[2].yes).to eq(3)
    expect(testplane.groups[3].yes).to eq(1)
  end

  it 'returns number of questions marked yes by all' do
    expect(testplane.groups[0].allyes).to eq(3)
    expect(testplane.groups[1].allyes).to eq(0)
    expect(testplane.groups[2].allyes).to eq(1)
    expect(testplane.groups[3].allyes).to eq(1)
    expect(testplane.groups[4].allyes).to eq(1)
  end
end
