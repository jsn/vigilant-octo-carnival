module NotifiesParent
  extend ActiveSupport::Concern

  included do
    define_model_callbacks :association_changed, only: [:after]
  end

  class_methods do
    def notifies_parent *rels
      rels.each do |rel|
        unless reflect_on_association(rel).macro == :belongs_to
          raise "#{rel} is not a `belongs_to`"
        end
      end
      block = proc do |rec|
        rels.each do |rel|
          rec.send(rel).run_callbacks :association_changed
        end
      end

      after_save(&block)
      after_destroy(&block)
    end
  end
end
