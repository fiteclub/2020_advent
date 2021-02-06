require_relative '../day_05/boarding_00'
require_relative '../helpers'

fetchdata = get_data("day_05/test_input.txt", type = "array")
testdata = BoardingPassList.new(fetchdata)


# first tier
# F 0 - 63
# B 64 - 127

# second tier
# FF 0 - 63, 0 - 31
# FB 0 - 63, 32 - 63
# BF 64 - 127, 64 - 95
# BB 64 - 127, 96 - 127

RSpec.describe 'BoardingPass class' do
  # bptest = BoardingPass.new(testdata[0])
  # it 'creates a new boarding pass list object' do
  # end

  # it 'identifies the first range' do
  #   expect(bptest.range(0).min).to eq(0)
  #   expect(bptest.range(0).max).to eq(63)
  # end

  # it 'identifies the second range' do
  #   expect(bptest.range(1).min).to eq(32)
  #   expect(bptest.range(1).max).to eq(63)
  # end

  it 'converts to binary' do
    expect(testdata[0].bin).to.eq(0101100101)
    expect(testdata[1].bin).to.eq(1000110111)
  end

  it 'identifies the seat id' do
    expect(testdata[0].seat).to eq(457)
    expect(testdata[1].seat).to eq(567)
    expect(testdata[2].seat).to eq(119)
    expect(testdata[3].seat).to eq(820)
  end

  it 'identifies the row number' do
    expect(testdata[0].row).to eq(44)
    expect(testdata[1].row).to eq(70)
    expect(testdata[2].row).to eq(14)
    expect(testdata[3].row).to eq(102)
  end

  it 'identifies the column number' do
    expect(testdata[0].column).to eq(5)
    expect(testdata[1].column).to eq(7)
    expect(testdata[2].column).to eq(7)
    expect(testdata[3].column).to eq(4)
  end

end


# RSpec.describe "PassportList class" do
#   testlist = PassportList.new(data)
#   it "creates a new passport list object given raw text" do
#     expect(testlist.dirtylist[131]).to eq("iyr:2026 pid:184cm\necl:gmt hcl:z hgt:71cm\neyr:2029")
#   end
#   it "interpolates the text into individual passports" do
#     expect(testlist.list.first.length).to eq(9)
#     expect(testlist.list[250][:hcl]).to eq("#623a2f")
#   end

# end
