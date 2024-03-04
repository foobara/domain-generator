require "pathname"

require_relative "domain_config"

module Foobara
  module Generators
    module DomainGenerator
      class GenerateDomain < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs DomainConfig

        def execute
          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::DomainGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # :nocov:
          "#{__dir__}/../templates"
          # :nocov:
        end

        def add_initial_elements_to_generate
          elements_to_generate << domain_config
        end

        def domain_config
          @domain_config ||= DomainConfig.new(inputs)
        end
      end
    end
  end
end
