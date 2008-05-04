module PluginAWeek #:nodoc:
  module SmartFieldConstraints
    module Extensions #:nodoc:
      # Automatically applies maximum length for an input field if it can be determined
      module InstanceTag
        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method_chain :to_input_field_tag, :smart_constraints
          end
        end
        
        # Applies constraints for the given field
        def to_input_field_tag_with_smart_constraints(field_type, options = {})
          options.stringify_keys!
          
          # Only check password and text fields
          if %w(password text).include?(field_type) && !options['maxlength'] && object
            # Look for the attribute's maximum length from tracked validations or
            # the column's definition
            max_length = object.class.smart_length_constraints[method_name] || (column = object.class.columns_hash[method_name]) && column.limit
            
            if max_length
              # If the size isn't specified, use the caller's maxlength of the default value.
              # This must be done here, otherwise it'll use the maxlength value that
              # we apply here
              options['size'] ||= options['maxlength'] || ActionView::Helpers::InstanceTag::DEFAULT_FIELD_OPTIONS['size']
              options['maxlength'] = max_length
            end
          end
          
          to_input_field_tag_without_smart_constraints(field_type, options)
        end
      end
    end
  end
end

ActionView::Helpers::InstanceTag.class_eval do
  include PluginAWeek::SmartFieldConstraints::Extensions::InstanceTag
end
