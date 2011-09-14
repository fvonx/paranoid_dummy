# ParanoidDummy

Replaces deleted active record associations with a predefined dummy object.

## Installation

Add the gem to your Gemfile:

    gem 'paranoid_dummy'


## Usage

To use the gem just call the class method define_paranoid_dummy within your active record model.

### Example

In the Example below define_paranoid_dummy is being called within the User model because users exist as belongs_to associations in other models.
ParanoidDummy automatically patches the classes the User model has has_many and has_one associations to.

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
