RSpec.describe Foobara::Generators::DomainGenerator::GenerateDomain do
  let(:domain_name) { "SomeOrg::SomeDomain::SomeDomain" }

  let(:inputs) do
    {
      domain_name:,
      description: "whatever"
    }
  end
  let(:domain) { described_class.new(inputs) }
  let(:outcome) { domain.run }
  let(:result) { outcome.result }

  it "generates a domain" do
    expect(outcome).to be_success

    domain_file = result["src/some_org/some_domain/some_domain.rb"]
    expect(domain_file).to include("module SomeOrg")
    expect(domain_file).to include("module SomeDomain")
    expect(domain_file).to include("class SomeDomain")
  end

  context "with all options" do
    let(:inputs) do
      {
        domain_name: "SomeDomain",
        description: "whatever",
        organization_name: "SomeOrg",
        domain_name: "SomeDomain",
        full_module_name: "SomeOrg::SomeDomain::SomeDomain"
      }
    end

    it "generates a domain using the given options" do
      expect(outcome).to be_success

      domain_file = result["src/some_org/some_domain/some_domain.rb"]
      expect(domain_file).to include("module SomeOrg")
      expect(domain_file).to include("module SomeDomain")
      expect(domain_file).to include("class SomeDomain")
    end
  end
end
