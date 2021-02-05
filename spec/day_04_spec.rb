require_relative '../day_04/passport_00'
require_relative '../helpers'

data = get_data("day_04/input.txt")

RSpec.describe "PassportList class" do
  testlist = PassportList.new(data)
  it "creates a new passport list object given raw text" do
    expect(testlist.dirtylist[131]).to eq("iyr:2026 pid:184cm\necl:gmt hcl:z hgt:71cm\neyr:2029")
  end
  it "interpolates the text into individual passports" do
    expect(testlist.list.first.length).to eq(9)
    expect(testlist.list[250][:hcl]).to eq("#623a2f")
  end

end

RSpec.describe "Part One" do
  testlist = PassportList.new(data)
  testlist2 = PassportList.new(get_data("day_04/passport_01_test_input.txt"))
  
  it "counts valid passports" do
    expect(testlist.count_valid).to eq(230)
  end

  it "returns invalid if missing any fields except cid" do
    expect(testlist2.is_valid(testlist2.list[0])).to eq(true)
    expect(testlist2.is_valid(testlist2.list[8])).to eq(true)
  end

  it "returns invalid if missing birth year (byr)" do
    expect(testlist2.is_valid(testlist2.list[1])).to be false
  end

  it "returns invalid if missing issue year (iyr)" do
    expect(testlist2.is_valid(testlist2.list[2])).to be false
  end

  it "returns invalid if missing expiration year (eyr)" do
    expect(testlist2.is_valid(testlist2.list[3])).to be false
  end

  it "returns invalid if missing height (hgt)" do
    expect(testlist2.is_valid(testlist2.list[4])).to be false
  end

  it "returns invalid if missing hair color (hcl)" do
    expect(testlist2.is_valid(testlist2.list[5])).to be false
  end

  it "returns invalid if missing eye color (ecl)" do
    expect(testlist2.is_valid(testlist2.list[6])).to be false
  end
  
  it "returns invalid if missing passport id (pid)" do
    expect(testlist2.is_valid(testlist2.list[7])).to be false
  end

  it "returns valid if missing country id (cid)" do
    expect(testlist2.is_valid(testlist2.list[8])).to eq(true)
  end
  
end

RSpec.describe "Part Two" do
  testlist3 = PassportList.new(get_data("day_04/passport_02_test_input.txt"))
  testlist3.newvalid = true
  
  # it "validates passports using the new method" do
  #   expect(testlist3.valid).to eq(2)
  # end
  
  # it "returns invalid if missing any fields except cid" do
  #   expect(testlist3.is_valid(testlist3.list[0])).to eq(true)
  # end

  it "returns invalid if birth year (byr) less than 1920" do
    expect(testlist3.list[1][:byr].to_i).to be < 1920
    expect(testlist3.is_valid(testlist3.list[1])).to be false
  end

  it "returns invalid if birth year (byr) greater than than 2002" do
    expect(testlist3.list[2][:byr].to_i).to be > 1920
    expect(testlist3.is_valid(testlist3.list[2])).to be false
  end

  it "returns invalid if issue year (iyr) less than 2010" do
    expect(testlist3.list[3][:iyr].to_i).to be < 2010
    expect(testlist3.is_valid(testlist3.list[3])).to be false
  end

  it "returns invalid if issue year (iyr) greater than than 2020" do
    expect(testlist3.list[4][:iyr].to_i).to be > 2020
    expect(testlist3.is_valid(testlist3.list[4])).to be false
  end
  
  it "returns invalid if expiration year (eyr) less than 2020" do
    expect(testlist3.list[5][:eyr].to_i).to be < 2020
    expect(testlist3.is_valid(testlist3.list[5])).to be false
  end

  it "returns invalid if expiration year (eyr) greater than than 2020" do
    expect(testlist3.list[6][:eyr].to_i).to be > 2030
    expect(testlist3.is_valid(testlist3.list[6])).to be false
  end
  
  it "returns invalid if height (hgt) does not contain a number followed by in or cm" do
    expect(testlist3.list[7][:hgt].count('in')).to be == 0
    expect(testlist3.list[7][:hgt].count('cm')).to be == 0
    expect(testlist3.is_valid(testlist3.list[7])).to be false
  end

  it "returns invalid if height (hgt) less than than 150cm" do
    expect(testlist3.list[8][:hgt].count('in')).to be == 0
    expect(testlist3.list[8][:hgt].count('cm')).to be > 0
    expect(testlist3.list[8][:hgt].scan(/^[0-9]*/).first.to_i).to be < 150
    expect(testlist3.is_valid(testlist3.list[8])).to be false
  end

  it "returns invalid if height (hgt) greater than than 193" do
    expect(testlist3.list[9][:hgt].count('in')).to be == 0
    expect(testlist3.list[9][:hgt].count('cm')).to be > 0
    expect(testlist3.list[9][:hgt].scan(/^[0-9]*/).first.to_i).to be > 193
    expect(testlist3.is_valid(testlist3.list[9])).to be false
  end

  it "returns invalid if height (hgt) less than than 59in" do
    expect(testlist3.list[10][:hgt].count('in')).to be > 0
    expect(testlist3.list[10][:hgt].count('cm')).to be == 0
    expect(testlist3.list[10][:hgt].scan(/^[0-9]*/).first.to_i).to be < 59
    expect(testlist3.is_valid(testlist3.list[10])).to be false
  end

  it "returns invalid if height (hgt) greater than than 76in" do
    expect(testlist3.list[11][:hgt].count('in')).to be > 0
    expect(testlist3.list[11][:hgt].count('cm')).to be == 0
    expect(testlist3.list[11][:hgt].scan(/^[0-9]*/).first.to_i).to be > 76
    expect(testlist3.is_valid(testlist3.list[11])).to be false
  end

  it "returns invalid if hair color (hcl) does not contain a valid hex color" do
    expect(testlist3.list[12][:hcl].match(/^#(?:[0-9a-fA-F]{3}){1,2}$/).to_s).to_not eq(testlist3.list[12][:hcl])
    expect(testlist3.is_valid(testlist3.list[12])).to be false
  end
  # it "returns invalid if missing expiration year (eyr)" do
  #   expect(testlist2.is_valid(testlist2.list[3])).to be false
  # end

  # it "returns invalid if missing height (hgt)" do
  #   expect(testlist2.is_valid(testlist2.list[4])).to be false
  # end

  # it "returns invalid if missing hair color (hcl)" do
  #   expect(testlist2.is_valid(testlist2.list[5])).to be false
  # end

  # it "returns invalid if missing eye color (ecl)" do
  #   expect(testlist2.is_valid(testlist2.list[6])).to be false
  # end
  
  # it "returns invalid if missing passport id (pid)" do
  #   expect(testlist2.is_valid(testlist2.list[7])).to be false
  # end

  # it "returns valid if missing country id (cid)" do
  #   expect(testlist2.is_valid(testlist2.list[8])).to eq(true)
  # end



end
