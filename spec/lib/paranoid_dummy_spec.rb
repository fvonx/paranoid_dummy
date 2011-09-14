require 'spec_helper'

describe ParanoidDummy do

  context '.define_paranoid_dummy' do
    it 'extends class with class method dummy' do
      User.should respond_to(:dummy)
      User.dummy.should be_a_kind_of(ParanoidDummy::Dummy)
    end
  end

  context 'associated object is nil' do
    before(:each) do
      @post_without_user = Post.create(subject: 'subject', body: 'body')
      @dummy             = @post_without_user.user
    end

    it 'returns object of class ParanoidDummy::Dummy' do
      @dummy.should be_a_kind_of(ParanoidDummy::Dummy)
    end

    it 'returns dummy object with predefined methods' do
      @dummy.should respond_to(:name)
      @dummy.name.should eql('deleted user')
    end

    it 'returns dummy object with predefined default return values' do
      @dummy.foobar.should eql('foo')
    end

    it 'returns dummy object that allows arbitrary method calls' do
      @dummy.amazing_method('foo', :bar, [], {}).should eql('foo')
    end
  end

  context 'associated object is not nil' do
    before(:each) do
      @user           = User.create(name: 'foobar')
      @post_with_user = Post.create(subject: 'subject', body: 'body', user: @user)
    end

    it 'returns associated object' do
      @post_with_user.user.should be(@user)
    end
  end

end
