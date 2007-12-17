module PluginAWeek #:nodoc:
  module SmartFieldConstraints
    module Extensions #:nodoc:
      module InstanceTag
        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method_chain :to_input_field_tag, :smart_constraints
            alias_method_chain :to_text_area_tag, :smart_constraints
          end
        end
        
        # 
        def to_input_field_tag_with_smart_constraints(field_type, options = {})
          add_smart_constraints(options)
          to_input_field_tag_without_smart_constraints(field_type, options)
        end
        
        # 
        def to_text_area_tag_with_smart_constraints(options = {})
          add_smart_constraints(options)
          to_text_area_tag_without_smart_constraints(options)
        end
        
        private
          def add_smart_constraints(options)
            options.stringify_keys!
            if object && max_length = (object.class.smart_length_constraints[method_name] || (column = object.class.columns_hash[method_name]) && column.limit)
              options['maxlength'] ||= max_length
              options['size'] ||= [ActionView::Helpers::InstanceTag::DEFAULT_FIELD_OPTIONS['size'], max_length].min
            end
          end
      end
    end
  end
end

ActionView::Helpers::InstanceTag.class_eval do
  include PluginAWeek::SmartFieldConstraints::Extensions::InstanceTag
end
