module PluginAWeek #:nodoc:
  module SmartFieldConstraints
    module Extensions #:nodoc:
      # Tracks validations on the length of fields so that they can be used when
      # generate form tags for those fields
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
              alias_method_chain :validates_size_of, :smart_constraints
            end
          end
          
          # Tracks what the maximum value that's allowed for all of the attributes
          # being validated
          def validates_length_of_with_smart_constraints(*attrs)
            track_length_constraints(attrs)
            validates_length_of_without_smart_constraints(*attrs)
          end
          
          # Tracks what the maximum value that's allowed for all of the attributes
          # being validated
          def validates_size_of_with_smart_constraints(*attrs)
            track_length_constraints(attrs)
            validates_size_of_without_smart_constraints(*attrs)
          end
          
          private
            def track_length_constraints(attrs)
              options = attrs.last
              if options.is_a?(Hash)
                # Extract the option restricting the length
                options = options.symbolize_keys
                range_options = ActiveRecord::Validations::ClassMethods::ALL_RANGE_OPTIONS & options.keys
                option = range_options.first
                option_value = options[range_options.first]
                
                # Find the max value from ranges or specific maximums
                max_length = nil
                case option
                when :within, :in
                  max_length = option_value.end
                when :maximum, :is
                  max_length = option_value
                end
                
                if max_length
                  # Store the maximum value for each attribute so that it can be referenced later
                  attrs.each do |attr|
                    self.smart_length_constraints ||= {}
                    self.smart_length_constraints[attr.to_s] = max_length
                  end
                end
              end
            end
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::SmartFieldConstraints::Extensions::Validations
end
