module ParanoidDummy

  extend ActiveSupport::Concern

  module ClassMethods
    def dummy; @dummy ||= Dummy.new; end

    def define_paranoid_dummy options = {}, &block
      if not options.is_a?(Hash) and not options.empty?
        raise ArgumentError, "Hash expected, got #{options.class.name}"
      end

      if block_given?
        dummy.instance_eval &block

        if options[:for].present? and options[:for].is_a?(Array)
          create_paranoid_methods_from_options options[:for]
        else
          create_paranoid_methods_from_associations
        end
      end
    end

    private

    def create_paranoid_methods_from_associations
      paranoid_associations.each do |association|
        create_paranoid_method_for association.class_name
      end
    end

    def create_paranoid_methods_from_options associations
      associations.each do |association|
        create_paranoid_method_for association
      end
    end

    def create_paranoid_method_for association
      klass           = self.name
      method          = klass.downcase.to_sym
      method_with_nil = "#{method}_with_nil".to_sym

      Kernel.const_get(association).class_eval do
        alias_method method_with_nil, method
        alias_method "origin_#{method}=".to_sym, "#{method}=".to_sym

        redefine_method method do
          eval "#{method_with_nil}.nil? ? #{klass}.dummy : #{method_with_nil}"
        end

        redefine_method "#{method}=".to_sym do |record|
          send("origin_#{method}=".to_sym, record) unless record.is_a?(ParanoidDummy::Dummy)
        end
      end
    end

    def paranoid_associations
      reflect_on_all_associations(:has_many) +
      reflect_on_all_associations(:has_one)
    end
  end

end
