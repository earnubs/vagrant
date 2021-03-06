require "vagrant"

module VagrantPlugins
  module GuestTinyCore
    class Plugin < Vagrant.plugin("2")
      name "TinyCore Linux guest."
      description "TinyCore Linux guest support."

      guest("tinycore", "linux")  do
        require File.expand_path("../guest", __FILE__)
        Guest
      end

      guest_capability("tinycore", "configure_networks") do
        require_relative "cap/configure_networks"
        Cap::ConfigureNetworks
      end

      guest_capability("tinycore", "halt") do
        require_relative "cap/halt"
        Cap::Halt
      end
    end
  end
end
