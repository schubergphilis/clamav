# frozen_string_literal: true

require_relative '../../clamav'

describe 'resources::clamav::ubuntu::16_04' do
  include_context 'resources::clamav'

  let(:platform) { 'ubuntu' }
  let(:platform_version) { '16.04' }

  it_behaves_like 'any platform'
end
