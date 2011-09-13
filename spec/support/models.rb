class User < ActiveRecord::Base
  has_many :posts

  define_paranoid_dummy do
    responds_to :name, with: 'deleted user'
  end
end

class Post < ActiveRecord::Base
  belongs_to :user
end
