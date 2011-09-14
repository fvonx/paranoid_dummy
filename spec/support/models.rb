class Post < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :posts

  define_paranoid_dummy do
    responds_to :name, with: 'deleted user'
    defaults_to 'foo'
  end
end
