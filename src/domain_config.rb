require "English"

module Foobara
  module Generators
    module DomainGenerator
      class DomainConfig < Foobara::Model
        attributes do
          name :string, :required
          description :string, :allow_nil
          organization_name :string, :allow_nil
          full_module_name :string
        end

        attr_accessor :module_path

        def initialize(attributes = nil, options = {})
          full_module_name = attributes[:full_module_name]
          module_path = full_module_name&.split("::")
          name = attributes[:name]
          description = attributes[:description]
          organization_name = attributes[:organization_name]

          if organization_name.nil? && full_module_name.nil?
            full_module_name = name
            module_path = full_module_name.split("::")

            *organization_parts, name = module_path

            unless organization_parts.empty?
              organization_name = organization_parts.join("::")
            end
          end

          full_module_name ||= [*organization_name, *name].compact.join("::")

          super(
            {
              name:,
              description:,
              organization_name:,
              full_module_name:
            },
            options
          )

          self.module_path = module_path
        end
      end
    end
  end
end
