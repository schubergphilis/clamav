# frozen_string_literal: true

require_relative '../clamav_config'

shared_context 'resources::clamav_config::debian' do
  include_context 'resources::clamav_config'

  let(:config_dir) { '/etc/clamav' }
  let(:user) { 'clamav' }
  let(:group) { 'clamav' }

  shared_examples_for 'any Debian platform' do
    it_behaves_like 'any platform'
  end
end
