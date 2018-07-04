require 'rails_helper'

RSpec.describe User, type: :model do
  # # 姓、名、メール、パスワードがあれば有効な状態であること
  # it 'is valid with a first name, last name, email, and password' do
  #   user = User.new(
  #     first_name: 'Aaron',
  #     last_name: 'Sumner',
  #     email: 'tester@example.com',
  #     password: 'dottle-nouveau-pacilion-tights-furze'
  #   )
  #   expect(user).to be_valid
  # end

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  # 名がなければ無効な状態であること
  it 'is invalid without a first name' do
    user = FactoryGirl.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # 姓がなければ無効な状態であること
  it 'is invalid without a last name' do
    user = FactoryGirl.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  # メールアドレスがなければ無効な状態であること
  it 'is invalid without an email address' do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
    FactoryGirl.create(:user,
                       email: 'aaron@example.com')
    user = FactoryGirl.build(:user,
                             email: 'aaron@example.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    user = FactoryGirl.build(:user,
                            first_name: 'John',
                            last_name: 'Doe')

    expect(user.name).to eq 'John Doe'
  end

  it "can have many projects" do
    user = FactoryGirl.create(:user, :with_projects)
    expect(user.projects.length).to eq 2
  end
end
