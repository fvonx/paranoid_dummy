module ParanoidDummy

  class Dummy
    attr_reader :default

    def initialize
      @default = ''
    end

    def responds_to method, options = {}
      if options[:with].present?
        instance_variable_set "@#{method}".to_sym, options[:with]

        metaclass.send :redefine_method, method.to_sym do |*args|
          instance_variable_get "@#{method}".to_sym
        end
      end
    end

    def defaults_to value
      @default = value
    end

    def method_missing method, *args, &block
      return default unless self.respond_to? method
      super
    end

    def metaclass
      class << self; self; end
    end
  end

end
