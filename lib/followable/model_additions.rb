module Followable
  module ModelAdditions
    def followable_by(model_class)
      has_many :followedships, class_name: "Followship", as: :followable
    end
  end
end
