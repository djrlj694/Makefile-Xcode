Pod::Spec.new do |spec|
  spec.name = "${PROJECT}"
  spec.version = "1.0.0"
  spec.summary = "${SUMMARY}"
  spec.homepage = "https://github.com/${GITHUB_USER}/${PROJECT}"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "${AUTHOR}" => '${EMAIL}' }
  spec.social_media_url = "http://twitter.com/${TWITTER_USER}"

  spec.platform = :ios, "12.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/${GITHUB_USER}/${PROJECT}.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "ResourceKit/**/*.{h,swift}"
end
