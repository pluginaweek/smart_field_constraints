module PluginAWeek #:nodoc:
  module SmartFieldConstraints
    module Extensions #:nodoc:
      # Automatically applies the maximum length for an input field if it can be
      # determined
      module InstanceTag
        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method_chain :to_input_field_tag, :smart_constraints
          end
        end
        
        # Apply constraints for the given field
        def to_input_field_tag_with_smart_constraints(field_type, options = {})
          # Only check password and text fields
          add_max_length_constraints(options) if %w(password text).include?(field_type)
          
          to_input_field_tag_without_smart_constraints(field_type, options)
        end
        
        private
          def add_max_length_constraints(options)
            options.stringify_keys!
            return if options['maxlength'] || !object
            
            # Look for the attribute's maximum length from tracked validations or
            # the column's definition
            if max_length = validation_length || column_limit
              # If the size isn't specified, use the caller's maxlength of the default value.
              # This must be done here, otherwise it'll use the maxlength value that
              # we apply here
              options['size'] ||= options['maxlength'] || ActionView::Helpers::InstanceTag::DEFAULT_FIELD_OPTIONS['size']
              options['maxlength'] = max_length
            end
          end
          
          # Finds the maximum length according to validations
          def validation_length
            if constraints = object.class.smart_length_constraints
              constraints[method_name]
            end
          end
          
          # Finds the maximum length according to column limits
          def column_limit
            if column = object.class.columns_hash[method_name]
              column.limit
            end
          end
      end
    end
  end
end

ActionView::Helpers::InstanceTag.class_eval do
  include PluginAWeek::SmartFieldConstraints::Extensions::InstanceTag
end
