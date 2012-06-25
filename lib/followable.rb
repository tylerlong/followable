require "followable/version"
require "followable/model_additions"

module Followable
  def self.included(model_class)
    model_class.send(:has_many, :followedships, class_name: "Followship", as: :followable)
    model_class.class_eval <<-EOF
      def followers
        Member.joins(:followships).where(followships: { followable_type: "#{model_class.to_s}", followable_id: self.id })
      end

      def followed_by?(member)
        self.followedships.where(member_id: member.id).exists?
      end
    EOF

    unless Member.instance_methods.include?(:unfollow)
      Member.send(:has_many, :followships)
      Member.class_eval <<-EOF
        def follow(model)
          self.followships.create(followable: model) unless followed?(model)
        end

        def unfollow(model)
          followship = self.followships.where(followable_type: model.class.to_s, followable_id: model.id).first
          followship.destroy if followship
        end

        def followed?(model)
          self.followships.where(followable_type: model.class.to_s, followable_id: model.id).exists?
        end
      EOF
    end
    Member.class_eval <<-EOF
      def followed_#{model_class.to_s.downcase.pluralize}
        #{model_class.to_s}.joins(:followedships).where(followships: { member_id: self.id })
      end
    EOF
  end
end
