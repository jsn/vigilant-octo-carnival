module NotifiesParent
  extend ActiveSupport::Concern

  included do
    define_model_callbacks :association_changed, only: [:after]
  end

  class_methods do
    def notifies_parent rel
      block = proc do |rec|
        rec.send(rel).run_callbacks :association_changed
      end

      after_save(&block)
      after_destroy(&block)
    end
  end
end
