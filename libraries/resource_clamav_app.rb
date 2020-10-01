# frozen_string_literal: true
#
# Cookbook:: clamav
# Library:: resource_clamav_app
#
# Copyright:: 2012-2016, Jonathan Hartman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/resource'
require_relative 'helpers_defaults'

class Chef
  class Resource
    # A Chef resource for groups of ClamAV packages.
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class ClamavApp < Resource
      include ClamavCookbook::Helpers::Defaults

      provides :clamav_app

      default_action :install

      #
      # Optionally install a specific version of the ClamAV packages. This
      # assumes that packages will continue to always all be the same version.
      # Different distros use vastly different version strings in their
      # packages, so type checking is about the only validation we can do.
      #
      property :version, String, default: 'latest'

      #
      # Optionally install the dev in addition to base packages.
      #
      property :dev, [true, false], default: false

      #
      # Install the ClamAV packages.
      #
      action :install do
        base_packages.each do |p|
          package p do
            version new_resource.version unless new_resource.version == 'latest'
          end
        end
        new_resource.dev && dev_packages.each do |p|
          package p do
            version new_resource.version unless new_resource.version == 'latest'
          end
        end
      end

      #
      # Upgrade the ClamAV packages.
      #
      action :upgrade do
        base_packages.each do |p|
          package p do
            version new_resource.version unless new_resource.version == 'latest'
            action :upgrade
          end
        end
        new_resource.dev && dev_packages.each do |p|
          package p do
            version new_resource.version unless new_resource.version == 'latest'
            action :upgrade
          end
        end
      end

      #
      # Remove the ClamAV packages
      #
      action :remove do
        (dev_packages + base_packages).each do |p|
          package(p) { action :purge }
        end
      end
    end
  end
end
