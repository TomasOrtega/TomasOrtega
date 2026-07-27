#!/usr/bin/env ruby

require "pathname"
require "uri"
require "yaml"

repository = Pathname.new(File.expand_path("..", __dir__))
destination = Pathname.new(ARGV.fetch(0)).expand_path
errors = []

readme = repository.join("README.md").read
index = repository.join("index.md").read
workflow_path = repository.join(".github/workflows/pages.yml")

errors << "README.md must not contain Liquid tags" if readme.match?(/{{|{%/)
errors << "README.md must link to the canonical website" unless readme.include?("https://tomasortega.net")
errors << "index.md must not include README.md" if index.match?(/include_relative\s+README\.md/)
errors << "README.md HTML must remain left-aligned" if readme.lines.any? { |line| line.match?(/\A {4,}</) }

if workflow_path.file?
  workflow = workflow_path.read
  begin
    YAML.safe_load(workflow, aliases: true)
  rescue Psych::SyntaxError => error
    errors << ".github/workflows/pages.yml is invalid YAML: #{error.message}"
  end

  [
    "actions/checkout@v6",
    "ruby/setup-ruby@v1",
    "actions/configure-pages@v5",
    "actions/upload-pages-artifact@v4",
    "actions/deploy-pages@v4",
    "script/check"
  ].each do |required_text|
    errors << ".github/workflows/pages.yml is missing #{required_text}" unless workflow.include?(required_text)
  end
else
  errors << ".github/workflows/pages.yml is missing"
end

readme.scan(/(?:src|href)="([^"]+)"/).flatten.each do |reference|
  next if reference.start_with?("http://", "https://", "#", "mailto:")

  path = repository.join(URI.decode_www_form_component(reference.split(/[?#]/, 2).first))
  errors << "README.md references missing file: #{reference}" unless path.file?
end

asset_sources = [
  repository.join("README.md"),
  repository.join("index.md"),
  repository.join("projects.md"),
  repository.join("_config.yml"),
  *repository.glob("_includes/**/*").select(&:file?),
  *repository.glob("_layouts/**/*").select(&:file?),
  *repository.glob("assets/css/**/*").select(&:file?)
].map(&:read).join("\n")

repository.glob("assets/images/*").select(&:file?).each do |asset|
  errors << "Unused image asset: #{asset.relative_path_from(repository)}" unless asset_sources.include?(asset.basename.to_s)
end

html_files = destination.glob("**/*.html")
errors << "Jekyll did not build any HTML files" if html_files.empty?

html_files.each do |file|
  html = file.read
  h1_count = html.scan(/<h1(?:\s|>)/).length
  errors << "#{file.relative_path_from(destination)} has #{h1_count} h1 elements" unless h1_count == 1

  html.scan(/<img\b[^>]*>/).each do |image|
    errors << "#{file.relative_path_from(destination)} has an image without alt text" unless image.match?(/\balt="[^"]*"/)
  end

  html.scan(/\b(?:href|src)="([^"]+)"/).flatten.each do |reference|
    next if reference.start_with?("http://", "https://", "//", "#", "mailto:", "tel:", "data:")

    path = URI.decode_www_form_component(reference.split(/[?#]/, 2).first)
    next if path.empty?

    target = if path.start_with?("/")
               destination.join(path.delete_prefix("/"))
             else
               file.dirname.join(path)
             end.cleanpath

    candidates = [target]
    candidates << target.join("index.html") if target.directory? || path.end_with?("/")
    candidates << Pathname.new("#{target}.html") if target.extname.empty?

    next if candidates.any?(&:file?)

    errors << "#{file.relative_path_from(destination)} references missing file: #{reference}"
  end
end

stylesheet = destination.join("assets/css/style.css")
errors << "Jekyll did not compile assets/css/style.css" unless stylesheet.file? && !stylesheet.empty?

[
  "DEVELOPMENT.md",
  "Gemfile",
  "Gemfile.lock",
  "README.md",
  "script"
].each do |excluded_path|
  errors << "Jekyll artifact contains development file: #{excluded_path}" if destination.join(excluded_path).exist?
end

if errors.any?
  warn errors.map { |error| "ERROR: #{error}" }.join("\n")
  exit 1
end

puts "Site checks passed."
