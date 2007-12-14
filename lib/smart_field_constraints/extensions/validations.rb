module PluginAWeek #:nodoc:
  module SmartFieldConstraints
    module Extensions #:nodoc:
      module Validations
        def self.included(base) #:nodoc:
          base.class_eval do
            extend PluginAWeek::SmartFieldConstraints::Extensions::Validations::ClassMethods
          end
        end
        
        module ClassMethods
          def self.extended(base) #:nodoc:
            base.class_eval do
              class_inheritable_hash :smart_length_constraints
              self.smart_length_constraints = {}
            end
            
            class << base
              alias_method_chain :validates_length_of, :smart_constraints
            end
          end
          
          # 
          def validates_length_of_with_smart_constraints(*attrs)
            options = attrs.last
            if options.is_a?(Hash)
              options = options.symbolize_keys
              range_options = ActiveRecord::Validations::ClassMethods::ALL_RANGE_OPTIONS & options.keys
              option = range_options.first
              option_value = options[range_options.first]
              
              max_length = nil
              case option
              when :within, :in
                max_length = option_value.end
              when :maximum
                max_length = option_value
              end
              
              if max_length
                attrs.each do |attr|
                  smart_length_constraints[attr.to_s] = max_length
                end
              end
            end
            
            validates_length_of_without_smart_constraints(*attrs)
          end
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::SmartFieldConstraints::Extensions::Validations
end
