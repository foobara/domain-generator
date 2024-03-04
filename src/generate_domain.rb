require "pathname"

require_relative "command_config"

module Foobara
  module Generators
    module CommandGenerator
      class GenerateCommand < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs CommandConfig

        def execute
          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::CommandGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # :nocov:
          "#{__dir__}/../templates"
          # :nocov:
        end

        def add_initial_elements_to_generate
          elements_to_generate << command_config
        end

        def command_config
          @command_config ||= CommandConfig.new(inputs)
        end
      end
    end
  end
end
