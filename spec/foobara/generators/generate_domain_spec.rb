RSpec.describe Foobara::Generators::DomainGenerator::GenerateDomain do
  let(:name) { "SomeOrg::SomeDomain" }

  let(:inputs) do
    {
      name:,
      description: "whatever"
    }
  end
  let(:domain) { described_class.new(inputs) }
  let(:outcome) { domain.run }
  let(:result) { outcome.result }

  it "generates a domain" do
    expect(outcome).to be_success

    domain_file = result["src/some_org/some_domain.rb"]
    expect(domain_file).to include("module SomeOrg")
    expect(domain_file).to include("module SomeDomain")
  end

  context "with all options" do
    let(:inputs) do
      {
        name: "SomeDomain",
        description: "whatever",
        organization_name: "SomeOrg",
        full_module_name: "SomeOrg::SomeDomain"
      }
    end

    it "generates a domain using the given options" do
      expect(outcome).to be_success

      domain_file = result["src/some_org/some_domain.rb"]
      expect(domain_file).to include("module SomeOrg")
      expect(domain_file).to include("module SomeDomain")
    end
  end
end
