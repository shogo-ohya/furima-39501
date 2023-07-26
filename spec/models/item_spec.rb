require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "is not valid without an image" do
      item = build(:item, image: nil)
      expect(item).not_to be_valid
      expect(item.errors[:image]).to include("can't be blank")
    end

    it "is not valid without a category_id" do
      describe 'validations' do
        context 'when category_id is nil' do
          it "is not valid" do
            item = build(:item, category_id: nil)
            expect(item).not_to be_valid
            expect(item.errors[:category_id]).to include("can't be blank")
          end
        end
      end
    end

    it "is not valid without a name" do
      item = build(:item, name: nil)
      expect(item).not_to be_valid
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is not valid with a name longer than 40 characters" do
      item = build(:item, name: "a" * 41)
      expect(item).not_to be_valid
      expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    

    context 'when user is not associated' do
      it "is not valid" do
        item = build(:item, user: nil)
        expect(item).not_to be_valid
        expect(item.errors[:user]).to include("must exist")
      end
    end
  end

  context "price validations" do
    it "is not valid without a price" do
      item = build(:item, price: nil)
      expect(item).not_to be_valid
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "is not valid with a price less than 300" do
      item = build(:item, price: 299)
      expect(item).not_to be_valid
      expect(item.errors[:price]).to include("must be greater than or equal to 300")
    end

    it "is not valid with a price greater than 9,999,999" do
      item = build(:item, price: 10_000_000)
      expect(item).not_to be_valid
      expect(item.errors[:price]).to include("must be less than or equal to 9999999")
    end

    it "is not valid with a non-numeric price" do
      item = build(:item, price: "abc")
      expect(item).not_to be_valid
      expect(item.errors[:price]).to include("is not a number")
    end
  end
end

