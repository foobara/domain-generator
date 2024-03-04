require "English"

module Foobara
  module Generators
    module DomainGenerator
      class DomainConfig < Foobara::Model
        attributes do
          domain_name :string, :required
          description :string, :allow_nil
          organization_name :string, :allow_nil
          full_module_name :string
        end

        attr_accessor :module_path

        def initialize(attributes = nil, options = {})
          full_module_name = attributes[:full_module_name]
          module_path = full_module_name&.split("::")
          domain_name = attributes[:domain_name]
          description = attributes[:description]
          organization_name = attributes[:organization_name]

          if organization_name.nil? && full_module_name.nil?
            full_module_name = domain_name
            module_path = full_module_name.split("::")

            *organization_parts, domain_name = module_path

            unless organization_parts.empty?
              organization_name = organization_parts.join("::")
            end
          end

          super(
            {
              domain_name:,
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
