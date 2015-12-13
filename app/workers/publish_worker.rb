class PublishWorker
  include Sidekiq::Worker

  def perform(identifier)
    @package = Package.find_by(identifier: identifier)
    g = Git.clone @package.repository, @package.identifier, '/tmp/checkout'
    tag = g.tags.last.name
    manifest = g.object("#{tag}:README.md").contents
  end
end
