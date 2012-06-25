Followable
==========
Make an ActiveRecord model followable, such as user follow user, user follow projects...etc.


Installation
------------
Add this line to your application's Gemfile:

::

    gem "followable"

And then execute:

::

    $ bundle install

Or install it yourself as:

::

    $ gem install followable

Create an migration file:

::

  rails g migration create_followships

Put the following content into the newly generated migration file:

::

  class CreateFollowships < ActiveRecord::Migration
    def change
      create_table :followships do |t|
        t.references :user
        t.references :followable, polymorphic: true

        t.timestamps
      end
      add_index :followships, :user_id
      add_index :followships, [:user_id, :followable_type]
      add_index :followships, [:followable_id, :followable_type]
      add_index :followships, [:user_id, :followable_id, :followable_type], unique: true,
        name: "index_followships_on_user_id_followable_id_followable_type"
    end
  end

apply the migration file:

::

  rake db:migrate


Installation finished!


Usage
-----
Suppose that you have an ActiveRecord model named Project which you want to make followable, open app/models/project.rb file, change its contents to like this:

::

  require "followable"

  class Project < ActiveRecord::Base
    #
    # Here is the content of your Project model
    #

    include Followable
  end


Then open rails console:

::

  user = User.new
  project = Project.new
  user.follow(project)
  project.followers
  user.followed_projects


Todo
----
#. make the User model name configurable
#. generator for db migration
#. turn "include Followable" to "followable" and no require statement needed
#. include follow and unfollow controller actions to support ajax?


Contributing
------------
#. Fork it
#. Create your feature branch (`git checkout -b my-new-feature`)
#. Commit your changes (`git commit -am 'Added some feature'`)
#. Push to the branch (`git push origin my-new-feature`)
#. Create new Pull Request
