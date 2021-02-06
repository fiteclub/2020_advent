require_relative '../day_05/boarding_00'
require_relative '../helpers'

testdata = BoardingPassList.new(get_data("day_05/test_input.txt", type = "array"))
testempty = BoardingPassList.new(["0000001000", "0000001001", "0000001011", "0000001100", "0000001111"])



# first tier
# F 0 - 63
# B 64 - 127

# second tier
# FF 0 - 63, 0 - 31
# FB 0 - 63, 32 - 63
# BF 64 - 127, 64 - 95
# BB 64 - 127, 96 - 127

RSpec.describe 'BoardingPass class' do
  it 'converts to binary' do
    expect(testdata[0].bin).to eq("0101100101".to_i)
    expect(testdata[1].bin).to eq("1000110111".to_i)
  end

  it 'identifies the seat id' do
    expect(testdata[0].seat).to eq(357)
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

RSpec.describe 'BoardingPassList class' do
  it 'find the maximum seat number' do
    expect(testdata.maxseat).to eq(820)
  end

  it 'finds missing values between min and max' do
    expect(testempty.emptyseat[0]).to eq(10)
    expect(testempty.emptyseat[1]).to eq()
  end

end


RSpec.describe 'base_ten_to_binary' do
  it 'returns an array of 10-digit binary strings, given an array of integers' do
    expect(base_ten_to_binary_string((100..102).to_a)).to eq(["0001100100", "0001100101", "0001100110"])
  end
end

RSpec.describe 'binary_to_boarding_code' do
  it 'returns an array of boarding codes, given an array of binary numbers' do
    
    expect(binary_to_boarding_code(base_ten_to_binary_string([567,119]))[0]).to eq(
      ["BFFFBBFRRR", "FFFBBBFRRR"]
    )
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
