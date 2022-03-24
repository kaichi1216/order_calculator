require_relative '../../model/user'

describe User do
  context "new user" do
    it "user id should be 1" do
      user = User.new(1)
      expect(user.id).to eq(1)
    end
  end
end