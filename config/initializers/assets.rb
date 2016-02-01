# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.precompile += %w( date_your_guitar.png )
Rails.application.config.assets.paths << Rails.root.join("app/assets/images")
Rails.application.config.assets.paths << Rails.root.join("app/assets/stylesheets")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompilef += %w( reverb_logo.png )
