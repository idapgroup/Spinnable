Pod::Spec.new do |s|
  s.name      = "Spinnable"
  s.version   = "1.0.0"
  s.swift_version = "4.0"
  s.summary   = "The extension for UIView and UIViewController that provides a convenient way to handle the spinner on the application screen"
  s.description  = "This extension allows elements subscribed to the Spinnable protocol to have access to show and hide spinner functions"
  s.homepage  = "https://github.com/idapgroup/Spinnable"
  s.license   = { :type => "New BSD", :file => "LICENSE" }
  s.author    = { "IDAP Group" => "hello@idapgroup.com" }
  s.source    = { :git => "https://github.com/idapgroup/Spinnable.git",
                  :tag => s.version.to_s }

  # Platform setup
  s.requires_arc          = true
  s.ios.deployment_target = '9.0'

  # Preserve the layout of headers in the Module directory
  s.header_mappings_dir   = 'Spinnable'
  s.source_files          = 'Spinnable/**/*.{swift,h,m,c,cpp}'
end