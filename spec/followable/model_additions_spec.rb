require "spec_helper"

class User < SuperModel::Base
end

class Project < SuperModel::Base
  extend UrlFormatter::ModelAdditions
end

describe Followable::ModelAdditions do
  # specs omitted
end
