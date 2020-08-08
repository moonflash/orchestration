# frozen_string_literal: true

RSpec.describe Orchestration::InstallGenerator do
  let(:install_generator) { described_class.new }

  describe '#orchestration_makefile' do
    subject(:makefile) { install_generator.orchestration_makefile }

    let(:dummy_path) { Orchestration.root.join('spec', 'dummy') }
    let(:makefile_path) { dummy_path.join('orchestration', 'Makefile') }

    before { FileUtils.rm_f(makefile_path) }

    it 'creates a Makefile when not present' do
      makefile
      expect(File.exist?(makefile_path)).to be true
    end

    it 'creates a Makefile with expected content' do
      makefile
      content = File.read(makefile_path)
      expect(content).to include '.PHONY: start'
    end

    it 'includes correct wait commands' do
      makefile
      content = File.read(makefile_path)
      expect(content).to include 'wait:'
    end
  end
end
