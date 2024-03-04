module Foobara
  module Generators
    module DomainGenerator
      module Generators
        class DomainGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when DomainConfig
                [
                  Generators::DomainGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          def template_path
            ["src", "domain.rb.erb"]
          end

          def target_path
            *path, file = module_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["src", *path, file]
          end

          alias domain_config relevant_manifest

          def templates_dir
            "#{__dir__}/../templates"
          end

          # TODO: promote this up to base project
          def ==(other)
            # :nocov:
            self.class == other.class && domain_config == other.domain_config
            # :nocov:
          end

          def hash
            domain_config.hash
          end
        end
      end
    end
  end
end
