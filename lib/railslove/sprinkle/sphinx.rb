package :sphinx, :provides => :searchengine do
  description 'Sphinx SQL full-text search engine'
  version '0.9.8.1'
  source "http://www.sphinxsearch.com/downloads/sphinx-#{version}.tar.gz"
  requires :sphinx_dependencies
end

package :sphinx_dependencies do
  description 'Sphinx Dependencies'
  apt %w(libaspell-dev aspell-de aspell-en aspell-fr aspell-es)
end
